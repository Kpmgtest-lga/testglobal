@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Get Single Billing Request'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TmpProjectBillingRequest
  as select distinct from I_ProjectBillingRequestItem
{

  key ProjectBillingElementUUID,
  key ProjectBillingRequestUUID,
      _ProjectBillingRequest.ProjectBillingRequest       as ProjectBillingRequest,
      _ProjectBillingRequest.ProjectBillingRequestStatus as ProjectBillingRequestStatus
}
where
  _ProjectBillingRequest.ProjectBillingRequestStatus = 'C'
