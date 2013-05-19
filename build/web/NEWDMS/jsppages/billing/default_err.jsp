<%-- 
    Document   : default_err
    Created on : 13 Apr, 2010, 11:21:08 AM
    Author     : smp
--%>
<% if (session.getAttribute("dflag").equals("0")) {
                response.setHeader("refresh", "1");
            } else {
                response.setHeader("refresh", "2000");
                if (session.getAttribute("dflag").equals("2")) {
                    // request.getRequestDispatcher("/DefaultPdf?division=1").forward(request, response);
                    response.sendRedirect("/NEWDMS/printDefaulter");
                    session.setAttribute("dflag", "1");
                    session.setAttribute("defaultstatus", "0");
                }
            }

%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@page  language="java" import="javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" %>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <title>Defaulter Generation</title>
    <jsp:include page="../common/header.jsp"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/NEWDMS/resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/NEWDMS/resources/jquery/jquery.validate_1.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/NEWDMS/resources/jquery/jquery.maskedinput-1.2.2.js"></script>

    <script  type="text/javascript">
        $(document).ready(function()
        {

           
            $("#billdate1").mask("99/99/99");

            $("#form6").validate();
            $("#form7").validate();



        });
        
      

      
        function cancel()
        {
            xmlHttp=GetXmlHttpObject()

            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }
            xmlHttp.open("GET","CanceldefaultPDF",true)
            //xmlHttp.onreadystatechange=progressbar
            xmlHttp.send(null)

        }
        function getDefaulterList()
        {
            // progressbar();
          
            xmlHttp=GetXmlHttpObject()

            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }
            // var url="<%=request.getContextPath()%>/CalculateBillForSector?sector="+sector+"&block="+block+"&con_tp="+con_tp+"&cons_no_fr="+cons_no_fr+"&cons_no_to="+cons_no_to+"&billdate="+billdate

            //alert(url)
            xmlHttp.open("GET","b",true)
            xmlHttp.onreadystatechange=progressbar
            xmlHttp.send(null)

        }
        function progressbar()
        {
            var data=  xmlHttp.responseText;
            if(xmlHttp.readyState == 1 || xmlHttp.readyState == 2 || xmlHttp.readyState == 3 || xmlHttp.readyState == 4)
            {

                window.location.href="b"
            }
          
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

                <div class="content-box column-left">

                    <div class="content-box-header"> <!-- Add the class "closed" to the Content box header to have it closed by default -->

                        <h3>Defaulter's List</h3>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">

                        <div class="tab-content default-tab">
                            <noscript> <!-- Show a notification if the user has disabled javascript -->
                                <div class="notification error1 png_bg">
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>

						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                                    </div>
                                </div>

                            </noscript>
                            <form id="form6" name="form4" action="<%= request.getContextPath()%>/GetPdf" onsubmit="getDefaulterList()" >
                                <%
                                            String sectorOption;
                                            String disableValue = "false";
                                            if (session.getAttribute("sector") != null) {
                                                sectorOption = session.getAttribute("sector").toString();
                                                disableValue = "true";
                                            } else {
                                                sectorOption = "select";
                                                disableValue = "false";
                                            }
                                            System.out.println("sectorOption-->" + sectorOption + disableValue);
                                %>
                                <p><label class="form-label">Sector</label>

                                    <select name="sector" id="sector"  class="required" >
                                        <option value=""><%=sectorOption%></option>
                                        <c:forEach var="sector" items="${sectorList}">
                                            <option value="${sector}">${sector}</option>
                                        </c:forEach>
                                    </select>


                                <p><label class="form-label">Due Date</label>
                                    <%
                                                String billDateOption = "";
                                                if (session.getAttribute("billdate") != null) {
                                                    billDateOption = session.getAttribute("billdate").toString();

                                                } else {
                                                    billDateOption = "";

                                                }

                                                System.out.println("Bill Date------->" + session.getAttribute("billdate"));
                                    %>
                                    <input value="<%=billDateOption%>" type="text" name="billdate" id="billdate1" class="required date"/>
                                </p>
                                <c:if test="${defaultstatus gt 0}">
                                    <div  style="border: 1px solid black; width: 68%">
                                        <div id="progress" style="background-color:green; width:${defaultstatus}%">&nbsp;</div>
                                    </div><b>${defaultstatus}%</b></c:if>
                                    <br/>
                                <% if (session.getAttribute("disable") != null) {

                                %>
                                <input type="submit" class="button1" value="GET DEFAULTERS" disabled="true"/>
                                <% } else {
                                %>

                                <input type="submit" class="button" value="GET DEFAULTERS"/>
                                <%}%>

                                <input type="button" class="button" onclick="cancel()" value="Cancel"/>
                            </form>

                        </div> <!-- End #tab3 -->

                    </div> <!-- End .content-box-content -->

                </div> <!-- End .content-box -->

                <div class="content-box column-right"><!-- Start Content Box -->

                    <div class="content-box-header">

                        <h3>Error list for a sector</h3>

                        <div class="clear"></div>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">
                        <form id="form7" name="form7" action="<%= request.getContextPath()%>/Error">
                            <%
                                        String sectorOption1;

                                        if (session.getAttribute("sector1") != null) {
                                            sectorOption1 = session.getAttribute("sector1").toString();
                                            disableValue = "true";
                                        } else {
                                            sectorOption1 = "select";

                                        }
                                        System.out.println("sectorOption-->" + sectorOption1 + disableValue);
                            %>
                            <p><label class="form-label">Sector</label>

                                <select name="sector1" id="sector1" class="required" >
                                    <option value=""><%=sectorOption1%></option>
                                    <c:forEach var="sector" items="${sectorList}">
                                        <option value="${sector}">${sector}</option>
                                    </c:forEach>
                                </select>
                            <p>
                                <%if (session.getAttribute("disable") != null) {

                                %>
                                <input type="submit" class="button1" value="GET ERROR LIST" disabled="true" />
                                <%} else {
                                %>
                                <input type="submit" class="button" value="GET ERROR LIST"  />
                                <%}%>


                            </p>
                        </form>

                    </div>
                </div>
                <div class="clear"></div>
                <jsp:include page="../common/footer.jsp"/>
            </div> <!-- End #main-content -->

        </div></body>

</html>
