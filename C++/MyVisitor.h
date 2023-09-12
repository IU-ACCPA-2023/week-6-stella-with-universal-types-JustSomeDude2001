//
// Created by justsomedude on 23.03.23.
//

#include "Stella/Absyn.H"
#include <map>
#include <string>
#include <vector>
#include <stack>
#include "StoredType.h"
#include "Consts.h"
#include "iostream"

namespace Stella {
    class MyVisitor : public Visitor {
    public:

        // Tracks scope during execution.
        int current_scope = 0;

        // Visitor must have memory of what it gathered to resolve declarations, function calls, etc.
        std::vector <StoredType> contextStack = {};

        // Simple map of identifiers with their types matched.
        // Since shadowing and scopes are a thing, we will look at top type always.
        std::map <std::string, std::vector<StoredType> > identMap;

        // Some types require extensions. Some extensions include each other (pairs are tuples),
        // hence there will be several extensions that might enable use of type.
        std::map <VisitableTag, std::vector<std::string> > extensionRequirements;
        std::map <std::string, bool> activeExtensions;

        MyVisitor() {
            // Add in some built-in functions.

            /*
            identMap["succ"].push_back(StoredType(VisitableTag::tagTypeFunction,
                                                  -1,
                                                  {ST_NAT},
                                                  {ST_NAT}));
            */
            // TO-DO - most built-in functions do not require specific visit functions.
            // They can be handled as simple applications. Figure that out in the future.

            extensionRequirements[VisitableTag::tagTypeUnit].push_back("unit-type");
        }

        /**
         * Collapse a series of types to single type.
         * Used for match cases.
         *
         * @param types
         * @return
         */
        static StoredType collapseTypes(std::vector <StoredType> types) {
            if (types[0].tag == VisitableTag::tagTypeSumType) {
                StoredType result = ST_SUMTYPE;
                for (int i = 0; i < types.size(); i++) {
                    if (types[i].tag != VisitableTag::tagTypeSumType) {
                        return ST_PLACEHOLDER;
                    }
                    for (int j = 0; j < 2; j++) {
                        if (result.contentTypes[j] == ST_PLACEHOLDER) {
                            result.contentTypes[j] = types[i].contentTypes[j];
                        }
                    }
                }
                for (int i = 0; i < types.size(); i++) {
                    for (int j = 0; j < 2; j++) {
                        if (result.contentTypes[j] == ST_PLACEHOLDER) {
                            continue;
                        }
                        if (types[i].contentTypes[j] == ST_PLACEHOLDER) {
                            continue;
                        }
                        if (types[i].contentTypes[j] != result.contentTypes[j]) {
                            return ST_PLACEHOLDER;
                        }
                    }
                }
                return result;
            } else {
                StoredType result = types[0];
                for (int i = 0; i < types.size(); i++) {
                    if (result != types[i]) {
                        return ST_PLACEHOLDER;
                    }
                }
                return result;
            }
        }


        /**
         * Obtain top item from context stack with specified tag.
         * Returns nullptr if no item with such tag.
         *
         * @param targetTag
         * @return
         */
        StoredType* getTopTag(VisitableTag targetTag, int maxScope = 1e9) {
            for (int i = contextStack.size() - 1; i >= 0; i--) {
                if (maxScope >= contextStack[i].scope && contextStack[i].tag == targetTag) {
                    return &contextStack[i];
                }
            }
            return nullptr;
        }

