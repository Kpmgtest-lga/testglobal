@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Output Request Item Status Text'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view entity ZI_OutputRequestItemStatusText
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T ( p_domain_name : 'APOC_OR_OUTPUT_STATUS' )
//  association [0..1] to I_OutputRequestItemStatus as _OutputRequestItemStatus on $projection.OutputRequestItemStatus = _OutputRequestItemStatus.OutputRequestItemStatus
  association [0..1] to I_Language                as _Language                on $projection.Language = _Language.Language
{
//      @ObjectModel.foreignKey.association: '_OutputRequestItemStatus'
      @EndUserText.label: 'Status'
  key value_low as OutputRequestItemStatus,

      @Semantics.language
      @ObjectModel.foreignKey.association: '_Language'
  key language as Language,
  key domain_name,
  key value_position,
      @Semantics.text
      @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold: 1,
      ranking: #LOW
      }
      text     as OutputRequestItemStatusDescr,

      //Associations
//      _OutputRequestItemStatus,
      _Language
}
