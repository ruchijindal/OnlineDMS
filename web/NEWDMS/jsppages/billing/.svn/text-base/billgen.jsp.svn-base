<%--
    Document   : home
    Created on : 24 Feb, 2010, 2:59:31 PM
    Author     : smp
--%>
<% if (session.getAttribute("flag").equals("0")) {
                response.setHeader("refresh", "1");
            } else {
                response.setHeader("refresh", "2000");
                if (session.getAttribute("flag").equals("2")) {
                    //request.getRequestDispatcher("/GeneratePdf?division=1").forward(request, response);
                    String div = (String) session.getAttribute("division");
                    response.sendRedirect("/NEWDMS/GeneratePdf?division=" + div + "&flag2=0");
                    session.setAttribute("flag", "1");
                    session.setAttribute("status", "0");
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
    <title>Bill Generation Form</title>
    <jsp:include page="../common/header.jsp"/>
    <script  type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.validate_1.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.maskedinput-1.2.2.js"></script>

    <script  type="text/javascript">
        $(document).ready(function(){
            $("#duedate").mask("99/99/99");
            $("#billdate").mask("99/99/99");
            $("#bill_to").mask("99/99/99");
            $("#duedate1").mask("99/99/99");
            $("#billdate1").mask("99/99/99");
            $("#bill_fr1").mask("99/99/99");
            $("#form4").validate();
            $("#form3").validate();
        });

        window.onload = function()
        {
            document.getElementById("cons_no").focus();
        }


        function getBill()
        {
            // progressbar();
            var cons_no= document.getElementById("cons_no").value;
            var bill_to= document.getElementById("bill_to").value;
            xmlHttp=GetXmlHttpObject()

            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }
            var url="<%=request.getContextPath()%>/CalculateBillForConsumer?cons_no="+cons_no+"&bill_to="+bill_to
           
           
            xmlHttp.open("GET",url,true)
            //xmlHttp.onreadystatechange=progressbar
            xmlHttp.send(null)
            
        }
        function cancel()
        {
            xmlHttp=GetXmlHttpObject()

            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }
            xmlHttp.open("GET","CancelBill",true)
            //xmlHttp.onreadystatechange=progressbar
            xmlHttp.send(null)

        }
        function getBillList()
        {
            var billdate1=document.getElementById("billdate1").value;
            var billdate=new Date(parseInt("20"+billdate1.substring(6,8),10),parseInt(billdate1.substring(3,5),10)-1,parseInt(billdate1.substring(0,2)),10);
            var date=new Date();
            date.setMonth(4-1,1);
            var duedate1=document.getElementById("duedate1").value;
            var d2=new Date();
            var d1=new Date(parseInt("20"+duedate1.substring(6,8),10),parseInt(duedate1.substring(3,5),10)-1,parseInt(duedate1.substring(0,2)),10);
            if(!(d1.getTime()<=d2.getTime())&&!(billdate.getTime()<=date.getTime())){                

                xmlHttp=GetXmlHttpObject()

                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request")
                    return
                }
          
                xmlHttp.open("GET","a",true)
                xmlHttp.onreadystatechange=progressbar
                xmlHttp.send(null)
            }
            else
            {               
                return false;
            }
              
        }
        function progressbar()
        {
            
            if(xmlHttp.readyState == 1 || xmlHttp.readyState == 2 || xmlHttp.readyState == 3 || xmlHttp.readyState == 4)
            {

                window.location.href="a"
            }
          
        }
        

        //******************************************************//

        /*****************For single consumer****************************/

        function clearUserID()
        {
            
            var consumer=  document.getElementById("cons_no").value;

            if(consumer.length <8)
            {
                document.getElementById("lcons_no").style.visibility="hidden";
            }else {
                cons_no= document.getElementById("cons_no").value;

                if(document.getElementById("cons_no").value!="")
                {

                    fetchValues(cons_no);
                    xmlHttp=GetXmlHttpObject();
                    if (xmlHttp==null)
                    {
                        alert ("Browser does not support HTTP Request")
                        return
                    }
                    var url="<%=request.getContextPath()%>/CheckConsumer";
                    url=url+"?&cons_no="+cons_no;

                    xmlHttp.onreadystatechange=stateChanged;
                    xmlHttp.open("GET",url,true);
                    xmlHttp.send(null);


                }
                else if(document.getElementById("cons_no").value=="")
                {
                    document.getElementById("lcons_no").style.visibility="hidden";
                }
            }
        }

        function checkMst()
        {
           
            cons_no= document.getElementById("cons_no").value;

            if(document.getElementById("cons_no").value!="")
            {

                fetchValues(cons_no);
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request")
                    return
                }
                var url="<%=request.getContextPath()%>/CheckConsumer";
                url=url+"?&cons_no="+cons_no;
          
                xmlHttp.onreadystatechange=stateChanged;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
                

            }
            else if(document.getElementById("cons_no").value=="")
            {
                document.getElementById("lcons_no").style.visibility="hidden";
            }
        }

        function stateChanged( )
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
                if(data[1]==1)
                {
                    document.getElementById("arrear").removeAttribute("disabled");
                    document.getElementById("arrearupto").removeAttribute("disabled");                    
                    $("#arrearupto").mask("99/99/99");
                }else if(data[1]==0)
                {
                    document.getElementById("arrear").disabled=true;
                    document.getElementById("arrearupto").disabled=true;
                    
              
                }

            }
        }
        /********************************************************************************/
        /*****************For consumer from****************************/

        function clearUserIDFr()
        {
            if(document.getElementById("cons_no_fr").value=="")
            {
                document.getElementById("lcons_no_fr").style.visibility="hidden";
            }
        }

        function checkMstFr()
        {
            cons_no_fr= document.getElementById("cons_no_fr").value
           

            if(document.getElementById("cons_no_fr").value!="")
            {
                fetchValues("con_n_f");
                xmlHttp=GetXmlHttpObject()
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request")
                    return
                }
                var url="<%=request.getContextPath()%>/CheckConsumer";
                url=url+"?&cons_no="+cons_no_fr;
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
            cons_no_to= document.getElementById("cons_no_to").value
            

            if(document.getElementById("cons_no_to").value!="")
            {
                fetchValues("con_n_t");
                xmlHttp=GetXmlHttpObject()
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request")
                    return
                }
                var url="<%=request.getContextPath()%>/CheckConsumer";
                url=url+"?&cons_no="+cons_no_to;
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
        function checkduedate(date,buttonID)
        {
            var d=document.getElementById(date).value ;
            var d2=new Date();
            var d1=new Date(parseInt("20"+d.substring(6,8),10),parseInt(d.substring(3,5),10)-1,parseInt(d.substring(0,2)),10);;
        
       
            if(d1.getTime()<=d2.getTime())
            {
                if(date=="duedate")
                {
                    // document.getElementById(buttonID).disabled = true;
                    document.getElementById("cduedate1").removeAttribute("style");
                }
                if(date=="duedate1")
                {
                    //document.getElementById(buttonID).disabled = true;
                    document.getElementById("cduedate").removeAttribute("style");
                }
                 
            }else{
                if(date=="duedate")
                {
                    //document.getElementById(buttonID).disabled = false;
                    document.getElementById("cduedate1").style.visibility="hidden";
                }
                if(date=="duedate1")
                {
                    //document.getElementById(buttonID).disabled = false;
                    document.getElementById("cduedate").style.visibility="hidden";
                }
            }
        }
        function checkbillto(bdate,buttonID)
        {
            var d=document.getElementById(bdate).value ;
                       
            var d1=new Date(parseInt("20"+d.substring(6,8),10),parseInt(d.substring(3,5),10)-1,parseInt(d.substring(0,2)),10);
            //  document.write(d1);

            var d2=new Date();
            d2.setMonth(4-1,1);
            //document.write(d2);
            if(d1.getTime()<=d2.getTime())
            {
                 
                if(bdate=="bill_to")
                {
                    //document.getElementById(buttonID).disabled = true;
                    document.getElementById("ctodate1").removeAttribute("style");
                }
                if(bdate=="billdate1")
                {
                    //document.getElementById(buttonID).disabled = true;
                    document.getElementById("ctodate").removeAttribute("style");
                }
            }else{
                if(bdate=="bill_to")
                {
                   
                    //document.getElementById(buttonID).disabled = false;
                    document.getElementById("ctodate1").style.visibility="hidden";
                }
                if(bdate=="billdate1")
                {
                    //document.getElementById(buttonID).disabled = false;
                    document.getElementById("ctodate").style.visibility="hidden";
                }
            }
        }
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
        function fetchValues(item)
        {

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

                setValue= document.getElementById("cons_no_fr").value;
            }


            else if(item=="con_n_t")
            {
                setValue= document.getElementById("cons_no_to").value;

            }
            else if(item=="bill_to")
            {
                //document.write("yahoo");
                setValue= document.getElementById("billdate1").value;
                checkbillto("billdate1",'button3');

            }
            else if(item=="due")
            {

                setValue= document.getElementById("duedate1").value;
                checkduedate("duedate1",'button3');
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
            
            //xmlHttp.onreadystatechange=setBlock
            xmlHttp.open("GET",url,true)
            xmlHttp.send(null)

        }
        function disable()
        {
           
            document.getElementById('button3').disabled="true";
        }

        function checkFieldForConsumer()
        {
            var flag=document.getElementById("flag").value;
            var bill_to= document.getElementById("bill_to").value;
            var billTo=new Date(parseInt("20"+bill_to.substring(6,8),10),parseInt(bill_to.substring(3,5),10)-1,parseInt(bill_to.substring(0,2)),10);
            var date=new Date();
            date.setMonth(4-1,1);

            var duedate= document.getElementById("duedate").value;
            var d2=new Date();
            var d1=new Date(parseInt("20"+duedate.substring(6,8),10),parseInt(duedate.substring(3,5),10)-1,parseInt(duedate.substring(0,2)),10);


            if(!(d1.getTime()<=d2.getTime())&&!(billTo.getTime()<=date.getTime())&&!(flag==1)){
               
                return true;
               
            }else
            {
              
                return false;
            }
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
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>

						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                                    </div>
                                </div>

                            </noscript>


                            <form id="form3" action="CalculateBillForConsumer" name="form3" onsubmit="return checkFieldForConsumer()" >

                                <p>
                                    <label class="form-label">Consumer No</label>
                                    <input type="hidden" id="flag" value="0"/>
                                    <input type="text" name="cons_no" id="cons_no" class="required" minlength="8" maxlength="9" onkeyup="clearUserID()" />
                                    <label id="lcons_no" class="error" style="visibility:hidden" >Enter existing consumer.</label>
                                </p>
                                <p>
                                    <label class="form-label">Arrear Before 1990</label>
                                    <input type="text" name="arrear" id="arrear" class="required" disabled />
                                </p>
                                <p id="upto">
                                    <label class="form-label">Arrear Up To</label>
                                    <input type="text" name="arrearupto" id="arrearupto"  class="required date" disabled/>
                                </p>

                                <p>
                                    <label class="form-label">Bill To</label>
                                    <input type="text" name="bill_to"  id="bill_to" onblur="checkbillto(id,'billId')" class="required date"  />
                                    <label id="ctodate1" class="error" style="visibility:hidden" >can't before financial year.</label>
                                </p>
                                <p>
                                    <label class="form-label">Due Date</label>
                                    <input type="text" name="duedate" id="duedate" onblur="checkduedate(id,'billId');" class="required date"/>
                                    <label id="cduedate1" class="error" style="visibility:hidden" >Can't before current date.</label>
                                </p>
                                <p>

                                    <input type="checkbox" name="transfer" id="transfer" />
                                    <label class="form-label">Name Transfer</label>

                                    <input type="checkbox" name="noc" id="noc" />
                                    <label class="form-label">NOC</label>
                                    <input type="checkbox" name="regular" id="regular" />
                                    <label class="form-label">Temprary-Regular</label>
                                    <input type="hidden" id="billFlag" name="billFlag" value="0"/>
                                </p>

                                <input type="submit"  id="billId" class="button" value="GET BILL"/>

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
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>

						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                                    </div>
                                </div>

                            </noscript>
                            <form id="form4" name="form4" action="CalculateBillForSector"  onsubmit="return getBillList()" >


                                <p><label class="form-label">Sector</label>
                                    <%
                                                String sectorOption;

                                                if (session.getAttribute("sector") != null) {
                                                    sectorOption = session.getAttribute("sector").toString();

                                                } else {
                                                    sectorOption = "select";

                                                }
                                                // System.out.println("sectorOption-->" + sectorOption  );
                                    %>
                                    <select name="sector" id="sector"  onchange="populateBlocks()"       >

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
                                                //System.out.println("Block Option++++++++++++++++++++-->" + session.getAttribute("block"));

                                    %>
                                    <%System.out.println("now block" + session.getAttribute("block"));%>
                                    <select name="block" id="block" size="1" onchange="fetchValues('b')" >
                                        <option value="" selected><%=blockOption%></option>
                                    </select>
                                </p>
                                <p> <label class="form-label">Connection Type</label>
                                    <select name="con_tp" id="con_tp" onchange="fetchValues('con_t')" >
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

                                    <input value="<%=confromOption%>" type="text" name="cons_no_fr" id="cons_no_fr" minlength="8" maxlength="9" onblur="checkMstFr()" onkeyup="clearUserIDFr()"/>
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
                                    <label  id="lcons_no_to" class="error" style="visibility:hidden" >Enter existing consumer.</label>
                                </p>


                                <p>
                                    <label class="form-label">Bill To</label>
                                    <%
                                                String billDateOption = "";
                                                if (session.getAttribute("billdate") != null) {
                                                    billDateOption = session.getAttribute("billdate").toString();

                                                } else {
                                                    billDateOption = "";

                                                }

                                                //System.out.println("Bill Date++ ------->" + session.getAttribute("billdate"));
                                    %>
                                    <input value="<%=billDateOption%>" type="text" name="billdate" id="billdate1" class="required date" onblur="fetchValues('bill_to')" />
                                    <label id="ctodate" class="error" style="visibility:hidden" >can't before financial year.</label>
                                </p>
                                <p>
                                    <label class="form-label">Due Date</label>
                                    <%
                                                String dueDateOption = "";
                                                if (session.getAttribute("duedate1") != null) {
                                                    dueDateOption = session.getAttribute("duedate1").toString();

                                                } else {
                                                    dueDateOption = "";

                                                }

                                                //System.out.println("Due Date ++------->" + session.getAttribute("duedate1"));
                                    %>
                                    <input value="<%=dueDateOption%>" type="text" name="duedate1" id="duedate1" class="required date" onblur="fetchValues('due')"/>
                                    <label id="cduedate" class="error" style="visibility:hidden" >Can't before current date.</label>
                                </p>
                                <c:if test="${status gt 0}">
                                    <div  style="border: 1px solid black; width: 68% " >
                                        <div id="progress" style="background-color:green; width:${status}%">&nbsp;</div>
                                    </div><b>${status}%</b>
                                </c:if>
                                <br/>
                                <%
                                            if (session.getAttribute("disable") != null) {

                                %>
                                <input id="button3"  type="submit" class="button1" value="GET BILLS" disabled="true"     />
                                <%} else {
                                %>

                                <input id="button3"  type="submit" class="button" value="GET BILLS"     />
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




