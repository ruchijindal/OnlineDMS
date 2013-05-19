<%--
    Document   : home
    Created on : 24 Feb, 2010, 2:59:31 PM
    Author     : smp
--%>
<% if (session.getAttribute("flag1").equals("0")) {
                response.setHeader("refresh", "1");
            } else {
                response.setHeader("refresh", "2000");
                if (session.getAttribute("flag1").equals("2")) {
                    //request.getRequestDispatcher("/getLedgerList").forward(request, response);
                    response.sendRedirect("/NEWDMS/getLedgerList");
                    session.setAttribute("flag1", "1");
                    session.setAttribute("status1", "0");
                }
            }
%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %> 
<%@page  language="java" import="javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" %>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>
<%!    int len;
    String xmlpath;
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <title>Ledger Generation</title>
    <jsp:include page="../common/header.jsp"/>
    <script  type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.validate_1.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.maskedinput-1.2.2.js"></script>

    <script  type="text/javascript">

        $(document).ready(function(){
                
            $("#billdate").mask("99/99/99");
            $("#billdate1").mask("99/99/99");

            $("#form5").validate();
            $("#form6").validate();
        });


        window.onload = function()
        {
            document.getElementById("cons_no").focus();
        }



        //***************List of Blocks*************************//

        function populateBlocks()
        {

            var sector= document.getElementById("sector").value;
            xmlHttp=GetXmlHttpObject()

            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }
            fetchValues("s");
            var url="<%= request.getContextPath()%>/GetBlocks"
            url=url+"?&sector="+sector;

            xmlHttp.onreadystatechange=setBlock
            xmlHttp.open("GET",url,true)
            xmlHttp.send(null)
        }
        function setBlock()
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
        //******************************************************//

        //*****************for single consumer********************//


        function clearUserID()
        {
            var consumer=  document.getElementById("cons_no").value;

            if(consumer.length <8)
            {
                document.getElementById("lcons_no").style.visibility="hidden";
            }
            else
            {
                cons_no= document.getElementById("cons_no").value

                if(document.getElementById("cons_no").value!="")
                {
                    xmlHttp=GetXmlHttpObject()
                    if (xmlHttp==null)
                    {
                        alert ("Browser does not support HTTP Request")
                        return
                    }
                    var url="<%=request.getContextPath()%>/CheckConsumer"
                    url=url+"?&cons_no="+cons_no
                    xmlHttp.onreadystatechange=stateChanged
                    xmlHttp.open("GET",url,true)
                    xmlHttp.send(null)
                }
                else if(document.getElementById("cons_no").value=="")
                {
                    document.getElementById("lcons_no").style.visibility="hidden";
                }

            }
        }

