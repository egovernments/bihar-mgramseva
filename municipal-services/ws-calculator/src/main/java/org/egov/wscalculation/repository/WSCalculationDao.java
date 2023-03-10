package org.egov.wscalculation.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.egov.wscalculation.web.models.MeterConnectionRequest;
import org.egov.wscalculation.web.models.MeterReading;
import org.egov.wscalculation.web.models.MeterReadingSearchCriteria;

public interface WSCalculationDao {

	void saveMeterReading(MeterConnectionRequest meterConnectionRequest);
	
	List<MeterReading> searchMeterReadings(MeterReadingSearchCriteria criteria);
	
	ArrayList<String> searchTenantIds();

	ArrayList<String> searchConnectionNos(String connectionType, String tenantId);
	
	List<MeterReading> searchCurrentMeterReadings(MeterReadingSearchCriteria criteria);
	
	int isMeterReadingConnectionExist(List<String> ids);
	
	List<String> getConnectionsNoList(String tenantId, String connectionType);
	
	List<String> getTenantId();
	
	int isBillingPeriodExists(String connectionNo, String billingPeriod);
	Boolean isDemandExists(String tenantId, Long bilingDate,Long endTime, Set<String> connectionNos);

	List<String> getNonMeterConnectionsList(String tenantId, Long dayStartTime, Long dayEndTime);

	Boolean isConnectionExists(String tenantId, Long startTime, Long endTime, Set<String> connectionNos);

}
