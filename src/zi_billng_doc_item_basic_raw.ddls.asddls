@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billing Document Item RAW'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_BILLNG_DOC_ITEM_BASIC_RAW
  as select from I_BillingDocumentItemBasic

//  association       to ZI_BD_OUTPUT_REQUEST_STATUS as _BillingDocument  on  $projection.BillingDocument = _BillingDocument.BillingDocument

  association [0..1] to I_EnterpriseProjectElement                 as _WBSElementBasicData           on  $projection.WBSElementInternalID = _WBSElementBasicData.WBSElementInternalID

{
  key   BillingDocument,
  key   BillingDocumentItem,
  WBSElement,
  WBSElementInternalID,
  _WBSElementBasicData.ProjectElement                      as WBSElementExternalID,
  _WBSElementBasicData._Project.Project                    as ProjectExternalID,
  ReferenceSDDocument,
  ReferenceSDDocumentCategory
//  _BillingDocument.BillingDocumentIsCancelled,
//  _BillingDocument.BillingDocumentIsTemporary,
//  Associations
//    _BillingDocument
}
//where
//  _BillingDocument.BillingDocumentIsTemporary = ' '
//  and _BillingDocument.BillingDocumentIsCancelled = ' '   
