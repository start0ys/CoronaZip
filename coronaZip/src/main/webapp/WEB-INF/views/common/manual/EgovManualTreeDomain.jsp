<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><spring:message code="common._mng_.manualDomain.groupName1" /></title>


<link type="text/css" rel="stylesheet" href="<c:url value='/css/common/library/fontawesome/css/all.min.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/screen/edit-style.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/common/library/tui-grid/tui-grid.min.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/common/library/tui-grid/tui-grid.custom.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/common/library/jquery/ui/ui.dialog.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/common/library/webEditor/froala/css/froala_editor.pkgd.min.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/common/library/webEditor/froala/css/froala_style.min.css' />">


<script type="text/javascript" src="<c:url value='/js/common/library/jquery/core/jquery.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/jquery/plug-in/jquery-browser/jquery.browser.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/jquery/ui/jquery-ui_studio.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/jquery/ui/jquery-ui-i18n.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/commonPath.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/axios/axios.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/jquery/plug-in/jquery.json-2.2.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/tui-grid/tui-grid.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/timepicker/1.3.5/jquery.timepicker.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/jquery/formatdate/jquery.lamp.formatdate.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/webEditor/froala/js/froala_editor.pkgd.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/webEditor/froala/js/languages/ko.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/webEditor/froala/js/languages/ja.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/webEditor/froala/js/languages/zh_cn.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/gridHelper.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/commonstring.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/commonnumber.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/commonWindowopen.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/jquery/plug-in/jshashtable.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/jquery/plug-in/textinputs_jquery.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/jquery/plug-in/jquery.numberformatter.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/jquery/plug-in/jquery.i18n.properties.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/jquery/plug-in/jquery.blockUI.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/attach/attachHelper.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/webEditor/froalaHelper.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/ajax-cross-origin/jquery.ajax-cross-origin.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/library/lodash/4.17.15/lodash.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/lamp7Demo/message.i18n.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/lamp7Demo/common.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/common/manual/EgovManualTreeDomain.js' />"></script>


    
   
<style>
    #col18 {
        flex-basis: 200%;
    }
    #col16 {
        flex-basis: 200%;
    }
    #col14 {
        flex-basis: 200%;
    }
    #col11 {
        flex-basis: 1%;
    }
    #col20 {
        flex-basis: 200%;
    }
    th[data-column-name="list-col3"] {
        width: 170%;
    }
    th[data-column-name="list-col7"] {
        width: 170%;
    }
    #order_seq {
        text-align: center;
    }
    #col39 {
        flex-basis: 200%;
    }
    #col38 {
        flex-basis: 200%;
    }
    #col37 {
        flex-basis: 100%;
    }
    #col36 {
        flex-basis: 200%;
    }
    #col35 {
        flex-basis: 100%;
    }
    #col33 {
        flex-basis: 63.5%;
    }
    #_group-container-col6 {
        margin: 0 30px 12px 30px;
    }
    #_group-container-col3 {
        margin: 0 30px 12px 30px;
    }
    #col43 {
        flex-basis: 304.5%;
    }
    #col28 {
        flex-basis: 200%;
    }
    #col27 {
        flex-basis: 100%;
    }
    #col26 {
        flex-basis: 500%;
    }
    th[data-column-name="list-col2"] {
        width: 341%;
    }
    #col25 {
        flex-basis: 100%;
    }
    #col24 {
        flex-basis: 200%;
    }

    #col23 {
        flex-basis: 100%;
    }
    #col22 {
        flex-basis: 200%;
    }
    th[data-column-name="list-col6"] {
        width: 85%;
    }
    #col32 {
        flex-basis: 121%;
    }
    #col31 {
        flex-basis: 60.5%;
    }
    #col58 {
        flex-basis: 500%;
    }
    #col57 {
        flex-basis: 800%;
    }
    #col56 {
        flex-basis: 100%;
    }
    #col55 {
        flex-basis: 100%;
    }
    #col5 {
        flex-basis: 11%;
    }
    th[data-column-name="list-col1"] {
        width: 256%;
    }
    #col47 {
        flex-basis: 200%;
    }
    #col46 {
        flex-basis: 100%;
    }
    th[data-column-name="list-col5"] {
        display: none;
        width: 1706%;
    }
    #domainname {
        font-weight: 700;
        font-size: 18px;
    }
    #col52 {
        margin: 0 30px 10px 30px;
    }
    th[data-column-name="list-col4"] {
        display: none;
        width: 1706%;
    }
    th[data-column-name="list-col8"] {
        width: 682%;
    }
    #row5 {
    	display:none;
    }
