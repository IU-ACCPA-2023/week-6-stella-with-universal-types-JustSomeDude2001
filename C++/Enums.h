//
// Created by justsomedude on 25.03.23.
//
namespace Stella {
    enum VisitableTag {
        tagTypePlaceholder,

        tagTypeBool,
        tagTypeNat,
        tagTypeUnit,
        tagTypeTuple,

        tagTypeSumType,

        tagTypeFunction,
        tagTypeIdent,

        tagTypePanic,

        tagTypeRecord,

        tagTypeRef,

        tagTypeGenericType
    };
}