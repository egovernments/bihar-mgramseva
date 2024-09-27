initRequestBody(tenantId) {
  return {
    "MdmsCriteria": {
      ...tenantId,
      "moduleDetails": [
        {
          "moduleName": "common-masters",
          "masterDetails": [
            {"name": "Department"},
            {"name": "Designation"},
            {"name": "StateInfo"},
            {"name": "wfSlaConfig"},
            {"name": "AppVersion"}
          ],
        },
        {
          "moduleName": "tenant",
          "masterDetails": [
            {"name": "tenants"},
            {"name": "citymodule"}
          ],
        },
        {
          "moduleName": "DIGIT-UI",
          "masterDetails": [
            {"name": "ApiCachingSettings"}
          ],
        },
      ],
    },
  };
}

Map getAppVersion(String tenantId) {
  return {
    "MdmsCriteria": {
      "tenantId": tenantId,
      "moduleDetails": [
        {
          "moduleName": "common-masters",
          "masterDetails": [
            {"name": "AppVersion"}
          ]
        }
      ]
    }
  };
}

Map getExpenseMDMS(String tenantId) {
  return {
    "MdmsCriteria": {
      "tenantId": tenantId,
      "moduleDetails": [
        {
          "moduleName": "Expense",
          "masterDetails": [
            {"name": "ExpenseType"},
          ]
        },
        {
          "moduleName": "BillingService",
          "masterDetails": [
            {"name": "BusinessService"},
            {"name": "TaxHeadMaster"},
          ]
        }
      ]
    }
  };
}

Map getConnectionTypePropertyTypeTaxPeriodMDMS(String tenantId, int datestamp) {
  return {
    "MdmsCriteria": {
      "tenantId": tenantId,
      "moduleDetails": [
        {
          "moduleName": "ws-services-masters",
          "masterDetails": [
            {"name": "connectionType", "filter": "[?(@.active==true)]"},
            {"name": "Category", "filter": "[?(@.active==true)]"},
            {"name": "SubCategory", "filter": "[?(@.active==true)]"},
          ]
        },
        {
          "moduleName": "PropertyTax",
          "masterDetails": [
            {"name": "PropertyType", "filter": "[?(@.active==true)]"},
          ]
        },
        {
          "moduleName": "BillingService",
          "masterDetails": [
            {"name": "TaxHeadMaster"},
            {"name": "TaxPeriod", "filter": "[?(@.service=='WS')]"}
          ]
        }
      ]
    }
  };
}

Map getTenantsMDMS(String tenantId) {
  return {
    "MdmsCriteria": {
      "tenantId": tenantId,
      "moduleDetails": [
        {
          "moduleName": "tenant",
          "masterDetails": [
            {"name": "tenants"}
          ]
        }
      ]
    }
  };
}
Map getDashboardLinksMDMS(String tenantId) {
  return {
    "MdmsCriteria": {
      "tenantId": tenantId,
      "moduleDetails": [
        {
          "moduleName": "anurakshak-dashboard",
          "masterDetails": [
            {"name": "links"}
          ]
        }
      ]
    }
  };
}

Map getServiceTypeConnectionTypePropertyTypeMDMS(String tenantId) {
  return {
    "MdmsCriteria": {
      "tenantId": tenantId,
      "moduleDetails": [
        {
          "moduleName": "ws-services-masters",
          "masterDetails": [
            {"name": "connectionType"},
          ]
        },
        {
          "moduleName": "PropertyTax",
          "masterDetails": [
            {"name": "PropertyType"},
          ]
        },
        {
          "moduleName": "BillingService",
          "masterDetails": [
            {"name": "TaxHeadMaster"},
            {"name": "TaxPeriod", "filter": "[?(@.service=='WS')]"}
          ],
        },
      ]
    }
  };
}

Map getMDMSPaymentModes(String tenantId) {
  return {
    "MdmsCriteria": {
      "tenantId": tenantId,
      "moduleDetails": [
        {
          "moduleName": "BillingService",
          "masterDetails": [
            {"name": "TaxHeadMaster"},
            {"name": "BusinessService", "filter": "[?(@.code=='WS')]"}
          ]
        }
      ]
    }
  };
}

Map getPaymentModeList(String tenantId) {
  return {
    "MdmsCriteria": {
      "tenantId": tenantId,
      "moduleDetails": [
        {
          "moduleName": "BillingService",
          "masterDetails": [
            {"name": "BusinessService", "filter": "[?(@.code=='WS')]"}
          ]
        }
      ]
    }
  };
}

Map getTenantFinancialYearList(String tenantId) {
  return {
    "MdmsCriteria": {
      "tenantId": tenantId,
      "moduleDetails": [
        {
          "moduleName": "BillingService",
          "masterDetails": [
            {"name": "TaxHeadMaster"},
            {"name": "TaxPeriod", "filter": "[?(@.service=='WS')]"}
          ],
        },
      ]
    }
  };
}