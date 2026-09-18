@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Details of Billing Element'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_ProjectBillingElement
  as select from    I_ProjectBillingElement        as ProjectBillingElement

    left outer join I_SDBillingPlan                as SDBillingPlan         on ProjectBillingElement.BillingPlan = SDBillingPlan.BillingPlan


    left outer join I_BillingPlanUsageCategoryText as PlanUsageCategoryText on  PlanUsageCategoryText.BillingPlanUsageCategory = SDBillingPlan.BillingPlanUsageCategory
                                                                            and PlanUsageCategoryText.Language                 = $session.system_language

  association [1..1] to I_SalesDocumentItem        as _SalesOrderItem           on  ProjectBillingElement.SalesDocument     = _SalesOrderItem.SalesDocument
                                                                                and ProjectBillingElement.SalesDocumentItem = _SalesOrderItem.SalesDocumentItem

  association [1..1] to I_SalesDocument            as _SalesOrder               on  ProjectBillingElement.SalesDocument = _SalesOrder.SalesDocument

  association [1..1] to I_EnterpriseProjectElement as _EnterpriseProjectElement on  ProjectBillingElement.ProjectElementUUID = _EnterpriseProjectElement.ProjectElementUUID
  association [1..1] to I_EnterpriseProject        as _EnterpriseProject        on  ProjectBillingElement.ProjectUUID = _EnterpriseProject.ProjectUUID

  //  association [0..1] to I_PrjBlgElmBllbleRevnAmt as _PrjBlgElmBllbleRevnAmt on  ProjectBillingElement.ProjectBillingElementUUID = _PrjBlgElmBllbleRevnAmt.ProjectBillingElementUUID

  //association [0..1] to I_SDBillingPlan                as _SDBillingPlan                on  $projection.BillingPlan = _SDBillingPlan.BillingPlan
  //association [1..1] to I_BillingPlanUsageCategoryText  as _PlanUsageCategoryText       on  ProjectBillingElement.BillingPlanUsageCategory = _PlanUsageCategoryText.BillingPlanUsageCategory
  //                                                                                     and  _PlanUsageCategoryText.Language = $session.system_language
{
  key ProjectBillingElement.ProjectBillingElementUUID,
      ProjectBillingElement.DocumentCurrency,

      @ObjectModel.foreignKey.association:null
      ProjectBillingElement.SalesDocument                                                              as SalesDocument,
      @ObjectModel.foreignKey.association:null
      ProjectBillingElement.SalesDocumentItem                                                          as SalesDocumentItem,

      @ObjectModel.foreignKey.association: '_EnterpriseProject'
      ProjectBillingElement.ProjectUUID                                                                as ProjectUUID,
      @ObjectModel.foreignKey.association: '_EnterpriseProjectElement'
      ProjectBillingElement.ProjectElementUUID                                                         as ProjectElementUUID,

      ProjectBillingElement._EnterpriseProject.Project                                                 as Project,

      cast( ProjectBillingElement._EnterpriseProjectElement.ProjectElement as char24 preserving type ) as WBSElementExternalID,
      //    Pendiente crear un elemento de datos Z o buscar una alternativa si el dato sale mal porque el ED correcto es ps_posid_edit
      //  cast( _EnterpriseProjectElement.ProjectElement as ps_posid_edit preserving type )
  
      ProjectBillingElement.BillingPlan                                                                as BillingPlan,

      SDBillingPlan.BillingPlanUsageCategory                                                           as BillingPlanUsageCategory,

      PlanUsageCategoryText.BillingPlanUsageCategoryName                                               as BillingPlanUsageCategoryName,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      _SalesOrderItem.CappedNetAmount                                                                  as CappedNetAmount,

      _SalesOrderItem.SalesDocumentItemText                                                            as SalesDocumentItemText, //Billing Item Description WBSElementDescription

      _EnterpriseProject.EnterpriseProjectServiceOrg                                                   as EngagementProjectServiceOrg, //Service Organization

      // _PlanUsageCategoryText.BillingPlanUsageCategoryName,
      // _PlanUsageCategoryText.BillingPlanUsageCategoryName,
      // _SDBillingPlan._BillingPlanUsageCategory._Text.BillingPlanUsageCategoryName ,

      ////  @UI: { lineItem: [ { position: 60, importance: #HIGH } ] }
      //                        @EndUserText.label: 'Planned Revenue'
      //                        @EndUserText.quickInfo: 'Planned Revenue'
      //                        @Semantics.amount.currencyCode: 'TransactionCurrency'
      //                        @Consumption.filter.hidden: false
      //                        @ObjectModel.virtualElementCalculatedBy:'ABAP:CL_PBE_VIRTUALFIELDS'
      //                        //@ObjectModel.sort.transformedBy: 'ABAP:CL_PBE_VIRTUALFIELDS_SORT'
      //  virtual               PlndRevnAmt                   : abap.curr( 23, 2 ),


      //_SDBillingPlan,
      _SalesOrder,
      _SalesOrderItem,
      _EnterpriseProjectElement,
      _EnterpriseProject
      //      _PrjBlgElmBllbleRevnAmt

      // _PlanUsageCategoryText
}