//        function checkMst()
//        {
//            cons_no= document.getElementById("cons_no").value
//
//            if(document.getElementById("cons_no").value!="")
//            {
//                xmlHttp=GetXmlHttpObject()
//                if (xmlHttp==null)
//                {
//                    alert ("Browser does not support HTTP Request")
//                    return
//                }
//                var url="<%=request.getContextPath()%>/CheckConsumer"
//                url=url+"?&cons_no="+cons_no
//                xmlHttp.onreadystatechange=stateChanged
//                xmlHttp.open("GET",url,true)
//                xmlHttp.send(null)
//            }
//            else if(document.getElementById("cons_no").value=="")
//            {
//                document.getElementById("lcons_no").style.visibility="hidden";
//            }
//
//
//        }


      
        function stateChanged()
        {
            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
            {
                var showdata = xmlHttp.responseText;
                var data=showdata.split(":");
                if(data[0]==0)
                {
                    document.getElementById("lcons_no").style.visibility="visible";
                    document.getElementById("cons_no").focus();
                    document.getElementById("flag").value="1";
                    data[0]=1;
                }
                else if(data[0]==1)
                {
                    document.getElementById("lcons_no").style.visibility="hidden";
                    document.getElementById("flag").value="0";

                }

            }
        }
        //****************************************************************//
        //*****************For consumer from****************************//

        function clearUserIDFr()
        {
            if(document.getElementById("cons_no_fr").value=="")
            {
                document.getElementById("lcons_no_fr").style.visibility="hidden";
            }
        }

        function checkMstFr()
        {
            fetchValues("con_n_f");
            cons_no_fr= document.getElementById("cons_no_fr").value
            alert(cons_no_fr);
            sec=document.getElementById("sec").value
            
            if(document.getElementById("cons_no_fr").value!="")
            {

                
                xmlHttp=GetXmlHttpObject()
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request")
                    return
                }
                var url="check_conssec.jsp"
                url=url+"?&cons_no="+cons_no_fr+"&sec="+sec
                xmlHttp.onreadystatechange=stateChangedFr
                xmlHttp.open("GET",url,true)
                xmlHttp.send(null)
            }
            else if(document.getElementById("cons_no_fr").value=="")
            {
                document.getElementById("lcons_no_fr").style.visibility="hidden";
            }
        }

        function stateChangedFr()
        {
            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
            {
                var showdata = xmlHttp.responseText;
                var data=showdata.split(":");
                if(data[0]==0)
                {
                    document.getElementById("lcons_no_fr").style.visibility="visible";
                    document.getElementById("cons_no_fr").focus();
                    data[0]=1;
                }
                else if(data[0]==1)
                {
                    document.getElementById("lcons_no_fr").style.visibility="hidden";

                }

            }
        }
        /********************************************************************************/
        /*****************For consumer to****************************/

        function clearUserIDTo()
        {
            if(document.getElementById("cons_no_to").value=="")
            {
                document.getElementById("lcons_no_to").style.visibility="hidden";
            }
        }

        function checkMstTo()
        {
            fetchValues("con_n_t");
            cons_no_to= document.getElementById("cons_no_to").value
            sec=document.getElementById("sec").value

            if(document.getElementById("cons_no_to").value!="")
            {
                
                xmlHttp=GetXmlHttpObject()
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request")
                    return
                }
                var url="check_conssec.jsp"
                url=url+"?&cons_no="+cons_no_to+"&sec="+sec
                xmlHttp.onreadystatechange=stateChangedTo
                xmlHttp.open("GET",url,true)
                xmlHttp.send(null)
            }
            else if(document.getElementById("cons_no_to").value=="")
            {
                document.getElementById("lcons_no_to").style.visibility="hidden";
            }
        }

        function stateChangedTo()
        {
            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
            {
                var showdata = xmlHttp.responseText;
                var data=showdata.split(":");
                if(data[0]==0)
                {
                    document.getElementById("lcons_no_to").style.visibility="visible";
                    document.getElementById("cons_no_to").focus();
                    data[0]=1;
                }
                else if(data[0]==1)
                {
                    document.getElementById("lcons_no_to").style.visibility="hidden";

                }


            }
        }
        /********************************************************************************/
   


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

        function getLedgerList(){
            var flag=document.getElementById("flag").value;
            if(flag==1)
            {
                return false;
            }else{
                xmlHttp=GetXmlHttpObject()

                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request")
                    return
                }
                xmlHttp.open("GET","l",true)
                xmlHttp.onreadystatechange=progressbar
                xmlHttp.send(null)
            }
        }

        function progressbar()
        {
            var data=  xmlHttp.responseText;
            if(xmlHttp.readyState == 1 || xmlHttp.readyState == 2 || xmlHttp.readyState == 3 || xmlHttp.readyState == 4)
            {

                window.location.href="l"
            }

        }

        function cancel()
        {
            xmlHttp=GetXmlHttpObject()

            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }
            xmlHttp.open("GET","CancelLedger",true)
            //xmlHttp.onreadystatechange=progressbar
            xmlHttp.send(null)

        }

        function fetchValues(item)
        {
            //alert("hi");
            var setValue;
            if(item=="s")
            {

                setValue= document.getElementById("sector").value;
            }
            else if(item=="b")

            {

                setValue= document.getElementById("block").value;

            }

            else if(item=="con_t")
            {
                setValue= document.getElementById("con_tp").value;
            }
            else if(item=="con_n_f")
            {
                //alert("hi");
                setValue= document.getElementById("cons_no_fr").value;
            }


            else if(item=="con_n_t")
            {
                setValue= document.getElementById("cons_no_to").value;

            }
            else if(item=="bill_to")
            {

                setValue= document.getElementById("billdate1").value;
            }
            else if(item=="bill_to1")
            {

                setValue= document.getElementById("billdate1").value;
            }
            else if(item=="due")
            {

                setValue= document.getElementById("duedate1").value;
            }
            else
            {

            }

            xmlHttp=GetXmlHttpObject()

            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }

            var url="<%= request.getContextPath()%>/SetValues"
            url=url+"?&value="+setValue;
            url=url+"&sym="+item;
            //alert(url);
            //xmlHttp.onreadystatechange=setBlock
            xmlHttp.open("GET",url,true)
            xmlHttp.send(null)

        }
    </script>

    <body>
        <div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->

            <jsp:include page="../common/navbar.jsp"/>

            <div id="main-content"> <!-- Main Content Section with everything -->
                <div class="content-box column-left"><!-- Start Content Box -->

                    <div class="content-box-header">

                        <h3>For Consumer</h3>

                        <div class="clear"></div>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">

                        <div class="tab-content default-tab">


                            <noscript> <!-- Show a notification if the user has disabled javascript -->
                                <div class="notification error1 png_bg">
                                    <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>

						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                                    </div>
                                </div>

                            </noscript>

                            <form id="form5" method="GET" name="form5" action="<%=request.getContextPath()%>/LedgerForConsumer" onsubmit="return getLedgerList()">
                                <input type="hidden"  name="f1" value="f1"/>
                                <p>
                                    <label class="form-label">Consumer No</label>
                                    <%
                                                String consNo = "";
                                                if (session.getAttribute("cons_no") != null) {
                                                    consNo = session.getAttribute("cons_no").toString();

                                                } else {
                                                    consNo = "";

                                                }

                                                System.out.println("consNo------->" + session.getAttribute("cons_no"));
                                    %>
                                    <input type="hidden" id="flag" value="0"/>
                                    <input value="<%=consNo%>" type="text" name="cons_no" id="cons_no" class="required" minlength="8" maxlength="9"  onkeyup="clearUserID()" />
                                    <label id="lcons_no" class="error" style="visibility:hidden" >Enter existing consumer.</label>
                                </p>

                                <p> <label class="form-label">
                                        Bill Up To</label>
                                        <%
                                                    String billDateOption = "";
                                                    if (session.getAttribute("billdate") != null) {
                                                        billDateOption = session.getAttribute("billdate").toString();

                                                    } else {
                                                        billDateOption = "";

                                                    }

                                                    System.out.println("Bill Date------->" + session.getAttribute("billdate"));
                                        %>
                                    <input value="<%=billDateOption%>"type="text" name="billdate" id="billdate" class="required date"/>
                                </p>



                                <input type="submit" class="button" value="GET LEDGER"/>

                            </form>




                        </div>
                    </div>
                </div>

                <div class="content-box column-right ">

                    <div class="content-box-header"> <!-- Add the class "closed" to the Content box header to have it closed by default -->

                        <h3>For Sector</h3>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">

                        <div class="tab-content default-tab">
                            <noscript> <!-- Show a notification if the user has disabled javascript -->
                                <div class="notification error1 png_bg">
                                    <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>

						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                                    </div>
                                </div>

                            </noscript>
                            <form id="form6" method="GET" name="form6"  action="<%= request.getContextPath()%>/LedgerForSector" onsubmit=" getLedgerList()" >

                                <%
                                            String sectorOption;

                                            if (session.getAttribute("sector") != null) {
                                                sectorOption = session.getAttribute("sector").toString();

                                            } else {
                                                sectorOption = "select";

                                            }

                                %>
                                <p><label class="form-label">Sector</label>

                                    <select name="sector" id="sector"  onchange="populateBlocks()"  >
                                        <option value=""><%=sectorOption%></option>
                                        <c:forEach var="sector" items="${sectorList}">
                                            <option value="${sector}">${sector}</option>
                                        </c:forEach>
                                    </select>


                                    &nbsp; &nbsp; &nbsp; &nbsp;<label >Block</label>
                                    <%
                                                String blockOption;
                                                if (session.getAttribute("block") != null) {
                                                    blockOption = session.getAttribute("block").toString();

                                                } else {
                                                    blockOption = "select";

                                                }
                                                //System.out.println("sectorOption-->" + blockOption);

                                    %>

                                    <select name="block" id="block" size="1" onchange="fetchValues('b')"  >
                                        <option value="" selected><%=blockOption%>  </option>
                                    </select>

                                </p>

                                <p>
                                    <label class="form-label">Connection Type</label>
                                    <select name="con_tp" id="con_tp"  onchange="fetchValues('con_t')" >
                                        <%
                                                    String conOption;
                                                    if (session.getAttribute("con_tp") != null) {
                                                        conOption = session.getAttribute("con_tp").toString();
                                                        if (conOption.equals("R")) {
                                                            conOption = "Residential";
                                                        } else if (conOption.equals("I")) {
                                                            conOption = "Industrial";
                                                        } else if (conOption.equals("C")) {
                                                            conOption = "Commercial";
                                                        } else if (conOption.equals("T")) {
                                                            conOption = "Institutional";
                                                        } else {
                                                            conOption = "N.A.";
                                                        }
                                                    } else {
                                                        conOption = "N.A.";

                                                    }
                                                    //System.out.println("Connection Type on jsp-->" + conOption);

                                        %>
                                        <option value=""><%=conOption%></option>
                                        <option value="R">Residential</option>
                                        <option value="I">Industrial</option>
                                        <option value="C">Commercial</option>
                                        <option value="T">Institutional</option>
                                    </select>

                                </p>

                                <p>
                                    <label class="form-label">Cons No From</label>
                                    <%
                                                String confromOption = "";
                                                if (session.getAttribute("cons_no_fr") != null) {
                                                    confromOption = session.getAttribute("cons_no_fr").toString();

                                                } else {
                                                    confromOption = "";

                                                }
                                                // System.out.println("sectorOption-->" + confromOption);

                                    %>

                                    <input  value="<%=confromOption%>" type="text" name="cons_no_fr" id="cons_no_fr" minlength="8" maxlength="9" onblur="checkMstFr()" onkeyup="clearUserIDFr()"/>
                                    <label id="lcons_no_fr" class="error" style="visibility:hidden" >Enter existing consumer.</label>
                                </p>

                                <p>
                                    <label class="form-label">Cons No Upto</label>
                                    <%
                                                String conToOption = "";
                                                if (session.getAttribute("cons_no_to") != null) {
                                                    conToOption = session.getAttribute("cons_no_to").toString();

                                                } else {
                                                    conToOption = "";

                                                }
                                                //System.out.println("sectorOption-->" + conToOption);

                                    %>
                                    <input value="<%=conToOption%>" type="text" name="cons_no_to" id="cons_no_to" greater="#cons_no_fr" minlength="8" maxlength="9" onblur="checkMstTo()" onkeyup="clearUserIDTo()"/>
                                    <label id="lcons_no_to" class="error" style="visibility:hidden" >Enter existing consumer.</label>
                                </p>


                                <p> <label class="form-label">
                                        Bill Up To</label>
                                        <%
                                                    billDateOption = "";
                                                    if (session.getAttribute("billdate1") != null) {
                                                        billDateOption = session.getAttribute("billdate1").toString();

                                                    } else {
                                                        billDateOption = "";

                                                    }

                                                    //System.out.println("Bill Date------->" + session.getAttribute("billdate1"));
%>

                                    <input  value="<%=billDateOption%>" type="text" name="billdate1" id="billdate1" class="required date" onblur="fetchValues('bill_to1')"/>
                                </p>


                                <c:if test="${status1 gt 0}">

                                    <div  style="border: 1px solid black; width: 68%">
                                        <div id="progress" style="background-color:green; width:${status1}%">&nbsp;</div>
                                    </div><b>${status1}%</b>
                                </c:if>
                                <br/>

                                <%
                                            if (session.getAttribute("disable") != null) {

                                %>
                                <input id="button3"  type="submit" class="button1" value="GET LEDGERS" disabled="true"     />
                                <%} else {
                                %>

                                <input id="button3"  type="submit" class="button" value="GET LEDGERS"     />
                                <%}%>


                                <input type="button" class="button" onclick="cancel()" value="Cancel"/>
                            </form>
                        </div> <!-- End #tab3 -->
                    </div> <!-- End .content-box-content -->
                </div> <!-- End .content-box -->

                <div class="clear"></div>
                <jsp:include page="../common/footer.jsp"/>
            </div> <!-- End #main-content -->
        </div></body>
</html>
