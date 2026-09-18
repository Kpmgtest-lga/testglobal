@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Proj.Bill.Elmnt. Due Date Union (3)'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_ProjBillgElmntDueDateUnion3
  as select from I_ProjectBillingElement as NoDate
{
  key NoDate.ProjectBillingElementUUID,
      cast( abap.char'99991231' as fkdat ) as DueBillingDate
}

union all select from ZI_ProjBillElmntMaxBillDate3 as MaxDate
{
  key MaxDate.ProjectBillingElementUUID,
      MaxDate.BillingPlanBillingDate as DueBillingDate
}
where
  MaxDate.BillingPlanBillingDate is not null

union all select from ZI_ProjBillElmntMinBillDate3 as MinDate
{
  key MinDate.ProjectBillingElementUUID,
      MinDate.BillingPlanBillingDate as DueBillingDate
}
where
  MinDate.BillingPlanBillingDate is not null
