@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Proj.Bill.Elmnt. Min Bill. Due Date (3)'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_ProjBillElmntMinBillDate3
  as select from ZI_ProjBillElmntMaxBillDate3 as MaxBillDate
  association [0..*] to ZI_ProjBillgElmntBillgPlanItem as _OpenBPTtem on  MaxBillDate.ProjectBillingElementUUID = _OpenBPTtem.ProjectBillingElementUUID
                                                                     and _OpenBPTtem.BillingPlanBillingDate    > $session.user_date
{
  key MaxBillDate.ProjectBillingElementUUID,
      min(_OpenBPTtem.BillingPlanBillingDate) as BillingPlanBillingDate
}
where
  MaxBillDate.BillingPlanBillingDate is null
group by
  MaxBillDate.ProjectBillingElementUUID
