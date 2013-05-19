<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.security.*;" %>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>
<%-- 
    Document   : setDiscountRate
    Created on : Jul 21, 2011, 3:37:46 PM
    Author     : smp
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="discountrate" value="0"></c:set>
<c:set var="chl" value="1"></c:set>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Discount Rate</title>
        <link rel="stylesheet" href="resources/css/reset.css" type="text/css" media="screen" />

        <!-- Main Stylesheet -->
        <link rel="stylesheet" href="resources/css/style.css" type="text/css" media="screen" />

        <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
        <link rel="stylesheet" href="resources/css/invalid.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="resources/css/simpletree.css" type="text/css" media="screen" />

        <jsp:include page="../common/header.jsp"/>
    </head>

    <script  type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.validate_1.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.maskedinput-1.2.2.js"></script>
    <script type="text/javascript">
        $(document).ready(function()
        {

            $("#dateFrom").mask("99/99/99");
            $("#dateTo").mask("99/99/99");
            $("#form").validate();
           
        });

        function editableChl(chl)
        {
            // alert(chl);
            var txt_inp = document.getElementsByTagName('input');
            var j=1,k=1;
            for(var i=1; i< txt_inp.length; i++)
            {

                if(txt_inp[i].type == "text" )
                {
                    var x = txt_inp[i];


                    // get or set id


                    if(x.name=="date_From"||x.name=="date_To"||x.name=="Rate")
                    {

                        x.id = "Id"+j; // We are dynamically setting and ID
                        Id="Id"+j;
                        if((j==((chl-1)*3)+k) && k<=3)
                        {

                            document.getElementById(Id).removeAttribute("readonly");
                            if(x.name=="date_From"||x.name=="date_To"){
                                $("#"+Id).mask("99/99/99");
                            }
                            k++;
                            document.getElementById("edit"+chl).style.display="none";
                            document.getElementById("save"+chl).style.display="inline-block";
                            document.getElementById("del"+chl).style.display="inline-block";

                        }
                        j++;


                    }
                }

            }
        
        }

        function confirmDel()
        {
            var msg;
            msg="Do you want to delete this record permanently?";
            var agree=confirm(msg);
            if(agree)
                
                return true;
            else
                return false;

        }

       
    </script>
    <body>
        <div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->
            <jsp:include page="../common/navbar.jsp"/>
            <div id="main-content"> <!-- Main Content Section with everything -->
                <a name="bottom"></a>


                <div class="content-box"><!-- Start Content Box -->
                    <div class="content-box-header">
                        <h3>Discount Rate</h3> 

                        <div class="content-box-tabs">


                            <a href="<%= request.getContextPath()%>/NEWDMS/jsppages/dmssettings/setDiscountRate.jsp?discountrate=1#bottom"><label class="button">New Discount Rate </label></a>


                        </div>

                        <div class="clear"></div>

                    </div>
                    <!-- End .content-box-header -->


                    <div class="content-box-content">
                        <div class="tab-content default-tab" id="tab2">
                            <noscript> <!-- Show a notification if the user has disabled javascript -->
                                <div class="notification error1 png_bg">
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>

						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                                    </div>
                                </div>

                            </noscript>
                            <c:set var="t1" value="<%= request.getAttribute("t1")%>"/>
                            <c:choose>
                                <c:when test="${t1=='1'}">
                                    <%request.setAttribute("t1", 0);%>

                                    <div class="notification success png_bg">
                                        <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
					Data Inserted Successfuly.
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${t1=='2'}">
                                    <%request.setAttribute("t1", 0);%>

                                    <div class="notification success png_bg">
                                        <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
					Data updated Successfuly.
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${t1=='3'}">
                                    <%request.setAttribute("t1", 0);%>

                                    <div class="notification success png_bg">
                                        <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
					Data deleted Successfuly.
                                        </div>
                                    </div>
                                </c:when>

                                <c:when test="${t1=='4'}">
                                    <% request.setAttribute("t1", 0);%>
                                    <div class="notification error1 png_bg">
                                        <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
					 Error ! tryagain.
                                        </div>
                                    </div>

                                </c:when>
                            </c:choose>

                            <c:set var="t6" value="<%= request.getAttribute("t6")%>"/>
                            <c:choose>
                                <c:when test="${t6=='1'}">
                                    <% request.setAttribute("t6", 0);%>
                                    <div class="notification success png_bg">
                                        <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
					 Updated Successfully
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${t6=='2'}">
                                    <% session.setAttribute("t6", 0);%>
                                    <div class="notification error1 png_bg">
                                        <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
			          There was some error.
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>

                            <c:set var="t7" value="<%= request.getAttribute("t7")%>"/>
                            <c:choose>
                                <c:when test="${t7=='1'}">
                                    <% request.setAttribute("t7", 0);%>
                                    <div class="notification success png_bg">
                                        <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
					 Deleted Successfully
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${t7=='2'}">
                                    <% session.setAttribute("t7", 0);%>
                                    <div class="notification error1 png_bg">
                                        <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
			          There was some error.
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>

                            <table   class="ed" cellspacing="0" cellpadding="0" style="color:#000">
                                <table>
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Date From</th>                                        
                                        <th>Date To</th>                                  
                                        <th>Rate</th>                                        
                                        <th>Action</th>

                                    </tr>
                                </thead>

                                <c:url var="discountrate" value="<%= request.getParameter("discountrate")%>"></c:url>
                                <c:if test="${discountrate==1}">
                                    <c:set var="discountrate" value="0"></c:set>                                    
                                        <form  id="form" method="post" action="<%=request.getContextPath()%>/SetDiscountRate" >
                                            <tr>
                                                <td></td>
                                                <td><input  type="text" name="dateFrom"  id="dateFrom" size="8px;" class="required"/></td>

                                                <td><input  type="text" name="dateTo" id="dateTo" size="8px;" class="required"/></td>

                                                <td> <input  type="text"  name="rate"  id="rate" size="8px;"  class="required"/></td>

                                                <td><input  type="submit"  class="savebutton" value=""/>&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/discountRate"><label class="delbutton"></label></a></td>
                                            </tr>
                                        </form>
                                    
                                </c:if>

                               

                                    <c:forEach   var="discountRateList" items="${discountRateList}" >

                                        <form id="form${chl}"  method="post" action="<%=request.getContextPath()%>/editDiscountRate">

                                            <tr>
                                                <td><input type="hidden" id="id" name="id" value="${discountRateList.id}" readonly/></td>
                                                <td><fmt:formatDate pattern="dd/MM/yy" value="${discountRateList.dateFrom}" var="date_from"/> <input type="text" id="date_From" name="date_From"    value="${date_from}" size="8px;" readonly/></td>
                                                <td> <fmt:formatDate pattern="dd/MM/yy" value="${discountRateList.dateTo}" var="date_to"/><input type="text" id="date_To" name="date_To"  value="${date_to}" size="8px;" readonly/></td>
                                                <td><input type="text" id="Rate" name="Rate"   value="${discountRateList.rate}" size="8px;" readonly/></td>
                                                <td id="edit${chl}"  style="display:inline-block">  <a href="#bottom" onclick="editableChl(${chl})"><label class="button" >EDIT</label></a></td>
                                                <td id="save${chl}" style="display:none"><input  type="submit"  class="savebutton" value="" size="8px;"/>&nbsp;&nbsp;
                                                <a id="del${chl}" style="display:none" href="<%=request.getContextPath()%>/deleteDiscountRate?id=${discountRateList.id}" onclick="return confirmDel()" ><label  class="delbutton" ></label></a></td>
                                            </tr>
                                            <c:set var="chl" value="${chl+1}"></c:set>
                                        </form>
                                    </c:forEach>                                
                                </table>
                            </table>
                        </div>
                        <br> <br>

                    </div>
                </div>
            </div>

            <jsp:include page="../common/footer.jsp"/>
        </div>
    </body>
</html>
