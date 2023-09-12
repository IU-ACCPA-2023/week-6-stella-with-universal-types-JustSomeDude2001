//
// Created by justsomedude on 26.03.23.
//

#ifndef WEEK_1_TYPECHECKER_FOR_STELLA_CORE_JUSTSOMEDUDE2001_STOREDTYPE_H
#define WEEK_1_TYPECHECKER_FOR_STELLA_CORE_JUSTSOMEDUDE2001_STOREDTYPE_H

#include "Enums.h"
#include <vector>
#include <string>
#include <iostream>


namespace Stella {

    /**
     * This class allows storage of any object we might encounter while traversing AST.
     */
    class StoredType {
    public:
        // tag determines what kind of object is it - a specific variable, function, or unresolved ident.
        VisitableTag tag;

        int scope;

        // some items might have value. Stored here.
        int nat_value = -1;

        // ident is only relevant for when tag is tagTypeIdent.
        std::string ident = "";

        // Only relevant for when dealing with generic types.
        std::string typeIdent = "";
        bool resolved = false;

        // argsTypes and returnTypes are only present in functions.
        std::vector<StoredType> argsTypes = {};
        std::vector<StoredType> returnTypes = {};

        // This is used for generic functions.
        std::vector<StoredType> genericTypes = {};

        // contentTypes are only present in tuples and lists.
        std::vector<StoredType> contentTypes = {};

        StoredType(VisitableTag _tag, int _scope) {
            tag = _tag;
            scope = _scope;
        }

        StoredType(VisitableTag _tag = VisitableTag::tagTypeNat,
                   int _scope = 0,
                   std::vector<StoredType> _argsTypes = {},
                   std::vector<StoredType> _returnTypes = {},
                   std::vector<StoredType> _contentTypes = {}) {
            tag = _tag;
            scope = _scope;
            argsTypes = _argsTypes;
            returnTypes = _returnTypes;
            contentTypes = _contentTypes;
        }


        /**
         * Comparator for StoredType is recursive to allow for handling any level of
         * function nesting in arguments.
         *
         * Note that comparator only compares tags and tags of argsTypes and returnTypes.
         * It will believe that different items of same type are identical.
         * Intended to be used for checking for argument or parameter mismatches.
         *
         * @param b
         * @return
         */
        bool operator==(const StoredType& b) {
            if (tag != b.tag ||
                argsTypes.size() != b.argsTypes.size() ||
                returnTypes.size() != b.returnTypes.size() ||
                contentTypes.size() != b.contentTypes.size()) {
                return false;
            }
            for (int i = 0; i < b.argsTypes.size(); i++) {
                if (argsTypes[i] == b.argsTypes[i]) {
                    continue;
                } else {
                    return false;
                }
            }
            for (int i = 0; i < b.returnTypes.size(); i++) {
                if (returnTypes[i] == b.returnTypes[i]) {
                    continue;
                } else {
                    return false;
                }
            }
            for (int i = 0; i < b.contentTypes.size(); i++) {
                if (contentTypes[i] == b.contentTypes[i]) {
                    continue;
                } else {
                    return false;
                }
            }

            return true;
        }

        bool operator!=(const StoredType& b) {
            return !(this->operator==(b));
        }

        StoredType& operator= (const StoredType &b) {
            tag = b.tag;
            scope = b.scope;
            argsTypes = b.argsTypes;
            returnTypes = b.returnTypes;
            contentTypes = b.contentTypes;
            genericTypes = b.genericTypes;
            nat_value = b.nat_value;
            typeIdent = b.typeIdent;
            resolved = b.resolved;
            return *this;
        }

        void deepGenericApplication(std::string target, StoredType replacer) {
            if (resolved)
                return;
            for (int i = 0; i < genericTypes.size(); i++) {
                if (genericTypes[i].typeIdent == target)
                    return;
            }
            if (tag == VisitableTag::tagTypeGenericType && typeIdent == target) {
                operator=(replacer);
                resolved = true;
            } else {
                for (int i = 0; i < argsTypes.size(); i++) {
                    argsTypes[i].deepGenericApplication(target, replacer);
                }
                for (int i = 0; i < returnTypes.size(); i++) {
                    returnTypes[i].deepGenericApplication(target, replacer);
                }
                for (int i = 0; i < contentTypes.size(); i++) {
                    contentTypes[i].deepGenericApplication(target, replacer);
                }
            }
        }

        /**
         * Debug output method.
         */
        void print() {
            std::cout << "\n===============\n";
            std::cout << "Ident:      " << ident << '\n';
            std::cout << "TypeIdent:  " << typeIdent << '\n';
            std::cout << "Tag:        " << tag << '\n';
            std::cout << "ArgTags:     ";
            for (int i = 0; i < argsTypes.size(); i++) {
                std::cout << argsTypes[i].tag << " ";
            } std::cout << '\n';
            std::cout << "ReturnTags:  ";
            for (int i = 0; i < returnTypes.size(); i++) {
                std::cout << returnTypes[i].tag << " ";
            } std::cout << '\n';
            std::cout << "ContentTags: ";
            for (int i = 0; i < contentTypes.size(); i++) {
                std::cout << contentTypes[i].tag << " ";
            } std::cout << '\n';
            std::cout << "GenericTypeTags: ";
            for (int i = 0; i < genericTypes.size(); i++) {
                std::cout << genericTypes[i].tag << " ";
            } std::cout << '\n';
            std::cout << "\n===============\n";
        }
    };
} // Stella

#endif //WEEK_1_TYPECHECKER_FOR_STELLA_CORE_JUSTSOMEDUDE2001_STOREDTYPE_H
