

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    Document   : home
    Created on : 24 Feb, 2010, 2:59:31 PM
    Author     : smp
--%>
<%@page  language="java" import="javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" %>
<%!    int len;
    String xmlpath;
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <title>New Master</title>
    <jsp:include page="../common/header.jsp"/>
    <script  type="text/javascript" src="<%=request.getContextPath()%>/NEWDMS/resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/NEWDMS/resources/jquery/jquery.validate_1.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/NEWDMS/resources/jquery/jquery.maskedinput-1.2.2.js"></script>
    <script  type="text/javascript">
        $(document).ready(function(){
            $("#conn_dt").mask("99/99/99");
            $("#esti_dt").mask("99/99/99");
            $("#nodue_dt").mask("99/99/99");
            $("#cal_date").mask("99/99/99");
            $("#s_con_dt").mask("99/99/99");
            $("#s_est_pdt").mask("99/99/99");
            $("#s_nodue_dt").mask("99/99/99");
            $("#pos_dt").mask("99/99/99");
            $("#comp_dt").mask("99/99/99");

            $("#new_mst").validate();
        });


       

        function clearUserID()
        {
            if(document.getElementById("cons_no").value=="")
            {
                document.getElementById("lcons_no").style.visibility="hidden";
            }
        }

        function populateCons(){
            var sector= document.getElementById("sec").value;
        if(document.getElementById("sec").value<100)
            {
                var sec="0"+document.getElementById("sec").value;
            }
          else if(document.getElementById("sec").value=="11IND"||document.getElementById("sec").value=="14A"||document.getElementById("sec").value=="15A"||document.getElementById("sec").value=="16A"||document.getElementById("sec").value=="37ADD")
            {
                var sec="0"+parseInt(document.getElementById("sec").value, 10);
            }
            else {
                var sec=parseInt(document.getElementById("sec").value, 10);
            }
            document.getElementById("cons_no1").value=sec;
        }
        
        function checkMst()
        {
            cons_no= document.getElementById("cons_no").value
            cons_no1=document.getElementById("cons_no1").value
           
            if(document.getElementById("cons_no").value!="")
            {
                xmlHttp=GetXmlHttpObject()
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request")
                    return
                }
                var url="<%=request.getContextPath()%>/CheckConsumer"
                
                url=url+"?&cons_no="+cons_no1+cons_no
                xmlHttp.onreadystatechange=stateChanged1
                xmlHttp.open("GET",url,true)
                xmlHttp.send(null)
            }
            else if(document.getElementById("cons_no").value=="")
            {
                document.getElementById("lcons_no").style.visibility="hidden";
            }
          
        }


        function stateChanged1()
        {
            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
            {
                var showdata = xmlHttp.responseText;
                var data=showdata.split(":");
                if(data[0]==1)
                {
                    document.getElementById("lcons_no").style.visibility="visible";
                    document.getElementById("cons_no").focus();
                    data[0]=0;
                }
                else if(data[0]==0)
                {
                    document.getElementById("lcons_no").style.visibility="hidden";

                }

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

                <div class="content-box"><!-- Start Content Box -->

                    <div class="content-box-header">


                        <h3>Consumer Details</h3>
                        <ul class="content-box-tabs">

                        </ul>
                        <div class="clear"></div>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">

                        <div class="tab-content default-tab" id="tab1">


                            <noscript> <!-- Show a notification if the user has disabled javascript -->
                                <div class="notification error1 png_bg">
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>

						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                                    </div>
                                </div>

                            </noscript>
                            <div>
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

                            <form id="new_mst"  method="post" action="<%=request.getContextPath()%>/InsertConsumer">
                                <table class="ed" >
                                    <tr>
                                        <th>Sector</th>
                                        <td>
                                            <select name="sec" id="sec" other="#blk_no" class="required" onchange="populateCons()" style="width: 155px;" >
                                                <option value="">select</option>
                                                <c:forEach var="sector" items="${sectorList}">
                                                    <option value="${sector}">${sector}</option>
                                                </c:forEach>
                                            </select>

                                        </td>
                                        <th>Consumer Number</th>
                                        <td> <input type="text" name="cons_no1" id="cons_no1" class="short required" size="1"/>
                                            <input type="text" name="cons_no" id="cons_no" class="short required" minlength="5"  maxlength="6" size="14" onblur="return checkMst()" />
                                            <label id="lcons_no" class="error" style="visibility:hidden" >Cons no. already exists.</label></td>
                                         </tr>
                                    <tr>

                                        <th>Consumer Name 1</th>
                                        <td><input type="text" name="cons_nm1" id="cons_nm1" maxlength="30" /></td>

                                        <th>Consumer Name 2</th>
                                        <td><input type="text" name="cons_nm2" id="cons_nm2" maxlength="30"/></td>
                                    </tr>


                                    <tr>
                                        <th class="heading">Connection Details</th>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th>Connection Type</th>
                                        <td>
                                            <select name="con_tp" id="con_tp" style="width: 155px;" >
                                                <option value="">N.A</option>
                                                <option value="R">Residential</option>
                                                <option value="I">Industrial</option>
                                                <option value="C">Commercial</option>
                                                <option value="T">Institutional</option>
                                                <option value="S">Staff</option>
                                                <option value="G">Group Housing</option>
                                            </select>
                                        </td>
                                        <th>Connection Category</th>
                                        <td>
                                            <select name="cons_ctg" id="cons_ctg" style="width: 155px;" >
                                                <option value="">N.A</option>
                                                <option value="R">Regular</option>
                                                <option value="T">Temporary</option>
                                            </select>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>Flat Type</th>
                                        <td><input type="text" name="flat_type" id="flat_type" maxlength="6"/></td>
                                        <th>Flat No</th>
                                        <td><input type="text" name="flat_no" id="flat_no" maxlength="10"/></td>
                                    </tr>
                                    <tr>
                                        <th>Block No</th>

                                        <td><input type="text" name="blk_no" id="blk_no"/></td>
                                        <th>Plot Size</th>
                                        <td><input type="text" name="plot_size" id="plot_size" class="number"/></td>
                                       
                                    </tr>
                                    <tr>
                                        
                                        <th>Pipe Size</th>
                                        <td><input type="text" name="pipe_size" id="pipe_size" class="number"/></td>
                                        <th>Registration No</th>
                                        <td><input type="text" name="reg_no" id="reg_no" maxlength="8"/></td>
                                    </tr>

                                    <tr>
                                         <th>Estimation No</th>

                                        <td><input type="text" name="esti_no" id="esti_no" maxlength="8"/></td>
                                        <th>Connection Date</th>
                                        <td><input type="text" name="conn_dt" id="conn_dt"  class="date"/></td>
                                    </tr>
                                    <tr>
                                       
                                        <th>Estimate Amount</th>
                                        <td><input type="text" name="esti_amt" id="esti_amt" class="number"/></td>
                                         <th>Security</th>
                                        <td><input type="text" name="secu" id="secu" class="number"/></td>
                                    </tr>
                                    <tr>
                                       
                                        <th>Estimate Paid Date</th>

                                        <td><input type="text" name="esti_dt" id="esti_dt" class="date"/></td>
                                        <th>Estimate Paid Amount</th>
                                        <td><input type="text" name="esti1_amt" id="esti1_amt" class="number"/></td>
                                    </tr>
                                    <tr>
                                        
                                        <th>No Due Amount</th>
                                        <td><input type="text" name="nodue_amt" id="nodue_amt" class="number"/></td>
                                        <th>NoDue Date</th>
                                        <td><input type="text" name="nodue_dt" id="nodue_dt" class="date" /></td>
                                    </tr>

                                    <tr>
                                         <th>Possession Date</th>
                                        <td><input type="text" name="pos_dt" id="pos_dt" class="date" /></td>
                                        <th>Calculation Date</th>
                                        <td><input type="text" name="cal_date" id="cal_date" class="date" /></td>
                                    </tr>
                                    <tr>
                                       
                                        <th>Completion Date</th>
                                        <td><input type="text" name="comp_dt" id="comp_dt"  class="date"/></td>
                                        <th></th>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th class="heading">Sewer Details</th>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th>Sewer Registration No</th>
                                        <td><input type="text" name="s_reg_no" id="s_reg_no" maxlength="8"/></td>
                                        <th>Sewer Connection Date</th>
                                        <td><input type="text" name="s_con_dt" id="s_con_dt" class="date" /></td>
                                    </tr>
                                    <tr>
                                        <th>Sewer Estimate No</th>
                                        <td><input type="text" name="s_est_no" id="s_est_no" maxlength="8"/></td>
                                        <th>Sewer Estimate Amount</th>
                                        <td><input type="text" name="s_est_amt" id="s_est_amt" class="number" /></td>
                                    </tr>
                                    <tr>
                                        <th>Sewer Security</th>
                                        <td><input type="text" name="s_secu" id="s_secu" class="number" /></td>
                                        <th>Sewer Estimate Paid Date</th>
                                        <td><input type="text" name="s_est_pdt" id="s_est_pdt" /></td>
                                    </tr>
                                    <tr>
                                        <th>Sewer Estimate Paid Amount</th>
                                        <td><input type="text" name="s_est_pamt" id="s_est_pamt" class="number"/></td>
                                        <th>Sewer Nodue Amount</th>
                                        <td><input type="text" name="s_nodue_amt" id="s_nodue_amt" class="number"/></td>
                                    </tr>
                                    <tr>
                                        <th>Sewer NoDue Date</th>
                                        <td><input type="text" name="s_nodue_dt" id="s_nodue_dt" class="date" /></td>
                                        <td></td><td></td>
                                    </tr>


                                    <tr>
                                        <th class="heading">Transfer Details</th>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th>Transfer Name</th>
                                        <td><input type="text" name="trans_nm" id="trans_nm"/></td>
                                        <th>Connection Type</th>
                                        <td>
                                            <select name="t_con_type" id="t_con_type" style="width: 155px;" >
                                                <option value="">N.A</option>
                                                <option value="R">Residential</option>
                                                <option value="I">Industrial</option>
                                                <option value="C">Commercial</option>
                                                <option value="T">Institutional</option>
                                                <option value="S">Staff</option>
                                                <option value="G">Group Housing</option>
                                            </select>
                                        </td>
                                    </tr>


                                    <tr>

                                        <th>Transfer Flat Type</th>
                                        <td><input type="text" name="t_flat_type" id="t_flat_type"/></td>
                                        <th>Connection Category</th>
                                        <td>
                                            <select name="t_con_ctg" id="t_con_ctg" style="width: 155px;" >
                                                <option value="">N.A</option>
                                                <option value="R">Regular</option>
                                                <option value="T">Temporary</option>
                                            </select>
                                        </td>
                                    </tr>

                                </table>
                                <div align="center"> <input  type="submit" id="SUBMIT" class="button" value="SUBMIT" />
                                    <input  type="reset" id="RESET" class="button" value="RESET" /></div>

                            </form>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../common/footer.jsp"/>
            </div>
        </div>
    </body>
</html>
