import ballerina/time;
import ballerinax/health.fhir.r4;

import wso2healthcare/health.x12.v005010x217.v278a1;

public isolated function ext(v278a1:X12_005010X217_278A1 payload, r4:Bundle bundle) returns v278a1:X12_005010X217_278A1|error {

    v278a1:X12_005010X217_278A1 payload1 = ext1(payload, bundle);
    v278a1:X12_005010X217_278A1 ext2Result = ext2(payload1, bundle);
    v278a1:X12_005010X217_278A1 ext3Result = ext3(ext2Result, bundle);
    v278a1:X12_005010X217_278A1 ext4Result = ext4(ext3Result, bundle);
    v278a1:X12_005010X217_278A1 ext5Result = ext5(ext4Result, bundle);
    // v278a1:X12_005010X217_278A1 ext6Result = ext6(ext5Result, bundle);

    return ext5Result;

}

isolated function ext1(v278a1:X12_005010X217_278A1 payload, r4:Bundle bundle) returns v278a1:X12_005010X217_278A1 {
    v278a1:UM04_HealthCareServiceLocationInformation_2000E_GType? unionResult = payload?.X12_FunctionalGroup?.X12_005010X217_278A1?.Loop_2000A?.Loop_2000B?.Loop_2000C?.Loop_2000E?.HealthCareServicesReviewInformation?.UM04_HealthCareServiceLocationInformation_2000E;

    if unionResult is v278a1:UM04_HealthCareServiceLocationInformation_2000E_GType {

        string uM0401FacilityTypeCode = unionResult.UM04_01_FacilityTypeCode;

        match uM0401FacilityTypeCode {
            "AR" => {
                unionResult.UM04_02_FacilityCodeQualifier = "A";
            }
            "HS" => {
                unionResult.UM04_02_FacilityCodeQualifier = "B";
            }

            "SC" => {
                unionResult.UM04_02_FacilityCodeQualifier = "B";
            }
        }
    }
    return payload;
}

isolated function ext2(v278a1:X12_005010X217_278A1 payload, r4:Bundle bundle) returns v278a1:X12_005010X217_278A1 {
    v278a1:Loop_2000F_GType[]? unionResult = payload?.X12_FunctionalGroup?.X12_005010X217_278A1?.Loop_2000A?.Loop_2000B?.Loop_2000C?.Loop_2000E?.Loop_2000F;

    if unionResult is v278a1:Loop_2000F_GType[] {
        foreach v278a1:Loop_2000F_GType item in unionResult {
            v278a1:DentalService_Type? unionResult2 = item?.DentalService;
            unionResult2 = ();
        }
    }

    return payload;
}

isolated function ext3(v278a1:X12_005010X217_278A1 payload, r4:Bundle bundle) returns v278a1:X12_005010X217_278A1 {
    v278a1:Loop_2000F_GType[]? unionResult = payload?.X12_FunctionalGroup?.X12_005010X217_278A1?.Loop_2000A?.Loop_2000B?.Loop_2000C?.Loop_2000E?.Loop_2000F;

    if unionResult is v278a1:Loop_2000F_GType[] {
        if unionResult.length() > 1 {
            unionResult = [unionResult[0]];
        }
    }

    return payload;
}

isolated function ext4(v278a1:X12_005010X217_278A1 payload, r4:Bundle bundle) returns v278a1:X12_005010X217_278A1 {
    v278a1:Loop_2010EA_GType[]? unionResult = payload?.X12_FunctionalGroup?.X12_005010X217_278A1?.Loop_2000A?.Loop_2000B?.Loop_2000C?.Loop_2000E?.Loop_2010EA;

    if unionResult is v278a1:Loop_2010EA_GType[] {
        if unionResult.length() > 1 {
            unionResult = [unionResult[0]];
        }
    }

    return payload;

}

isolated function ext6(v278a1:X12_005010X217_278A1 payload, r4:Bundle r) returns v278a1:X12_005010X217_278A1 {

    // DentalService_Type ds = {SV306__ServiceUnitCount: "10", SV301_CompositeMedicalProcedureIdentifier_2000F: {SV301_01_ProductOrServiceIDQualifier: "TY", SV301_02_ProcedureCode: "001"}};

    v278a1:Loop_2000F_GType[]? unionResult = payload?.X12_FunctionalGroup?.X12_005010X217_278A1?.Loop_2000A?.Loop_2000B?.Loop_2000C?.Loop_2000E?.Loop_2000F;

    if unionResult is v278a1:Loop_2000F_GType[] {
        v278a1:Loop_2000F_GType loopf = unionResult[0];
        unionResult.push(loopf);
    }
    return payload;

}

isolated function ext5(v278a1:X12_005010X217_278A1 payload, r4:Bundle r) returns v278a1:X12_005010X217_278A1 {

    v278a1:DentalService_Type ds = {SV306__ServiceUnitCount: "10", SV301_CompositeMedicalProcedureIdentifier_2000F: {SV301_01_ProductOrServiceIDQualifier: "TY", SV301_02_ProcedureCode: "001"}};

    v278a1:Loop_2000F_GType[]? unionResult = payload?.X12_FunctionalGroup?.X12_005010X217_278A1?.Loop_2000A?.Loop_2000B?.Loop_2000C?.Loop_2000E?.Loop_2000F;

    if unionResult is v278a1:Loop_2000F_GType[] {
        unionResult[0].DentalService = ds;
    }
    return payload;

}

public isolated function convertToUTC(string dateTimeStr) returns string|error {

    do {
        // Read the string into a time:Utc object (handles timezone offset automatically)
        time:Utc utcValue = check time:utcFromString(dateTimeStr);

        time:Civil utcToCivil = time:utcToCivil(utcValue);
        // Convert to a string in UTC (this will append Z)
        string utcString = check time:civilToString(utcToCivil);

        return utcString;
    } on fail var cause {
        return cause;
    }
}

