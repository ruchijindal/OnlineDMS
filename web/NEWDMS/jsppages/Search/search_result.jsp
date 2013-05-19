
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>

<%@page  language="java" import="java.util.*,java.sql.*,javax.servlet.*,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*"  %>


<script  type="text/javascript" src="<%= request.getContextPath()%>/resources/jquery/gs_sortable.js"></script>
<script type="text/javascript">
    function handleSelect(elm)
    {
        window.location = elm.value;
    }
</script>

<script type="text/javascript">

    var TSort_Data = new Array ('results', 'n', 's', 'i','s');
    tsRegister();

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
            /*
Decide which function to use from the three:RowCompareNumbers,
RowCompareDollars or RowCompare (default).
For first column, I needed numeric comparison.
             */
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
</script>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <title>Search Result</title>
    <jsp:include page="../common/header.jsp"/>


    <body>

        <div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->


            <jsp:include page="../common/navbar.jsp"/>

            <div id="main-content"> <!-- Main Content Section with everything -->



                <div class="content-box"><!-- Start Content Box -->

                    <div class="content-box-header">




                        <h3>Search Results:-&nbsp;&nbsp;</h3><br/>


                        <h5></h5>

                        <div class="clear"></div>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">


                        <noscript> <!-- Show a notification if the user has disabled javascript -->
                            <div class="notification error1 png_bg">
                                <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
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
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>
			          No Record Found for this Address.
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="notification information png_bg">
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
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
                                    
                                    <table id="results">

                                        <thead>

                                            <tr>
                                                <th><a onclick="SortTable(0);" href="javascript:;">Cons No.</a></th>
                                                <th><a onclick="SortTable(1);" href="javascript:;">Cons Name</a></th>
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
                                                    <td><a href="<%= request.getContextPath()%>/ConsumerDetails?cons_no=${master.consNo}">VIEW</a></td>
                                                </tr>

                                            </c:forEach>
                                        </tbody>

                                        <c:set value="${masterListSize}" var="rLen"/>

                                        <c:choose>
                                            <c:when test="${rLen lt rowEnd}">
                                                <c:set var="rCurrEnd" value="${rLen}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="rCurrEnd" value="${rowEnd}"/>
                                            </c:otherwise>
                                        </c:choose>

                                        <tr><td><div class="align-left">



                                                    <select name="page" onchange="javascript:handleSelect(this)">
                                                        <option value="">Select Page No.</option>
                                                        <c:forEach var="pStart" varStatus="status" begin="0" end="${rLen-1}" step="${pageSize}">
                                                            <c:url value="/NEWDMS/jsppages/Search/search_result.jsp?s=${pStart+1}&e=${pStart+pageSize}" var="urlCurr"/>
                                                            <option value=" ${urlCurr}" >Page No ${status.count} </option>
                                                        </c:forEach>
                                                    </select>


                                                </div></td><td><div class="pagination"> Displaying Records:&nbsp; ${rowStart}&nbsp;-&nbsp;${rCurrEnd}</div></td>




                                            <td colspan="8"><div class="pagination">
                                                    <c:choose>
                                                        <c:when test="${rLen < 40}">
                                                            <c:set var="rEnd" value="${rLen}"></c:set>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set var="rEnd" value="40"></c:set>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${rEnd%10 eq 0}">
                                                            <c:set var="rEnd1" value="${rEnd}"></c:set>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set var="rEnd1" value="${rEnd+(10-(rEnd%10))}"></c:set>
                                                        </c:otherwise>
                                                    </c:choose>


                                                    <c:if test="${rowStart gt 10}">
                                                        <c:url value="/NEWDMS/jsppages/Search/search_result.jsp?s=${rowStart-pageSize}&e=${rowEnd-pageSize}" var="urlPrev"/>
                                                        <a href="${urlPrev}">&laquo; Prev</a>
                                                    </c:if>


                                                    <c:choose>

                                                        <c:when test="${(rowEnd)> 40}">
                                                             <c:set var="rBegin" value="${rowStart-20}"></c:set>
                                                            <c:choose>
                                                                <c:when test="${rLen gt (rowEnd+10)}">
                                                                    <c:set var="rBegin" value="${rowStart-40}"></c:set>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:if test="${rLen gt (rowEnd)}">
                                                                        <c:set var="rBegin" value="${rowStart-30}"></c:set>
                                                                    </c:if>

                                                                </c:otherwise>

                                                            </c:choose>

                                                            <c:forEach var="pStart" varStatus="status" begin="${rBegin}" end="${rowEnd}" step="${pageSize}">



                                                                <span>

                                                                    <c:set value="${(status.count)+(((rowStart-1)/10)-2)}"  var="count"/>
                                                                    <fmt:formatNumber maxFractionDigits="0" value="${count}" var="count1"></fmt:formatNumber>

                                                                    <c:choose>
                                                                        <c:when test="${rowEnd/10 eq count}">
                                                                            
                                                                            <a href="<%=request.getContextPath()%>/NEWDMS/jsppages/Search/search_result.jsp?s=${(count1-1)*10+1}&e=${(count1-1)*10+10}"><b style="color: black"> ${count1}</b> </a>
                                                                        </c:when>
                                                                        <c:otherwise>

                                                                            <a href="<%=request.getContextPath()%>/NEWDMS/jsppages/Search/search_result.jsp?s=${(count1-1)*10+1}&e=${(count1-1)*10+10}"> ${count1} </a>

                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            
                                                               <c:set var="rREND" value="${rowEnd}"></c:set>
                                                              <c:choose>
                                                                <c:when test="${rLen lt rowEnd}">
                                                                    <c:set var="rBegin" value="1"></c:set>
                                                                    <c:set var="rREND" value="${rowEnd}"></c:set>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:set var="rBegin" value="1"></c:set>
                                                                    <c:set var="rREND" value="${rowEnd+40}"></c:set>
                                                                </c:otherwise>
                                                                
                                                            </c:choose>
                                                            <c:choose>
                                                            <c:when test="${rLen >= ((rREND)-9)}">

                                                                    <c:set var="rREND" value="${rREND}"></c:set>
                                                                    <c:if test="${(rREND-rBegin) > 50}">

                                                                    <c:set var="rREND" value="50"></c:set>
                                                                    </c:if>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:if test="${rLen <= rREND-39}">
                                                                        
                                                                    <c:set var="rREND" value="${rREND-30}"></c:set>
                                                                    </c:if>
                                                                    <c:if test="${rLen <= rREND-29}">

                                                                    <c:set var="rREND" value="${rREND-20}"></c:set>
                                                                    </c:if>
                                                                     <c:if test="${rLen <= rREND-19}">

                                                                    <c:set var="rREND" value="${rREND-10}"></c:set>
                                                                    </c:if>
                                                                     <c:if test="${rLen <= rREND-9}">

                                                                    <c:set var="rREND" value="${rREND-10}"></c:set>
                                                                    </c:if>
                                                                    <c:if test="${(rREND-rBegin) > 50}">

                                                                    <c:set var="rREND" value="50"></c:set> 
                                                                    </c:if>
                                                                </c:otherwise>
                                                            </c:choose>

                                                            <c:forEach var="pStart" varStatus="status" begin="${rBegin}" end="${rREND}" step="${pageSize}">


                                                                <span>
                                                                    <c:set value="${(status.count)+((rBegin-1)/10)}"  var="count"/>

                                                                    <fmt:formatNumber maxFractionDigits="0" value="${count}" var="count1"></fmt:formatNumber>

                                                                    <c:choose>
                                                                        <c:when test="${rowEnd/10 eq count}">

                                                                            <a href="<%=request.getContextPath()%>/NEWDMS/jsppages/Search/search_result.jsp?s=${(count1-1)*10+1}&e=${(count1-1)*10+10}"><b style="color: black"> ${count1}</b> </a>
                                                                        </c:when>
                                                                        <c:otherwise>

                                                                            <a href="<%=request.getContextPath()%>/NEWDMS/jsppages/Search/search_result.jsp?s=${(count1-1)*10+1}&e=${(count1-1)*10+10}"> ${count1} </a>

                                                                        </c:otherwise>
                                                                    </c:choose>


                                                                </span>
                                                            </c:forEach>

                                                        </c:otherwise>
                                                    </c:choose>

                                                                    <c:if test="${( rLen gt rowEnd )   }">

                                                        <c:url value="/NEWDMS/jsppages/Search/search_result.jsp?s=${rowEnd+1}&e=${rowEnd+10}" var="urlNext"/>
                                                        <a href="${urlNext}" >Next &raquo;</a>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>             </div>
                                </c:otherwise></c:choose>
                        </div>
                    </div>

                <jsp:include page="../common/footer.jsp"/>
            </div>
        </div>


    </body>
</html>


