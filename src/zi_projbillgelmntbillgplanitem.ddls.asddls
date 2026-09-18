@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Billing Element Billing Plan Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_ProjBillgElmntBillgPlanItem
  as select from I_ProjectBillingElement as ProjectBillingElement
  association of exact one to many I_SDBillingPlanItem as _SDBillingPlanItem on  ProjectBillingElement.BillingPlan                = _SDBillingPlanItem.BillingPlan
                                                                             and _SDBillingPlanItem.BillingPlanRelatedBillgStatus = 'A'
                                                                             and _SDBillingPlanItem.BillingPlanItemUsage_2        = ''
{
  key ProjectBillingElement.ProjectBillingElementUUID,
  key _SDBillingPlanItem.BillingPlanBillingDate,
      _SDBillingPlanItem.BillingPlanUsageCategory
}
where
  ProjectBillingElement.BillingPlan is not initial