        /**
         * This is a simple method for checking whether a return/arg type matches
         * with the actual type. This is used to handle inr and inl specifically
         * along with normal types.
         *
         * It uses bitmasks
         * 00 = 0 = items are not subtypes of each other.
         * 01 = 1 = target is subtype
         * 10 = 2 = actual is subtype
         * 11 = 3 = both subtypes of each other and are equal
         *
         * @param target
         * @param actual
         * @return
         */
        static int checkMatch(StoredType target, StoredType actual) {
            if (target.tag == VisitableTag::tagTypePanic || actual.tag == VisitableTag::tagTypePanic) {
                return 3;
            }
            if (target.tag == VisitableTag::tagTypeGenericType && actual.tag == target.tag) {
                if (target.typeIdent != actual.typeIdent) {
                    return 0;
                } else {
                    return 3;
                }
            }
            if (target.tag == VisitableTag::tagTypeSumType && actual.tag == VisitableTag::tagTypeSumType) {
                int result = 3;
                for (int j = 0; j < 2; j++) {
                    if (target.contentTypes[j] == ST_PLACEHOLDER ||
                        actual.contentTypes[j] == ST_PLACEHOLDER) {
                        continue;
                    } else {
                        int ret = checkMatch(target.contentTypes[j], actual.contentTypes[j]);
                        result &= ret;
                    }
                }
                return result;
            } else {
                int result = 3;

                if (target.tag != actual.tag) {
                    return 0;
                }
                if (target.argsTypes.size() != actual.argsTypes.size()) {
                    return 0;
                }
                if (target.returnTypes.size() != actual.returnTypes.size()) {
                    return 0;
                }
                bool isRecord = (target.tag == VisitableTag::tagTypeRecord);

                if (isRecord) {
                    bool actualIsSubtype = true;
                    bool targetIsSubtype = true;
                    for (auto j : actual.contentTypes) {
                        bool foundMatch = false;
                        for (auto i : target.contentTypes) {
                            int ret = checkMatch(i, j);
                            if (i.ident == j.ident && (ret & 1)) {
                                foundMatch = true;
                                break;
                            }
                        }
                        if (!foundMatch) {
                            targetIsSubtype = false;
                            break;
                        }
                    }
                    for (auto i : target.contentTypes) {
                        bool foundMatch = false;
                        for (auto j : actual.contentTypes) {
                            int ret = checkMatch(i, j);
                            if (i.ident == j.ident && (ret & 2)) {
                                foundMatch = true;
                                break;
                            }
                        }
                        if (!foundMatch) {
                            actualIsSubtype = false;
                            break;
                        }
                    }

                    if (!targetIsSubtype && (result & 1)) {
                        result -= 1;
                    }
                    if (!actualIsSubtype && (result & 2)) {
                        result -= 2;
                    }
                    return result;
                } else {
                    if (target.contentTypes.size() != actual.contentTypes.size()) {
                        return 0;
                    }
                    for (int i = 0; i < target.contentTypes.size(); i++) {
                        int ret = checkMatch(target.contentTypes[i], actual.contentTypes[i]);
                        result &= ret;
                    }
                }
                // argsRes and retRes inversion exist for subtyping of functions
                int argsRes = 3;
                for (int i = 0; i < target.argsTypes.size(); i++) {
                    int ret = checkMatch(target.argsTypes[i], actual.argsTypes[i]);
                    argsRes &= ret;
                }
                int retRes = 3;
                for (int i = 0; i < target.returnTypes.size(); i++) {
                    int ret = checkMatch(target.returnTypes[i], actual.returnTypes[i]);
                    retRes &= ret;
                }
                if (argsRes == 2 || argsRes == 1) {
                    argsRes ^= 3;
                }
                if (retRes == 2 || retRes == 1) {
                    retRes ^= 3;
                }
                result &= argsRes;
                result &= retRes;
                return result;
            }
        }

        /**
         * This is a simple method for checking whether a vector of return/arg types
         * matches with the actual types. This is used to handle inr and inl specifically
         * along with normal types.
         *
         * It uses bitmasks
         * 00 = 0 = items are not subtypes of each other.
         * 01 = 1 = target is subtype
         * 10 = 2 = actual is subtype
         * 11 = 3 = both subtypes of each other and are equal
         *
         * @param target
         * @param actual
         * @return
         */
        static int checkMatch(std::vector<StoredType> target, std::vector<StoredType> actual) {
            if (target.size() != actual.size()) {
                return 0;
            }
            int result = 3;
            for (int i = 0; i < target.size(); i++) {
                int ret = checkMatch(target[i], actual[i]);
                result &= ret;
            }
            return result;
        }

        bool isTypeAllowed(VisitableTag t) {
            // TO-DO implement extension fulfillment check
            // don't really get why would that not be caught during parsing,
            // but we live with what we have.
            return true;
        }

        /**
         * Replaces idents on top of @contextStack starting from @start with their corresponding StoredType.
         *
         * @param start
         */
        void resolveIdents(int start = 0) {
            for (int i = start; i < contextStack.size(); i++) {
                if (contextStack[i].tag == VisitableTag::tagTypeIdent) {
                    if (identMap[contextStack[i].ident].empty()) {
                        std::cout << "Unresolved identifier " << contextStack[i].ident << '\n';
                        exit(1);
                    }
                    StoredType result = identMap[contextStack[i].ident].back();
                    result.ident = contextStack[i].ident;
                    contextStack[i] = result;
                    std::cout << "Resolved ident " << result.ident << '\n';
                }
            }
        }