</style>
<script type="text/javascript">
let _message_ = {
		orderSeq: '<spring:message code="common._mng_.manualDomain.orderSeq" />'
		,codeName: '<spring:message code="common._mng_.manualDomain.codeName" />'
		,codeComment: '<spring:message code="common._mng_.manualDomain.codeComment" />'
		,isDefault:'<spring:message code="common._mng_.manualDomain.isDefault" />'
		,isUse: '<spring:message code="common._mng_.manualDomain.isUse" />'
		,codeDesc: '<spring:message code="common._mng_.manualDomain.codeDesc" />'
};
</script>
</head>
<body>
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript>

<input type="hidden" id="p_jsonData" name="p_jsonData" value="<c:out value='${p_jsonData}'/>" >

<div class="container-fluid">

        <div class="form-row bx-tbl" id="row2">
            <div class="form-col value-col" id="col52">
                <span class="view-compo " id="domainname" name="domainname" maxlength="4000" autocomplete="off"></span>
            </div>
        </div>
        <div class="form-row bx-tbl" id="row6">
            <div class="form-col group-container" id="_group-container-col6">
                <h3 class="group-title" id="col6" data-toggle="collapse" aria-expanded="true" aria-controls="col6">
                    <i class="fas fa-caret-down" foldicon="fas fa-caret-down" unfoldicon="fas fa-caret-up"></i><spring:message code="common._mng_.manualDomain.groupName1"/>
                </h3>
                <div class="collapse show container-content" data-target="col6" >
                    <div class="form-row bx-tbl" id="row8">
                        <div class="form-col label-col" id="col12">
                            <label for="data_type_name" class="required" id="label17"><spring:message code="common._mng_.manualDomain.typeName"/></label>
                        </div>
                        <div class="form-col value-col" id="col39">
                            <span class="view-compo " id="data_type_name" name="data_type_name" maxlength="30" autocomplete="off"></span>
                        </div>
                        <div class="form-col label-col" id="col15">
                            <label for="length" class="required" id="label5"><spring:message code="common._mng_.manualDomain.length"/></label>
                        </div>
                        <div class="form-col value-col" id="col16">
                            <span class="view-compo " id="length" name="length" autocomplete="off"></span>
                        </div>
                        <div class="form-col label-col" id="col13">
                            <label for="scale" class="" id="label4"><spring:message code="common._mng_.manualDomain.scale"/></label>
                        </div>
                        <div class="form-col value-col" id="col14">
                            <span class="view-compo " id="scale" name="scale" autocomplete="off"></span>
                        </div>
                    </div>
                    <div class="form-row bx-tbl" id="row9">
                        <div class="form-col label-col" id="col17">
                            <label for="prefix" class="" id="label6"><spring:message code="common._mng_.manualDomain.prefix"/></label>
                        </div>
                        <div class="form-col value-col" id="col18">
                            <span class="view-compo " id="prefix" name="prefix" maxlength="255" autocomplete="off"></span>
                        </div>
                        <div class="form-col label-col" id="col19">
                            <label for="pattern" class="" id="label7"><spring:message code="common._mng_.manualDomain.pattern"/></label>
                        </div>
                        <div class="form-col value-col" id="col20">
                            <span class="view-compo " id="pattern" name="pattern" maxlength="255" autocomplete="off"></span>
                        </div>
                        <div class="form-col label-col" id="col21">
                            <label for="suffix" class="" id="label8"><spring:message code="common._mng_.manualDomain.suffix"/></label>
                        </div>
                        <div class="form-col value-col" id="col22">
                            <span class="view-compo " id="suffix" name="suffix" maxlength="255" autocomplete="off"></span>
                        </div>
                    </div>
                    <div class="form-row bx-tbl" id="row10">
                        <div class="form-col label-col" id="col23">
                            <label for="out_length" class="" id="label9"><spring:message code="common._mng_.manualDomain.outLength"/></label>
                        </div>
                        <div class="form-col value-col" id="col24">
                            <span class="view-compo " id="out_length" name="out_length" autocomplete="off"></span>
                        </div>
                        <div class="form-col label-col" id="col25">
                            <label for="conv_routine" class="" id="label10"><spring:message code="common._mng_.manualDomain.convRoutine"/></label>
                        </div>
                        <div class="form-col value-col" id="col26">
                            <span class="view-compo " id="conv_routine" name="conv_routine" maxlength="255" autocomplete="off"></span>
                        </div>
                    </div>
                    <div class="form-row bx-tbl" id="row11">
                        <div class="form-col label-col" id="col27">
                            <label for="is_sign" class="" id="label11"><spring:message code="common._mng_.manualDomain.isSign"/></label>
                        </div>
                        <div class="form-col value-col" id="col28">
                            <span class="view-compo " id="is_sign" name="is_sign" maxlength="255" autocomplete="off"></span>
                        </div>
                        <div class="form-col label-col" id="col55">
                            <label for="str_case_type1" class="" id="label25"><spring:message code="common._mng_.manualDomain.strCaseType"/></label>
                        </div>
                        <div class="form-col value-col" id="col58">
                            <span class="view-compo " id="str_case_type1" name="str_case_type1" maxlength="255"></span>
                        </div>
                    </div>
                    <div class="form-row bx-tbl" id="row12">
                        <div class="form-col label-col" id="col31">
                            <label for="is_Auto" class="" id="label13"><spring:message code="common._mng_.manualDomain.isAuto"/></label>
                        </div>
                        <div class="form-col value-col" id="col32">
                            <span class="view-compo " id="is_Auto" name="is_Auto" maxlength="255" autocomplete="off"></span>
                        </div>
                        <div class="form-col label-col" id="col33">
                            <label for="auto_prefix" class="" id="label14"><spring:message code="common._mng_.manualDomain.autoPrefix"/></label>
                        </div>
                        <div class="form-col value-col" id="col43">
                            <span class="view-compo " id="auto_prefix" name="auto_prefix" maxlength="255" autocomplete="off"></span>
                        </div>
                    </div>
                    <div class="form-row bx-tbl" id="row13">
                        <div class="form-col label-col" id="col37">
                            <label for="auto_isFill" class="" id="label16"><spring:message code="common._mng_.manualDomain.autoIsFill"/></label>
                        </div>
                        <div class="form-col value-col" id="col38">
                            <span class="view-compo " id="auto_isFill" name="auto_isFill" maxlength="1" autocomplete="off"></span>
                        </div>
                        <div class="form-col label-col" id="col35">
                            <label for="auto_cipers" class="" id="label15"><spring:message code="common._mng_.manualDomain.autoCipers"/></label>
                        </div>
                        <div class="form-col value-col" id="col36">
                            <span class="view-compo " id="auto_cipers" name="auto_cipers" autocomplete="off"></span>
                        </div>
                        <div class="form-col label-col" id="col46">
                            <label for="inp4" class="" id="lbl4"><spring:message code="common._mng_.manualDomain.autoFillChar"/></label>
                        </div>
                        <div class="form-col value-col" id="col47">
                            <span class="view-compo " id="inp4" name="inp4" maxlength="4000" autocomplete="off"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-row bx-tbl" id="row3">
            <div class="form-col group-container" id="_group-container-col3">
                <h3 class="group-title" id="col3" data-toggle="collapse" aria-expanded="true" aria-controls="col3">
                    <i class="fas fa-caret-down" foldicon="fas fa-caret-down" unfoldicon="fas fa-caret-up"></i><spring:message code="common._mng_.manualDomain.groupName2"/>
                </h3>
                <div class="collapse show container-content" data-target="col3" >
                    <div class="form-row bx-tbl" id="row24">
                        <div class="form-col label-col" id="col56">
                            <label for="value_type1" class="" id="label23"><spring:message code="common._mng_.manualDomain.groupType"/></label>
                        </div>
                        <div class="form-col value-col" id="col57">
                            <span class="view-compo " id="value_type1" name="value_type1" maxlength="50"></span>
                        </div>
                    </div>
                    <div class="form-row bx-tbl" id="row5">
                        <div class="form-col label-col" id="col49">
                            <label for="inp8" class="" id="lbl7"></label>
                        </div>
                        <div class="form-col value-col" id="col51">
                            <span class="view-compo " id="inp8" name="inp8" maxlength="4000" autocomplete="off"></span>
                        </div>
                    </div>
                    <div class="form-row bx-tbl" id="row16">
                        <div class="form-col" id="col42">
                            <div class="" >
                                <div class="grid-btn-wrapper">
                                    <div class="grid-btn-1">
                                    </div>
                                    <div class="grid-btn-2 text-right">
                                    </div>
                                </div>
                                <div id="list1">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</div>

</body>
</html>

