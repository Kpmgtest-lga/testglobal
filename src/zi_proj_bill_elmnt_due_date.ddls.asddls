@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Billing Element Billing Due Date'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PROJ_BILL_ELMNT_DUE_DATE
  as select from ZI_ProjBillgElmntDueDateUnion3
{
  key ProjectBillingElementUUID,
      min( DueBillingDate ) as DueBillingDate
}
group by
  ProjectBillingElementUUID