        /**
         * Purges(removes) idents that are of scope higher than @current_scope from @identMap
         */
        void purgeIdents() {
            for (auto it = identMap.begin(); it != identMap.end(); it++) {
                while (!it->second.empty() && it->second.back().scope > current_scope) {
                    it->second.pop_back();
                }
            }
        }


        /**
         * Increases scope safely
         */
        void increaseScope() {
            current_scope++;
        }

        /**
         * Decreases scope safely
         */
        void decreaseScope() {
            current_scope--;
            purgeIdents();
        }

        /**
         * Safely downsizes @contextStack to @targetSize.
         * Call it to remove items that have been resolved to a singular item.
         *
         * @param targetSize
         */
        void cutContextStack(int targetSize) {
            if(targetSize < contextStack.size()) {
                contextStack.resize(targetSize);
            }
        }

        void visitProgram(Program *p);
        void visitLanguageDecl(LanguageDecl *p);
        void visitExtension(Extension *p);
        void visitDecl(Decl *p);
        void visitLocalDecl(LocalDecl *p);
        void visitAnnotation(Annotation *p);
        void visitParamDecl(ParamDecl *p);
        void visitReturnType(ReturnType *p);
        void visitThrowType(ThrowType *p);
        void visitType(Type *p);
        void visitMatchCase(MatchCase *p);
        void visitOptionalTyping(OptionalTyping *p);
        void visitPatternData(PatternData *p);
        void visitExprData(ExprData *p);
        void visitPattern(Pattern *p);
        void visitLabelledPattern(LabelledPattern *p);
        void visitBinding(Binding *p);
        void visitExpr(Expr *p);
        void visitPatternBinding(PatternBinding *p);
        void visitVariantFieldType(VariantFieldType *p);
        void visitRecordFieldType(RecordFieldType *p);
        void visitTyping(Typing *p);
        void visitAProgram(AProgram *p);
        void visitLanguageCore(LanguageCore *p);
        void visitAnExtension(AnExtension *p);
        void visitDeclFun(DeclFun *p);
        void visitDeclTypeAlias(DeclTypeAlias *p);
        void visitDeclExceptionType(DeclExceptionType *p);
        void visitDeclExceptionVariant(DeclExceptionVariant *p);
        void visitALocalDecl(ALocalDecl *p);
        void visitInlineAnnotation(InlineAnnotation *p);
        void visitAParamDecl(AParamDecl *p);
        void visitNoReturnType(NoReturnType *p);
        void visitSomeReturnType(SomeReturnType *p);
        void visitNoThrowType(NoThrowType *p);
        void visitSomeThrowType(SomeThrowType *p);
        void visitAMatchCase(AMatchCase *p);
        void visitNoTyping(NoTyping *p);
        void visitSomeTyping(SomeTyping *p);
        void visitNoPatternData(NoPatternData *p);
        void visitSomePatternData(SomePatternData *p);
        void visitNoExprData(NoExprData *p);
        void visitSomeExprData(SomeExprData *p);
        void visitPatternVariant(PatternVariant *p);
        void visitPatternInl(PatternInl *p);
        void visitPatternInr(PatternInr *p);
        void visitPatternTuple(PatternTuple *p);
        void visitPatternRecord(PatternRecord *p);
        void visitPatternList(PatternList *p);
        void visitPatternCons(PatternCons *p);
        void visitPatternFalse(PatternFalse *p);
        void visitPatternTrue(PatternTrue *p);
        void visitPatternUnit(PatternUnit *p);
        void visitPatternInt(PatternInt *p);
        void visitPatternSucc(PatternSucc *p);
        void visitPatternVar(PatternVar *p);
        void visitALabelledPattern(ALabelledPattern *p);
        void visitABinding(ABinding *p);
        void visitSequence(Sequence *p);
        void visitAssign(Assign *p);
        void visitIf(If *p);
        void visitLet(Let *p);
        void visitLetRec(LetRec *p);
        void visitAPatternBinding(APatternBinding *p);
        void visitLessThan(LessThan *p);
        void visitLessThanOrEqual(LessThanOrEqual *p);
        void visitGreaterThan(GreaterThan *p);
        void visitGreaterThanOrEqual(GreaterThanOrEqual *p);
        void visitEqual(Equal *p);
        void visitNotEqual(NotEqual *p);
        void visitTypeAsc(TypeAsc *p);
        void visitTypeCast(TypeCast *p);
        void visitAbstraction(Abstraction *p);
        void visitVariant(Variant *p);
        void visitMatch(Match *p);
        void visitList(List *p);
        void visitAdd(Add *p);
        void visitSubtract(Subtract *p);
        void visitLogicOr(LogicOr *p);
        void visitMultiply(Multiply *p);
        void visitDivide(Divide *p);
        void visitLogicAnd(LogicAnd *p);
        void visitRef(Ref *p);
        void visitDeref(Deref *p);
        void visitApplication(Application *p);
        void visitDotRecord(DotRecord *p);
        void visitDotTuple(DotTuple *p);
        void visitTuple(Tuple *p);
        void visitRecord(Record *p);
        void visitConsList(ConsList *p);
        void visitHead(Head *p);
        void visitIsEmpty(IsEmpty *p);
        void visitTail(Tail *p);
        void visitPanic(Panic *p);
        void visitThrow(Throw *p);
        void visitTryCatch(TryCatch *p);
        void visitTryWith(TryWith *p);
        void visitInl(Inl *p);
        void visitInr(Inr *p);
        void visitSucc(Succ *p);
        void visitLogicNot(LogicNot *p);
        void visitPred(Pred *p);
        void visitIsZero(IsZero *p);
        void visitFix(Fix *p);
        void visitNatRec(NatRec *p);
        void visitFold(Fold *p);
        void visitUnfold(Unfold *p);
        void visitConstTrue(ConstTrue *p);
        void visitConstFalse(ConstFalse *p);
        void visitConstUnit(ConstUnit *p);
        void visitConstInt(ConstInt *p);
        void visitConstMemory(ConstMemory *p);
        void visitVar(Var *p);
        void visitTypeFun(TypeFun *p);
        void visitTypeRec(TypeRec *p);
        void visitTypeSum(TypeSum *p);
        void visitTypeTuple(TypeTuple *p);
        void visitTypeRecord(TypeRecord *p);
        void visitTypeVariant(TypeVariant *p);
        void visitTypeList(TypeList *p);
        void visitTypeBool(TypeBool *p);
        void visitTypeNat(TypeNat *p);
        void visitTypeUnit(TypeUnit *p);
        void visitTypeTop(TypeTop *p);
        void visitTypeBottom(TypeBottom *p);
        void visitTypeRef(TypeRef *p);
        void visitTypeVar(TypeVar *p);
        void visitAVariantFieldType(AVariantFieldType *p);
        void visitARecordFieldType(ARecordFieldType *p);
        void visitATyping(ATyping *p);
        void visitListStellaIdent(ListStellaIdent *p);
        void visitListExtensionName(ListExtensionName *p);
        void visitListExtension(ListExtension *p);
        void visitListDecl(ListDecl *p);
        void visitListLocalDecl(ListLocalDecl *p);
        void visitListAnnotation(ListAnnotation *p);
        void visitListParamDecl(ListParamDecl *p);
        void visitListType(ListType *p);
        void visitListMatchCase(ListMatchCase *p);
        void visitListPattern(ListPattern *p);
        void visitListLabelledPattern(ListLabelledPattern *p);
        void visitListBinding(ListBinding *p);
        void visitListExpr(ListExpr *p);
        void visitListPatternBinding(ListPatternBinding *p);
        void visitListVariantFieldType(ListVariantFieldType *p);
        void visitListRecordFieldType(ListRecordFieldType *p);

        void visitDeclFunGeneric(DeclFunGeneric *p);
        void visitTypeAbstraction(TypeAbstraction *p);
        void visitTypeApplication(TypeApplication *p);
        void visitTypeForAll(TypeForAll *p);

        void visitInteger(Integer x);
        void visitChar(Char x);
        void visitDouble(Double x);
        void visitString(String x);
        void visitIdent(Ident x);
        void visitStellaIdent(StellaIdent x);
        void visitExtensionName(ExtensionName x);
        void visitMemoryAddress(MemoryAddress x);
    };
}
