<%-- 
    Document   : billRepository
    Created on : 22 Jun, 2011, 3:34:55 PM
    Author     : smp
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="chl" value="1"></c:set>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bill Repository </title>
        <jsp:include page="../common/header.jsp"/>
    </head>
    <script type="text/javascript">
        function searchBillRepository(){

            XmlHttp= xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return;
            }
            
            var bill_no= document.getElementById("billno").value;
            var cons_no= document.getElementById("consno").value;
            var bill_from= document.getElementById("bill_from").value;
            var bill_to= document.getElementById("bill_to").value;
            alert("bill_to----- "+bill_to);

            var url="<%=request.getContextPath()%>/searchBillRepoistory?bill_no=" +bill_no +"&cons_no=" +cons_no +"&bill_from=" +bill_from +"&bill_to=" +bill_to;
            xmlHttp.open("GET", url, true);
            xmlHttp.send(null);

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

    </script>
    <body>
        <div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->
            <jsp:include page="../common/navbar.jsp"/>
            <div id="main-content"> <!-- Main Content Section with everything -->
                <div class="content-box"><!-- Start Content Box -->
                    <div class="content-box-header">
                        <h3>Search</h3>
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
                        <div class="tab-content default-tab" >

                            <form id="form1" action="">
                                <table>
                                    <tr>
                                        <td> Bill No.
                                            <input type="text" id="billno" name="billno" size="10px;" onchange="searchBillRepository()" />
                                        </td>
                                        <td>

                                            Consumer No.
                                            <input type="text" id="consno" name="consno" size="10px;" onchange="searchBillRepository()"/>
                                        </td>
                                        <td>

                                            Bill From
                                            <input type="text" id="bill_from" name="bill_from" size="10px;" onchange="searchBillRepository()"/>
                                        </td>
                                        <td>
                                            Bill To
                                            <input type="text" id="bill_to" name="bill_to" size="10px;" onchange="searchBillRepository()"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <input type="reset" class="button" value="Reset" name="reset">
                                        </td>
                                    </tr>
                                </table>
                            </form>

                            <table  cellspacing="0" cellpadding="0" style="color: #000;">
                                <thead>
                                    <tr>
                                       

                                        <th>Bill No.</th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th>Consumer No.</th>
                                        <th> </th>
                                        <th> </th>
                                        <th>Bill From</th>                                      
                                        <th> </th>
                                        <th></th>
                                        <th>Bill To </th>                                        
                                       

                                    </tr>

                                </thead>
                                <c:forEach items="${billrepositoryList}" var="billrepositoryList">

                                <form id="form" action="">
                                    <table>
                                        <tr><td><input type="text" id="billno" name="billno"size="8px;" value="${billrepositoryList.id}" readonly/></td><td></td><td></td><td></td>
                                        <td><input type="text" id="consno" name="consno"size="8px;" value="${billrepositoryList.consNo}" readonly/></td><td></td><td></td><td></td><td></td><td></td>
                                        <td><fmt:formatDate value="${billrepositoryList.billFrom}" pattern="dd-MM-yyyy" var="billFrom"/> <input type="text" id="bill_from" name="bill_from"size="8px;" value="${billFrom}" readonly/></td><td></td><td></td><td></td>
                                        <td><fmt:formatDate value="${billrepositoryList.billTo}" pattern="dd-MM-yyyy" var="billTo"/> <input type="text" id="bill_to" name="bill_to"size="8px;"  value="${billTo}" readonly/></td>
                                        </tr>
                                    </table>
                                                                    
                                </form>
                                </c:forEach>

                            </table>


                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../common/footer.jsp"/>
        </div>
    </body>
</html>
