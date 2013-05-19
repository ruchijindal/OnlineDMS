<%-- 
    Document   : authorise
    Created on : Aug 18, 2011, 4:18:45 PM
    Author     : smp
--%>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>



<script type="text/javascript">
    function handleSelect(elm)
    {
        window.location = elm.value;
    }
</script>


<script type="text/javascript">
    var sortedOn = 0;

    function SortTable(sortOn) {

        var table = document.getElementById('results');
        var tbody = table.getElementsByTagName('tbody')[0];
        var rows = tbody.getElementsByTagName('tr');

        var rowArray = new Array();
        for (var i=0, length=rows.length; i<length; i++) {
            rowArray[i] = new Object;
            rowArray[i].oldIndex = i;
            rowArray[i].value = rows[i].getElementsByTagName('td')[sortOn].firstChild.nodeValue;
        }

        if (sortOn == sortedOn) { rowArray.reverse() }
        else {
            sortedOn = sortOn;
            /*Decide which function to use from the three:RowCompareNumbers,RowCompareDollars or RowCompare (default).For first column, I needed numeric comparison.*/
            if (sortedOn == 0) {
                rowArray.sort(RowCompare);
            }
            else {
                rowArray.sort(RowCompare);
            }
        }

        var newTbody = document.createElement('tbody');
        for (var i=0, length=rowArray.length ; i<length; i++) {
            newTbody.appendChild(rows[rowArray[i].oldIndex].cloneNode(true));
        }

        table.replaceChild(newTbody, tbody);
    }

    function RowCompare(a, b) {

        var aVal = a.value;
        var bVal = b.value;
        return (aVal == bVal ? 0 : (aVal > bVal ? 1 : -1));
    }
    // Compare number
    function RowCompareNumbers(a, b) {

        var aVal = parseInt( a.value);
        var bVal = parseInt(b.value);
        return (aVal - bVal);
    }
    // compare currency
    function RowCompareDollars(a, b) {

        var aVal = parseFloat(a.value.substr(1));
        var bVal = parseFloat(b.value.substr(1));
        return (aVal - bVal);
    }

    function GetXmlHttpObject()
    {
        var xmlHttp=null;
        try
        {
            // Firefox, Opera 8.0+, Safari
            xmlHttp=new XMLHttpRequest();
        }
        catch (e)
        {
            //Internet Explorer
            try
            {
                xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
            }
            catch (e)
            {
                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        return xmlHttp;
    }

   
    function searchType()
    {
        xmlHttp=GetXmlHttpObject()
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request")
            return;
        }
       // alert("in search")
        var sector= document.getElementById("sector").value;
       <%-- var block=document.getElementById("block").value;--%>
       // alert(sector)
        var url= "<%=request.getContextPath()%>/searchMaster?sector=" +sector ;
       // alert(url)
        xmlHttp.onreadystatechange=statechanged;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }

    function searchChallan()
    {
       // alert("in search challan");
        xmlHttp=GetXmlHttpObject()
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request")
            return;
        }
      //  alert("in search")
        var sector1= document.getElementById("sector1").value;
       <%-- var block1=document.getElementById("block1").value;--%>
       // alert(sector1)
        var url= "<%=request.getContextPath()%>/searchChallan?sector=" +sector1 ;
      //  alert(url)
        xmlHttp.onreadystatechange=statechanged;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }

 function statechanged()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            window.location = "#";
          window.location.reload();
           <%-- // window.location.reload();
            var showdata = xmlHttp.responseText;
            var block = showdata.split(":");
            //alert("block"+block);
           
            document.getElementById("block").options[0] = new Option(block,block);
            //alert(document.getElementById("block").value);--%>
         }
    }

  <%--
    function populateBlock()
    {
        var sector= document.getElementById("sector").value;
        xmlHttp=GetXmlHttpObject()

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request")
            return
        }
            
        var url="<%= request.getContextPath()%>/GetBlocks"
        url=url+"?&sector="+sector;
           
        xmlHttp.onreadystatechange=stateChanged1
        xmlHttp.open("GET",url,true)
        xmlHttp.send(null)
           
    }
                    
    function stateChanged1()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {

            var showdata = xmlHttp.responseText;
            var blockList = showdata.split(":");
            document.getElementById("block").options.length=1;
            for(i=0;i<blockList.length;i++)
            {

                document.getElementById("block").options[i+1]=new Option(blockList[i],blockList[i]);
            }

        }
    }
                    
    function populate()
    {
        var sector1= document.getElementById("sector1").value;
        xmlHttp=GetXmlHttpObject()

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request")
            return
        }

        var url="<%= request.getContextPath()%>/GetBlocks"
        url=url+"?&sector="+sector1;

        xmlHttp.onreadystatechange=stateChange
        xmlHttp.open("GET",url,true)
        xmlHttp.send(null)

    }

    function stateChange()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
                          
            var showdata = xmlHttp.responseText;
            var blockList = showdata.split(":");
            document.getElementById("block1").options.length=1;
            for(i=0;i<blockList.length;i++)
            {
                               
                document.getElementById("block1").options[i+1]=new Option(blockList[i],blockList[i]);
            }

        }
    }
       --%>
    function resetAll()
    {
        xmlHttp=GetXmlHttpObject()
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request")
            return;
        }

        var url= "<%=request.getContextPath()%>/AuthoriseMasterChallan" ;
        xmlHttp.onreadystatechange=statechanged;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
