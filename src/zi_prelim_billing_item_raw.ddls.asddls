@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Preliminary Billing Doc. Item RAW'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PRELIM_BILLING_ITEM_RAW
  as select from I_BillingDocumentItemBasic
  association [0..1] to I_EnterpriseProjectElement                 as _WBSElementBasicData           on  $projection.WBSElementInternalID = _WBSElementBasicData.WBSElementInternalID
  
{
  key BillingDocument as prelimbillingdocument,
  key BillingDocumentItem as prelimbillingdocumentitem,
      ReferenceSDDocument as referencedocument,
      WBSElement,
      WBSElementInternalID,
      _WBSElementBasicData.ProjectElement                      as WBSElementExternalID,
      _WBSElementBasicData._Project.Project                    as ProjectExternalID      
}
where
  SDDocumentCategory = 'PBD'
