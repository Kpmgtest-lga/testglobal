@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Proj.Bill.Elmnt. Max Bill. Due Date (3)'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_ProjBillElmntMaxBillDate3
  as select from I_ProjectBillingElement as ProjectBillingElement
  association [0..*] to ZI_ProjBillgElmntBillgPlanItem as _OpenBPTtem on  ProjectBillingElement.ProjectBillingElementUUID = _OpenBPTtem.ProjectBillingElementUUID
                                                                     and _OpenBPTtem.BillingPlanBillingDate              <= $session.user_date
{
  key ProjectBillingElement.ProjectBillingElementUUID,
      max(_OpenBPTtem.BillingPlanBillingDate) as BillingPlanBillingDate
}
group by
  ProjectBillingElement.ProjectBillingElementUUID