</script>


<%@page  language="java" import="java.util.*,java.sql.*,javax.servlet.*,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*"  %>


<html>
    <title>Unauthorise Master and Challans</title>
    <jsp:include page="../common/header.jsp"/>


    <body>

        <div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->

            <jsp:include page="../common/navbar.jsp"/>

            <div id="main-content"> <!-- Main Content Section with everything -->

                <div class="content-box"><!-- Start Content Box -->
                    <div class="content-box-header">
                        <h3>Unauthorised Master Records&nbsp;&nbsp;</h3><br/>
                        <div class="clear"></div>
                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">
                        <noscript> <!-- Show a notification if the user has disabled javascript -->
                            <div class="notification error1 png_bg">
                                <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                <div>
						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                                </div>
                            </div>
                        </noscript>

                        <c:set var="t" value="<%= request.getAttribute("t")%>"/>
                        <c:choose>
                            <c:when test="${t=='1'}">
                                <% request.setAttribute("t", 0);%>
                                <div class="notification error1 png_bg">
                                    <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>
			          No Unauthorised Master Records Found for this Division.
                                    </div>
                                </div>
                            </c:when>


                            <c:otherwise>
                                <div class="notification information png_bg">
                                    <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>
				 Records found: ${masterListSize}&nbsp;&nbsp;&nbsp;&nbsp;
                                    </div>
                                </div>

                                <div>
                                    <c:set value="10" var="pageSize"/>

                                    <c:choose>
                                        <c:when test="${empty param.s}">
                                            <c:set var="rowStart" value="1"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="rowStart" value="${param.s}"/>
                                        </c:otherwise>
                                    </c:choose>

                                    <c:choose>
                                        <c:when test="${empty param.e}">
                                            <c:set var="rowEnd" value="10"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="rowEnd" value="${param.e}"/>
                                        </c:otherwise>
                                    </c:choose>

                                    <form id="form1" name="form1" action="#">
                                        <table  cellspacing="0" cellpadding="0" style="color: #000;">
                                            <tr>
                                                <c:set var="sectorList" value="<%= session.getAttribute("sectorList")%>"/>
                                                <td> Sector
                                                    <select name="sector" id="sector" onchange="searchType()" style="width: 100px; ">
                                                        <option value="">Select</option>
                                                        <c:forEach var="sector" items="${sectorList}">
                                                            <option value="${sector}">${sector}</option>
                                                        </c:forEach>
                                                    </select>
                                                </td>
                                               <%-- <td> Block
                                                    <select name="block" id="block" onchange="searchType()" style="width: 100px;">
                                                        <option value="0">Select</option>

                                                    </select>
                                                </td>--%>
                                                <td colspan="8" width="2400px;"></td>
                                                <td>
                                                    <input type="reset" onclick="resetAll()" class="button" size="20px;" /> </td>

                                            </tr>
                                        </table>
                                    </form>

                                    <table id="results">
                                        <thead>
                                            <tr>
                                                <th><a onclick="SortTable(0);" href="javascript:;">Cons No.</a></th>
                                                <th>Cons Name</th>
                                                <th><a onclick="SortTable(2);" href="javascript:;">Address</a></th>
                                                <th><a onclick="SortTable(3);" href="javascript:;">Conn Type</a></th>
                                                <th>Conn Ctg</th>
                                                <th>Flat Type</th>
                                                <th>Plot Size</th>
                                                <th>Pipe Size</th>
                                                <th>Reg No</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <c:if test="${masterListSize eq 0}"><tr style="border: 2px solid red;"><td colspan="9">No Records Available for this Search</td> </tr></c:if>
                                             <c:forEach begin="${rowStart-1}" step="1" end="${rowEnd-1}" var="master" varStatus="status" items="${masterList}">
                                                <tr>
                                                    <td><a href="<%= request.getContextPath()%>/ConsumerDetails?cons_no=${master.consNo}">${master.consNo}</a></td>

                                                    <c:choose>
                                                        <c:when test="${empty master.transNm}">
                                                            <c:set var="consNm" value="${master.consNm1}"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set var="consNm" value="${master.transNm}"/>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <td>${consNm}</td>
                                                    <td >${master.sector}/${master.blkNo}-${master.flatNo}</td>
                                                    <td align="center">${master.conTp}</td>
                                                    <td align="center">${master.consCtg}</td>
                                                    <td >${master.flatType}</td>
                                                    <td>${master.plotSize}</td>
                                                    <td>${master.pipeSize}</td>
                                                    <td>${master.regNo}</td>
                                                    <td><a href="<%= request.getContextPath()%>/ManagerController?cons_no=${master.consNo}">Authorise</a></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>

                                        <c:set value="${masterPaginationSize}" var="rLen"/>

                                        <c:choose>
                                            <c:when test="${rLen lt rowEnd}">
                                                <c:set var="rCurrEnd" value="${rLen}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="rCurrEnd" value="${rowEnd}"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${masterListSize != 0}">
                                        <tr>
                                            <td><div class="align-left">
                                                    <select name="page" onchange="javascript:handleSelect(this)">
                                                        <option value="">Select Page No.</option>
                                                        <c:forEach var="pStart" varStatus="status" begin="0" end="${rLen-1}" step="${pageSize}">
                                                            <c:url value="/jsppages/manager/authorise.jsp?s=${pStart+1}&e=${pStart+pageSize}" var="urlCurr"/>
                                                            <option value=" ${urlCurr}" >Page No ${status.count} </option>
                                                        </c:forEach>
                                                    </select>
                                                </div></td>
                                            <td><div class="pagination"> Displaying Records:&nbsp; ${rowStart}&nbsp;-&nbsp;${rCurrEnd}</div></td>
                                            <td colspan="8"><div class="pagination">
                                                    <c:if test="${rowStart gt 1}">
                                                        <c:url value="/jsppages/manager/authorise.jsp?s=${rowStart-pageSize}&e=${rowEnd-pageSize}" var="urlPrev"/>
                                                        <a href="${urlPrev}">&laquo; Prev</a>
                                                    </c:if>

                                                    <c:choose>
                                                        <c:when test="${(rLen-1)>=40}">
                                                            <c:forEach var="pStart" varStatus="status" begin="0" end="50" step="${pageSize}">

                                                                <c:url value="/jsppages/manager/authorise.jsp?s=${pStart+1}&e=${pStart+pageSize}" var="urlCurr"/>
                                                                <span>

                                                                    <c:set value="${(status.count)+((rowStart-1)/10)}"  var="count"/>
                                                                    <fmt:formatNumber maxFractionDigits="0" value="${count}" var="count1"></fmt:formatNumber>

                                                                    <c:choose>
                                                                        <c:when test="${rCurrEnd/10 eq count}">
                                                                            <a href="<%=request.getContextPath()%>/jsppages/manager/authorise.jsp?s=${(count1-1)*10+1}&e=${(count1-1)*10+10}"><b style="color: black"> ${count1}</b> </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a href="<%=request.getContextPath()%>/jsppages/manager/authorise.jsp?s=${(count1-1)*10+1}&e=${(count1-1)*10+10}"> ${count1} </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach var="pStart" varStatus="status" begin="0" end="${rLen-1}" step="${pageSize}">

                                                                <c:url value="/jsppages/manager/authorise.jsp?s=${pStart+1}&e=${pStart+pageSize}" var="urlCurr"/>
                                                                <span>
                                                                    <a href="${urlCurr}"> ${status.count} </a>
                                                                </span>
                                                            </c:forEach>

                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:if test="${rowEnd lt rLen}">
                                                        <c:url value="/jsppages/manager/authorise.jsp?s=${rowStart+pageSize}&e=${rowEnd+pageSize}" var="urlNext"/>
                                                        <a href="${urlNext}">Next &raquo;</a>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                        </c:if>
                                    </table>
                                </div>
                            </c:otherwise></c:choose>

                        </div>
                    </div>


                    <div class="content-box"><!-- Start Content Box -->
                        <div class="content-box-header">
                            <h3>Unauthorised Challan Records&nbsp;&nbsp;</h3><br/>
                            <div class="clear"></div>
                        </div> <!-- End .content-box-header -->

                        <div class="content-box-content">
                            <noscript> <!-- Show a notification if the user has disabled javascript -->
                                <div class="notification error1 png_bg">
                                    <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>
						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                                    </div>
                                </div>
                            </noscript>
                        <c:set var="t1" value="<%= request.getAttribute("t1")%>"/>
                        <c:choose>

                            <c:when test="${t1=='3'}">
                                <% request.setAttribute("t1", 0);%>
                                <div class="notification error1 png_bg">
                                    <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>
			          No Unauthorised Challan Records Found for this Division.
                                    </div>
                                </div>
                            </c:when>





                            <c:otherwise>
                                <c:if test="${t1=='4'}">
                                    <% request.setAttribute("t1", 0);%>
                                    <div class="notification error1 png_bg">
                                        <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
			         First Authorised Master Record of this Consumer No.
                                        </div>
                                    </div>
                                </c:if>
                                <div class="notification information png_bg">
                                    <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>
				 Records found: ${challanListSize}&nbsp;&nbsp;&nbsp;&nbsp;
                                    </div>
                                </div>

                                <div>
                                    <c:set value="10" var="pageSize"/>

                                    <c:choose>
                                        <c:when test="${empty param.s}">
                                            <c:set var="rowStart" value="1"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="rowStart" value="${param.s}"/>
                                        </c:otherwise>
                                    </c:choose>

                                    <c:choose>
                                        <c:when test="${empty param.e}">
                                            <c:set var="rowEnd" value="10"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="rowEnd" value="${param.e}"/>
                                        </c:otherwise>
                                    </c:choose>

                                    <form id="form2" name="form2" action="">
                                        <table  cellspacing="0" cellpadding="0" style="color: #000;">
                                            <tr>
                                                <c:set var="sectorList" value="<%= session.getAttribute("sectorList")%>"/>
                                                <td> Sector
                                                    <select name="sector1" id="sector1" onchange="searchChallan()" style="width: 100px; ">
                                                        <option value="">Select</option>
                                                        <c:forEach var="sector1" items="${sectorList}">
                                                            <option value="${sector1}">${sector1}</option>
                                                        </c:forEach>
                                                    </select>
                                                </td>
                                               <%-- <td> Block
                                                    <select name="block1" id="block1" onchange="searchChallan()" style="width: 100px;">
                                                        <option value="">Select</option>

                                                    </select>
                                                </td>--%>
                                                <td colspan="8" width="2400px;"></td>
                                                <td>
                                                    <input type="reset" onclick="resetAll()" class="button" size="20px;" /> </td>

                                            </tr>
                                        </table>
                                    </form>

                                    <table id="results">
                                        <thead>
                                            <tr>
                                                <th colspan="2" style="text-align: center">Bill Period</th>

                                                <th>Due Dt</th>
                                                <th>BillAmt </th>
                                                <th>S/c</th>
                                                <th>PaidAmt</th>
                                                <th>Pay Dt</th>
                                                <th>Arrear</th>
                                                <th>Credit</th>
                                                <th>Recp No</th>
                                                <th>DCd</th>
                                                <th>Noc</th>
                                                <th>RMC</th>
                                                <th>Secu</th>
                                                <th>TFee</th>
                                                <th>Cess</th>
                                                <th>BnCd</th>
                                                <th>BrNm</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <c:if test="${challanListSize eq 0}"><tr style="border: 2px solid red;"><td colspan="19">No Records Available for this Search</td> </tr></c:if>
                                            <c:forEach begin="${rowStart-1}" step="1" end="${rowEnd-1}" var="challan" varStatus="status" items="${challanList}">
                                                <tr>
                                                    <td><a href="<%= request.getContextPath()%>/ConsumerDetails?cons_no=${challan.consNo}"><fmt:formatDate value="${challan.blPerFr}" pattern="dd/MM/yy"  var="blPerFr" />${blPerFr}</a></td>
                                                    <td><fmt:formatDate value="${challan.blPerTo}" pattern="dd/MM/yy"  var="blPerTo" />${blPerTo}</td>
                                                    <td><fmt:formatDate value="${challan.dueDt}" pattern="dd/MM/yy"  var="dueDt" />${dueDt}</td>
                                                    <td>${challan.billAmt}</td>
                                                    <td>${challan.surcharge}</td>
                                                    <td >${challan.paidAmt}</td>
                                                    <td><fmt:formatDate value="${challan.payDate}" pattern="dd/MM/yy" var="payDate" />${payDate}</td>
                                                    <td>${challan.arrear}</td>
                                                    <td>${challan.credit}</td>
                                                    <td>${challan.recpNo}</td>
                                                    <td>${challan.disCd}</td>
                                                    <td>${challan.noc}</td>
                                                    <td>${challan.rmc}</td>
                                                    <td>${challan.secu}</td>
                                                    <td>${challan.TFee}</td>
                                                    <td>${challan.css}</td>
                                                    <td>${challan.bnkCd}</td>
                                                    <td>${challan.brNm}</td>
                                                    <td><a href="<%= request.getContextPath()%>/ManagerController?cons_no1=${challan.consNo}&id=${challan.id}">Authorise</a></td>

                                                </tr>
                                            </c:forEach>
                                        </tbody>

                                        <c:set value="${challanPaginationSize}" var="rLen"/>

                                        <c:choose>
                                            <c:when test="${rLen lt rowEnd}">
                                                <c:set var="rCurrEnd" value="${rLen}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="rCurrEnd" value="${rowEnd}"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <tr>
                                             <c:if test="${challanListSize != 0}">

                                            <td colspan="3"><div class="align-left">
                                                    <select name="page" onchange="javascript:handleSelect(this)">
                                                        <option value="">Select Page No.</option>
                                                        <c:forEach var="pStart" varStatus="status" begin="0" end="${rLen-1}" step="${pageSize}">
                                                            <c:url value="/jsppages/manager/authorise.jsp?s=${pStart+1}&e=${pStart+pageSize}" var="urlCurr"/>
                                                            <option value=" ${urlCurr}" >Page No ${status.count} </option>
                                                        </c:forEach>
                                                    </select>
                                                </div></td>
                                            <td colspan="3"><div class="pagination"> Displaying Records:&nbsp; ${rowStart}&nbsp;-&nbsp;${rCurrEnd}</div></td>
                                            <td colspan="13"><div class="pagination">
                                                    <c:if test="${rowStart gt 1}">
                                                        <c:url value="/jsppages/manager/authorise.jsp?s=${rowStart-pageSize}&e=${rowEnd-pageSize}" var="urlPrev"/>
                                                        <a href="${urlPrev}">&laquo; Prev</a>
                                                    </c:if>


                                                    <c:choose>
                                                        <c:when test="${(rLen-1)>=40}">
                                                            <c:forEach var="pStart" varStatus="status" begin="0" end="50" step="${pageSize}">

                                                                <c:url value="/jsppages/manager/authorise.jsp?s=${pStart+1}&e=${pStart+pageSize}" var="urlCurr"/>
                                                                <span>

                                                                    <c:set value="${(status.count)+((rowStart-1)/10)}"  var="count"/>
                                                                    <fmt:formatNumber maxFractionDigits="0" value="${count}" var="count1"></fmt:formatNumber>

                                                                    <c:choose>
                                                                        <c:when test="${rCurrEnd/10 eq count}">
                                                                            <a href="<%=request.getContextPath()%>/jsppages/manager/authorise.jsp?s=${(count1-1)*10+1}&e=${(count1-1)*10+10}"><b style="color: black"> ${count1}</b> </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a href="<%=request.getContextPath()%>/jsppages/manager/authorise.jsp?s=${(count1-1)*10+1}&e=${(count1-1)*10+10}"> ${count1} </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach var="pStart" varStatus="status" begin="0" end="${rLen-1}" step="${pageSize}">

                                                                <c:url value="/jsppages/manager/authorise.jsp?s=${pStart+1}&e=${pStart+pageSize}" var="urlCurr"/>
                                                                <span>
                                                                    <a href="${urlCurr}"> ${status.count} </a>
                                                                </span>
                                                            </c:forEach>

                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:if test="${rowEnd lt rLen}">
                                                        <c:url value="/jsppages/manager/authorise.jsp?s=${rowStart+pageSize}&e=${rowEnd+pageSize}" var="urlNext"/>
                                                        <a href="${urlNext}">Next &raquo;</a>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </c:if></tr>
                                    </table>
                                </div>

                            </c:otherwise></c:choose>
                        </div>
                    </div>

                <jsp:include page="../common/footer.jsp"/>
            </div>
        </div>


    </body>
</html>



