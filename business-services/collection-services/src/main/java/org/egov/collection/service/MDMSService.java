package org.egov.collection.service;

import org.egov.collection.config.ApplicationProperties;
import org.egov.collection.config.CollectionServiceConstants;
import org.egov.collection.repository.ServiceRequestRepository;
import org.egov.common.contract.request.RequestInfo;
import org.egov.mdms.model.MasterDetail;
import org.egov.mdms.model.MdmsCriteria;
import org.egov.mdms.model.MdmsCriteriaReq;
import org.egov.mdms.model.ModuleDetail;
import org.egov.tracer.model.CustomException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.jayway.jsonpath.JsonPath;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.NotNull;

import static org.egov.collection.config.CollectionServiceConstants.BILLING_MASTER_CODE;
import static org.egov.collection.config.CollectionServiceConstants.BILLING_MODULE_NAME;

@Service
public class MDMSService {


    private ApplicationProperties applicationProperties;

    private ServiceRequestRepository serviceRequestRepository;


    @Autowired
    public MDMSService(ApplicationProperties applicationProperties, ServiceRequestRepository serviceRequestRepository) {
        this.applicationProperties = applicationProperties;
        this.serviceRequestRepository = serviceRequestRepository;
    }

    public Object mDMSCall(RequestInfo requestInfo, String tenantId){
        MdmsCriteriaReq mdmsCriteriaReq = getMDMSRequest(requestInfo,tenantId);
        StringBuilder url = getMdmsSearchUrl();
        Object result = serviceRequestRepository.fetchResult(url,mdmsCriteriaReq);
        return result;
    }


    /**
     * Creates MDMS request
     * @param requestInfo The RequestInfo of the Payment
     * @param tenantId The tenantId of the Payment
     * @return MDMSCriteria Request
     */
    private MdmsCriteriaReq getMDMSRequest(RequestInfo requestInfo, String tenantId) {

        // master details for Collection module
        List<MasterDetail> billingMasterDetails = new ArrayList<>();

        billingMasterDetails.add(MasterDetail.builder().name(BILLING_MASTER_CODE).build());

        ModuleDetail billingModuleDtls = ModuleDetail.builder().masterDetails(billingMasterDetails)
                .moduleName(BILLING_MODULE_NAME).build();

        List<ModuleDetail> moduleDetails = new ArrayList<>();
        moduleDetails.add(billingModuleDtls);

        MdmsCriteria mdmsCriteria = MdmsCriteria.builder().moduleDetails(moduleDetails).tenantId(tenantId)
                .build();

        return MdmsCriteriaReq.builder().requestInfo(requestInfo).mdmsCriteria(mdmsCriteria).build();
    }


    /**
     * Creates and returns the url for mdms search endpoint
     *
     * @return MDMS Search URL
     */
    private StringBuilder getMdmsSearchUrl() {
        return new StringBuilder().append(applicationProperties.getMdmsHost()).append(applicationProperties.getMdmsSearchEndpoint());
    }

    public Map<String, List<String>> getMdmsAttributeValues(String tenantId, String moduleName, List<String> names,
			String filter, String jsonPath, RequestInfo requestInfo) {
		StringBuilder uri = new StringBuilder(applicationProperties.getMdmsHost()).append(applicationProperties.getMdmsSearchEndpoint());
		MdmsCriteriaReq criteriaReq = prepareMdMsRequest(tenantId, moduleName, names, filter,
				requestInfo);
		try {

			Object result = serviceRequestRepository.fetchResult(uri, criteriaReq);
			return JsonPath.read(result, jsonPath);
		} catch (Exception e) {
			throw new CustomException(CollectionServiceConstants.INVALID_REQUEST, CollectionServiceConstants.INVALID_REQUEST);
		}
	}

    
    private MdmsCriteriaReq prepareMdMsRequest(String tenantId, String moduleName, List<String> names, String filter,
			RequestInfo requestInfo) {
		List<MasterDetail> masterDetails = new ArrayList<>();
		names.forEach(name -> {
			masterDetails.add(MasterDetail.builder().name(name).filter(filter).build());
		});
		ModuleDetail moduleDetail = ModuleDetail.builder().moduleName(moduleName).masterDetails(masterDetails).build();
		List<ModuleDetail> moduleDetails = new ArrayList<>();
		moduleDetails.add(moduleDetail);
		MdmsCriteria mdmsCriteria = MdmsCriteria.builder().tenantId(tenantId).moduleDetails(moduleDetails).build();
		return MdmsCriteriaReq.builder().requestInfo(requestInfo).mdmsCriteria(mdmsCriteria).build();
	}

}
