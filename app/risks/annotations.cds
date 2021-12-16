using RiskService as service from '../../srv/risk-service';

// annotate service.Risks with @(
//     UI.LineItem : [
//         {
//             $Type : 'UI.DataField',
//             Label : 'title',
//             Value : title,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'prio',
//             Value : prio,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'descr',
//             Value : descr,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'impact',
//             Value : impact,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'criticality',
//             Value : criticality,
//         },
//     ]
// );
// annotate service.Risks with @(
//     UI.FieldGroup #GeneratedGroup1 : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'title',
//                 Value : title,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'prio',
//                 Value : prio,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'descr',
//                 Value : descr,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'impact',
//                 Value : impact,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'criticality',
//                 Value : criticality,
//             },
//         ],
//     },
//     UI.Facets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'GeneratedFacet1',
//             Label : 'General Information',
//             Target : '@UI.FieldGroup#GeneratedGroup1',
//         },
//     ]
// );

annotate service.Risks with {
    title  @title : 'Title';
    prio   @title : 'Priority';
    descr  @title : 'Description';
    miti   @title : 'Mitigation';
    impact @title : 'Impact';
}

annotate service.Mitigations with {
    ID          @(
        UI.Hidden,
        Common : {Text : description}
    );
    description @title : 'Description';
    owner       @title : 'Owner';
    timeline    @title : 'Timeline';
    risks       @title : 'Risks';
}

annotate service.Risks with @(UI : {
    HeaderInfo       : {
        TypeName       : 'Risk',
        TypeNamePlural : 'Risks',
        Title          : {
            $Type : 'UI.DataField',
            Value : title
        },
        Description    : {
            $Type : 'UI.DataField',
            Value : descr
        }
    },
    SelectionFields  : [prio],
    LineItem         : [
        {Value : title},
        {Value : miti_ID},
        {
            Value       : prio,
            Criticality : criticality
        },
        {
            Value       : impact,
            Criticality : criticality
        }
    ],
    Facets           : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : 'Main',
        Target : '@UI.FieldGroup#Main'
    }],
    FieldGroup #Main : {Data : [
        {Value : miti_ID},
        {
            Value       : prio,
            Criticality : criticality
        },
        {
            Value       : impact,
            Criticality : criticality
        }
    ]}
}, );

annotate service.Risks with {
    miti @(Common : {
        //show text, not id for mitigation in the context of risks
        Text            : miti.description,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : 'Mitigations',
            CollectionPath : 'Mitigations',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : miti_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                }
            ]
        }
    });
}
