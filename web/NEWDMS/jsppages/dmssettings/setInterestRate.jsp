<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="com.smp.entity.InterestRates"%>
<%@page import="com.smp.manager.InterestRateManager"%>
<%@page import="com.smp.session.InterestRatesFacade"%>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>



<%@page  language="java" import="javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="chl" value="1"></c:set>
<html>
    <title>Search</title>
    <jsp:include page="../common/header.jsp"/>
    <script  type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.validate_1.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.maskedinput-1.2.2.js"></script>

    <script  type="text/javascript">
        $(document).ready(function()
        {
            $("#datefrom").mask("99/99/99");
            $("#dateto").mask("99/99/99");
             $("#form").validate();
        });
         
        function makeEditableChlRates(chl1)
        {
            var txt_inp = document.getElementsByTagName('input');
            var i, j=1,k=1;

            for(i=0; i< txt_inp.length; i++)
            {

                if(txt_inp[i].type == "text"||txt_inp[i].type == "hidden")
                {
                    var x = txt_inp[i];


                    // get or set id


                    if(x.name=="id"||x.name=="dateFrom"||x.name=="dateTo"||x.name=="rate")

                    {

                        x.id = "ID"+j; // We are dynamically setting and ID
                        Id="ID"+j;
                                     
                        if((j==((chl1-1)*4)+k) && k<=4)
                        {
                            document.getElementById(Id).removeAttribute("readonly");
                        
                            if(x.name=="dateFrom"||x.name=="dateTo")
                            {
                                $("#"+Id).mask("99/99/99");
                            }
                            
                            k++;
                            document.getElementById("edit"+chl1).style.display="none";
                            document.getElementById("save"+chl1).style.display="inline-block";
                            document.getElementById("del"+chl1).style.display="inline-block";
                        }
                        //x.id="";
                        j++;
                    }
                }

            }


        }

        function closeInterestRate()
        {
             xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return;
            }

            var url= "<%=request.getContextPath()%>/closeNewRate";
            xmlHttp.onreadystatechange=statechanged;
            xmlHttp.open("POST",url,true);
            xmlHttp.send(null);

        }
        function confirmDel()
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




                    <noscript> <!-- Show a notification if the user has disabled javascript -->
                        <div class="notification error1 png_bg">
                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                            <div>

						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                            </div>
                        </div>

                    </noscript>
                    <div class="content-box-header">
                        <h3>Interest Rate</h3> <img   src="../../resources/images/icons/bottom.png"/>
                        <div class="content-box-tabs">


                            <a href="<%= request.getContextPath()%>/NEWDMS/jsppages/dmssettings/setInterestRate.jsp?newInterestRate=1#bottom"><label class="button">New Interest Rate</label></a>


                        </div>

                        <div class="clear"></div>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">

                        <table   class="ed" cellspacing="0" cellpadding="0" style="color:#000">
                            <table>   <thead>
                                    <tr>
                                        <th></th>
                                        <th>Date From</th>
                                        <th>Date To</th>
                                        <th> Rate</th>
                                        <th >Action</th>

                                    </tr>
                                </thead>

                                <c:url var="newInterestRate" value="<%= request.getParameter("newInterestRate")%>"></c:url>
                                <c:if test="${newInterestRate==1}">
                                    <c:set var="newInterestRate" value="0"></c:set>

                                    
                                    <form  id="form" method="post" action="<%=request.getContextPath()%>/InsertInterestRate" >
                                        <tr><td></td>
                                            <td><input  type="text" name="date_From"  id="datefrom" size="8px;"  class="required"/></td>

                                            <td><input  type="text" name="date_To" id="dateto" size="8px;"  class="required"/></td>

                                            <td> <input  type="text"  name="rates"  id="rates" size="8px;"  class="required"/></td>

                                            <td colspan="3"><input  type="submit"  class="savebutton" value=""/>&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/closeNewInterestRate"><label class="delbutton"></label></a></td>
                                        </tr>

                                    </form>
                                   
                                </c:if>



                                <c:forEach   var="rlist" items="${interestRateList}" >
                                    <form id="form${chl}"  method="post" action="<%=request.getContextPath()%>/EditInterestRate">

                                        <tr>
                                            <td><input type="hidden" name="id" id="id" value="${rlist.id}" size="8px;" readonly/></td>
                                            <td><fmt:formatDate pattern="dd/MM/yy" value="${rlist.dateFrom}" var="date_from"/> <input type="text" id="dateFrom" name="dateFrom"    value="${date_from}" size="8px;" readonly/></td>
                                            <td> <fmt:formatDate pattern="dd/MM/yy" value="${rlist.dateTo}" var="date_to"/><input type="text" id="dateTo" name="dateTo"  value="${date_to}" size="8px;" readonly/></td>
                                            <td><input type="text" id="rate" name="rate"   value="${rlist.rate}" size="8px;" readonly/></td>
                                            <td  id="edit${chl}"  style="display:inline-block">  <a href="#bottom" onclick="makeEditableChlRates(${chl})"><label class="button" >EDIT</label></a></td>
                                            <td id="save${chl}" style="display:none"><input  type="submit"  class="savebutton" value="" size="8px;"/>&nbsp;&nbsp;
                                             <a id="del${chl}" style="display:none" href="<%=request.getContextPath()%>/DeleteInterestRate?id=${rlist.id}" onclick="return confirmDel()" ><label  class="delbutton" ></label></a></td>
                                        </tr>
                                        <c:set var="chl" value="${chl+1}"></c:set></form></c:forEach>
                                </table>


                            </table>
                        </div>

                    </div>
                </div>

            <jsp:include page="../common/footer.jsp"/>
        </div>
    </body>
</html>
