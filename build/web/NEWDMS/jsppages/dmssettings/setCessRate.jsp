<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="com.smp.entity.CessRate"%>
<%@page import="com.smp.manager.InterestRateManager"%>
<%@page import="com.smp.session.CessRateFacade"%>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>



<%@page  language="java" import="javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="ch" value="1"></c:set>

<html>
    <title>Search</title>
    <jsp:include page="../common/header.jsp"/>
    <script  type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.validate_1.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.maskedinput-1.2.2.js"></script>

    <script  type="text/javascript">
        $(document).ready(function()
        {
            $("#dateFrom1").mask("99/99/99");
            $("#dateTo1").mask("99/99/99");
             $("#form").validate();
           
        });
        function makeEditableChl2(chl)
        {

            var txt_inp = document.getElementsByTagName('input');
            var i, j=1,k=1;

            for(i=0; i< txt_inp.length; i++)
            {

                if(txt_inp[i].type == "text" || txt_inp[i].type == "hidden" )
                {
                    var x = txt_inp[i];


                    // get or set id


                    if(x.name=="conType"||x.name=="dateFrom"||x.name=="dateTo"||x.name=="pipeSize"||x.name=="rate")

                    {

                        x.id = "Id"+j; // We are dynamically setting and ID
                        Id="Id"+j;
                        // document.getElementById(Id).removeAttribute("readonly");
                        if((j==((chl-1)*5)+k) && k<=5)
                        {
                            document.getElementById(Id).removeAttribute("readonly");
                            if(x.name=="dateFrom"||x.name=="dateTo")
                            {                                
                                $("#"+Id).mask("99/99/99");
                            }

                            k++;
                            document.getElementById("edit"+chl).style.display="none";
                            document.getElementById("save"+chl).style.display="inline-block";
                            document.getElementById("del"+chl).style.display="inline-block";
                        }
                        //x.id="";
                        j++;
                    }
                }

            }


        }

       
        function confirmDelete()
        {
            var msg;
            msg="Do you want to delete this record permanently?"
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


                <div class="content-box"><!-- Start Content Box -->
                    <div class="content-box-header">
                        <h3>Cess Rate</h3>  
                        <div class="content-box-tabs">


                            <a href="<%= request.getContextPath()%>/NEWDMS/jsppages/dmssettings/setCessRate.jsp?chl=1#bottom"><label class="button">New Cess Rate</label></a>


                        </div>

                        <div class="clear"></div>


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
                            <c:when test="${t=='2'}">
                                <% request.setAttribute("t", 0);%>

                                <div class="notification success png_bg">
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>
					Data Inserted Successfuly.
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${t=='3'}">
                                <% request.setAttribute("t", 0);%>

                                <div class="notification success png_bg">
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>
					Data updated Successfuly.
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${t=='4'}">
                                <% request.setAttribute("t", 0);%>

                                <div class="notification success png_bg">
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>
					Data deleted Successfuly.
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${t=='1'}">
                                <% request.setAttribute("t", 0);%>
                                <div class="notification error1 png_bg">
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>
					 Error ! tryagain.
                                    </div>
                                </div>

                            </c:when>
                        </c:choose>



                    </div> <!-- End .content-box-header -->



                    <table     cellspacing="0" cellpadding="0" style="color:#000">
                        
                        <thead>
                            <tr>
                                <th></th>
                                <th>Conn Type</th>
                                <th>Date From</th>
                                <th>Date To</th>
                                <th>Pipe Size</th>                                
                                <th>Rate</th>                                
                                <th>Action</th>

                            </tr>
                        </thead>
                        <c:url var="chl" value="<%= request.getParameter("chl")%>"></c:url>
                        <c:if test="${chl==1}">
                            <c:set var="chl" value="0"></c:set>

                            
                                <form  id="form" method="post" action="<%=request.getContextPath()%>/InsertCessRate" >
                                    <tr><td></td>
                                        <td><input  type="text" name="conType1"  id="conType1" size="8px;" class="required" /></td>

                                        <td><input  type="text" name="dateFrom1"  id="dateFrom1" size="8px;" class="required"/></td>

                                        <td><input  type="text" name="dateTo1" id="dateTo1" size="8px;" class="required"/></td>

                                        <td><input  type="text" name="pipeSize1"  id="pipeSize1" size="8px;" class="required"/></td>

                                        <td> <input  type="text"  name="rate1"  id="rate1" size="8px;" class="required"/></td>

                                        <td ><input  type="submit"  class="savebutton" value=""/>&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/NEWDMS/jsppages/dmssettings/setCessRate.jsp?chl=0#bottom"><label class="delbutton"></label></a></td>
                                    </tr>

                                </form>
                            
                        </c:if>
                        

                            <c:forEach   var="rlist" items="${cessRateList}" >

                                <form id="form${ch}"  method="post" action="<%=request.getContextPath()%>/EditCessRate">

                                    <tr>
                                        <td><input type="hidden" name="id" id="id" value="${rlist.id}" readonly/></td>
                                        <td><input type="text" name="conType" id="conType"  value="${rlist.conType}" size="8px;" readonly/></td>
                                        <td><fmt:formatDate pattern="dd/MM/yy" value="${rlist.dateFrom}" var="date_from"/> <input type="text" name="dateFrom"  id="dateFrom"  value="${date_from}" size="8px;" readonly/></td>
                                        <td> <fmt:formatDate pattern="dd/MM/yy" value="${rlist.dateTo}" var="date_to"/><input type="text" name="dateTo" id="dateTo"  value="${date_to}" size="8px;" readonly/></td>
                                        <td><input type="text" name="pipeSize" id="pipeSize"  value="${rlist.pipeSize}" size="8px;" readonly/></td>
                                        <td><input type="text" name="rate" id="rate"   value="${rlist.rate}" size="8px;" readonly/></td>
                                        <td id="edit${ch}"  style="display:inline-block">  <a href="#bottom" onclick="makeEditableChl2(${ch})"><label class="button" >EDIT</label></a></td>
                                        <td id="save${ch}" style="display:none"><input  type="submit"  class="savebutton" value="" size="8px;"/>&nbsp;&nbsp;
                                        <a id="del${ch}" style="display:none" href="<%=request.getContextPath()%>/DeleteCessRate?id=${rlist.id}" onclick="return confirmDelete()" ><label  class="delbutton" ></label></a></td>
                                    </tr>
                                    <c:set var="ch" value="${ch+1}"></c:set></form>

                            </c:forEach>
                        
                        
                    </table>

                </div>
            </div>

            <jsp:include page="../common/footer.jsp"/>
        </div>

    </body>
</html>
