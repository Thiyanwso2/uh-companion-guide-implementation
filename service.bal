// Copyright (c) 2025, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
// 
// This software is the property of WSO2 LLC. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/http;
import ballerinax/health.fhir.r4;

import wso2healthcare/health.x12.v005010x217.v275;
import wso2healthcare/health.x12.v005010x217.v278a1;
import wso2healthcare/health.x12.v005010x217.v278a3;

public type RequestPayload record {|
    v278a1:X12_005010X217_278A1|v275:X12_005010_275|v278a3:X12_005010X217_278A3 x12Record;
    r4:Bundle bundle;
|};

configurable int port = 8080;

service http:Service / on new http:Listener(port) {
    isolated resource function post fhir\-to\-x12(http:RequestContext ctx, http:Request request) returns http:Response|error {

        json jsonPayload = check request.getJsonPayload();

        RequestPayload cloneWithType = check jsonPayload.cloneWithType(RequestPayload);

        v278a1:X12_005010X217_278A1|v275:X12_005010_275|v278a3:X12_005010X217_278A3 x12Record = cloneWithType.x12Record;

        http:Response response = new;
        if x12Record is v278a1:X12_005010X217_278A1 {
            v278a1:X12_005010X217_278A1 x12005010X217278A1 = check ext(x12Record, cloneWithType.bundle);
            response.setJsonPayload(x12005010X217278A1.toJson());
        } else {
            response.setJsonPayload(x12Record.toJson());
        }

        return response;
    }

    isolated resource function post x12\-to\-fhir(http:RequestContext ctx, http:Request request) returns http:Response|error {

        json jsonPayload = check request.getJsonPayload();

        RequestPayload cloneWithType = check jsonPayload.cloneWithType(RequestPayload);

        r4:Bundle fhirBundle = cloneWithType.bundle;

        http:Response response = new;
        response.setJsonPayload(fhirBundle.toJson());
        return response;
    }
}
