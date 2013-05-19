<%--
    Document   : home
    Created on : 24 Feb, 2010, 2:59:31 PM
    Author     : smp
--%>

<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page  language="java" import="javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" %>




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <title>Bill Generation Form</title>
    <jsp:include page="../common/header.jsp"/>
    <script  type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.validate_1.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.maskedinput-1.2.2.js"></script>
    <c:set var="chl" value="1"></c:set>
    <script  type="text/javascript">
        $(document).ready(function(){
            $("#duedate").mask("99/99/99");
            $("#billdate").mask("99/99/99");
            $("#bill_to").mask("99/99/99");
            $("#duedate1").mask("99/99/99");
            $("#billdate1").mask("99/99/99");
            $("#bill_fr1").mask("99/99/99");
            $("#dateFrom").mask("99/99/99");
            $("#dateTo").mask("99/99/99");
            $("#form4").validate();
            $("#form3").validate();
        });

        //        window.onload = function()
        //        {
        //            document.getElementById("cons_no").focus();
        //        }


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

        //        function checkMst1()
        //        {
        //
        //            cons_no= document.getElementById("cons_no").value;
        //            if(document.getElementById("cons_no").value!="")
        //            {
        //
        //                fetchValues(cons_no);
        //                xmlHttp=GetXmlHttpObject();
        //                if (xmlHttp==null)
        //                {
        //                    alert ("Browser does not support HTTP Request")
        //                    return
        //                }
        //                var url="<%=request.getContextPath()%>/CheckConsumer";
        //                url=url+"?&cons_no="+cons_no;
        //
        //                xmlHttp.onreadystatechange=stateChanged;
        //                xmlHttp.open("GET",url,true);
        //                xmlHttp.send(null);
        //
        //
        //            }
        //            else if(document.getElementById("cons_no").value=="")
        //            {
        //                document.getElementById("lcons_no").style.visibility="hidden";
        //            }
        //
        //        }

        function populateHousingRate(cons_no)
        {
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }
            var url="<%=request.getContextPath()%>/populateHousingRate?&cons_no=" +cons_no;

            xmlHttp.onreadystatechange=statechanged5;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        function insert_HousingRate()
        {
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }
           
            var consumerNo =document.getElementById("consumerNo").value;            
            var dateFrom =document.getElementById("dateFrom").value;           
            var dateTo =document.getElementById("dateTo").value;            
            var rate =document.getElementById("rate").value;           
            var url="<%=request.getContextPath()%>/insertHousingRate?&consumerNo=" +consumerNo+"&dateFrom=" +dateFrom+"&dateTo=" +dateTo+"&rate="+rate;
            
            document.getElementById("dateFrom").value=null;
            document.getElementById("dateTo").value=null;
            document.getElementById("rate").value=null;
            xmlHttp.onreadystatechange=statechanged5;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);

        }

        function edit_HousingRate()
        {
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }

            var consumerNo = document.getElementById("consumerNo").value;            
            var id = document.getElementById("ID1").value;            
            var date_From = document.getElementById("ID2").value;            
            var date_To = document.getElementById("ID3").value;            
            var rates = document.getElementById("ID4").value;           
            var url="<%=request.getContextPath()%>/editHousingRate?&consumer_No=" +consumerNo+"&id="+id+"&date_From=" +date_From+"&date_To=" +date_To+"&rates="+rates;
            xmlHttp.onreadystatechange=statechanged5;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        function makeEditableChl5(chl)
        {

            var txt_inp = document.getElementsByTagName('input');
            var i, j=1,k=1;

            for(i=0; i< txt_inp.length; i++)
            {

                if(txt_inp[i].type == "text" || txt_inp[i].type == "hidden" )
                {
                    var x = txt_inp[i];


                    // get or set id


                    if(x.name=="id"||x.name=="date_From"||x.name=="date_To"||x.name=="rates")

                    {

                        x.id = "Id"+j; // We are dynamically setting and ID
                        Id="Id"+j;
                        
                        if((j==((chl-1)*4)+k) && k<=4)
                        {
                            document.getElementById(Id).removeAttribute("readonly");
                            if(x.name=="date_From"||x.name=="date_To")
                            {                                
                                $("#"+Id).mask("99/99/99");
                            }
                            document.getElementById(Id).id="ID"+k;

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

        function confirmDelete(id)
        {
            var  message="Do you want to delete this record permanently?"
            var agree=confirm(message);
            if(agree)
            {
                delete_HousingRate(id);
            }
            else
                window.location("#").reload();
        }

        function delete_HousingRate(id)
        {
            xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return;
            }
            var consumerNo = document.getElementById("consumerNo").value;           
            var url= "<%=request.getContextPath()%>/deleteHousingRate?id="+id +"&consumer_No=" +consumerNo ;
            xmlHttp.onreadystatechange=statechanged5;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        

        function statechanged5()
        {


            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
            {
                window.location = "#";
                window.location.reload();
                
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
                    document.getElementById("consumerNo").value=data[2];
                    document.getElementById("flag").value="0";
                    populateHousingRate(cons_no);
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
        function checkduedate(date)
        {
            var d=document.getElementById(date).value ;
            var d2=new Date();
            var d1=new Date(parseInt("20"+d.substring(6,8),10),parseInt(d.substring(3,5),10)-1,parseInt(d.substring(0,2)),10);;


            if(d1.getTime()<=d2.getTime())
            {
                if(date=="duedate")
                {
                    document.getElementById("cduedate").removeAttribute("style");
                }
                if(date=="duedate1")
                {
                    document.getElementById("cduedate1").removeAttribute("style");
                }

            }else{
                if(date=="duedate")
                {
                    document.getElementById("cduedate").style.visibility="hidden";
                }
                if(date=="duedate1")
                {
                    document.getElementById("cduedate1").style.visibility="hidden";
                }
            }
        }
        function checkbillto(bdate)
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
                    document.getElementById("ctodate").removeAttribute("style");
                }
                if(bdate=="billdate1")
                {
                    document.getElementById("ctodate1").removeAttribute("style");
                }
            }else{
                if(bdate=="bill_to")
                {
                    document.getElementById("ctodate").style.visibility="hidden";
                }
                if(bdate=="billdate1")
                {
                    document.getElementById("ctodate1").style.visibility="hidden";
                }
            }

            getCal_Date();
        }

        function getCal_Date()
        {
            xmlHttp=GetXmlHttpObject()

            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }

            var cons_no=document.getElementById("cons_no").value;            
            var bill_to=document.getElementById("bill_to").value;
            
            var url="<%=request.getContextPath()%>/getCaldate?&cons_no=" +cons_no +"&bill_to="+bill_to;
            xmlHttp.onreadystatechange=statechanged5
            xmlHttp.open("GET",url,true)
            xmlHttp.send(null)
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

            //xmlHttp.onreadystatechange=setBlock
            xmlHttp.open("GET",url,true)
            xmlHttp.send(null)

        }
        function disable()
        {
            alert("hoi");
            document.getElementById('button3').disabled="true";
        }

        function checkField()
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

                        <h3>Group Housing Bill</h3>

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


                            <form id="form3" action="<%= request.getContextPath()%>/CalculateBillForConsumer" name="form3" onsubmit="return checkField()" >

                                <p>
                                    <label class="form-label">Consumer No</label>
                                    <input type="hidden" id="flag" value="0"/>
                                    <input type="text" name="cons_no" id="cons_no" class="required" minlength="8" maxlength="9"   onkeyup="clearUserID()" />
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
                                    <input type="text" name="bill_to"  id="bill_to" onblur="checkbillto(id)" class="required date"  />
                                    <label id="ctodate" class="error" style="visibility:hidden" >can't before financial year.</label>
                                </p>
                                <p>
                                    <label class="form-label">Due Date</label>
                                    <input type="text" name="duedate" id="duedate" onblur="checkduedate(id);" class="required date"/>
                                    <label id="cduedate" class="error" style="visibility:hidden" >Can't before current date.</label>
                                </p>
                                <p>

                                    <input type="checkbox" name="transfer" id="transfer" />
                                    <label class="form-label">Name Transfer</label>

                                    <input type="checkbox" name="noc" id="noc" />
                                    <label class="form-label">NOC</label>
                                    <input type="checkbox" name="regular" id="regular" />
                                    <label class="form-label">Temprary-Regular</label>
                                </p>
                                <c:set var="flagValue" value="<%=session.getAttribute("flagValue")%>"></c:set>
                                <c:choose>
                                    <c:when test="${flagValue eq 1}">
                                        <input type="submit"  class="button" value="GET BILL" disabled="true"/>
                                    </c:when>

                                    <c:otherwise>
                                        <input type="submit"  class="button" value="GET BILL"/>
                                    </c:otherwise>
                                </c:choose>
                            </form>

                        </div>
                    </div>
                </div>

                <div class="content-box column-right ">

                    <div class="content-box-header"> <!-- Add the class "closed" to the Content box header to have it closed by default -->

                        <h3>Rates</h3>

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
                            <c:set var="flagValue" value="<%=session.getAttribute("flagValue")%>"></c:set>
                            <c:if test="${flagValue eq 1}">
                                <% session.setAttribute("flagValue", 0);%>
                                <div class="notification error1 png_bg">
                                    <a href="#" class="close"><img src="NEWDMS/resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                    <div>
					 Rates Missing
                                    </div>
                                </div>
                            </c:if>

                            <table     cellspacing="0" cellpadding="0" style="color:#000">
                                <thead>
                                    <tr><th ></th>
                                        <th>Date From</th><th></th>
                                        <th>Date To</th><th></th>                                        
                                        <th>Rate</th>  <th></th>
                                        <th>Options</th>
                                    </tr>
                                </thead>
                                <table>
                                    <form id="form4" name="form4" method="Post" action="" >
                                        <tr>
                                            <td><input type="hidden" id="consumerNo" name="consumerNo" size="6px;"/></td>
                                            <td><input type="text" id="dateFrom" name="dateFrom" size="6px;"/> </td><td></td>
                                            <td><input type="text" id="dateTo" name="dateTo" size="6px;"/> </td>
                                            <td><input type="text" id="rate" name="rate" size="6px;"/> </td>
                                            <td><input  type="button" onclick="insert_HousingRate()" class="button" value="ADD"/></td>
                                        </tr>
                                    </form>
                                </table>


                                <c:forEach   var="housingRateList" items="${housingRateList}" >
                                    <table id="table1">

                                        <form id="form${chl}" method="post" action="">
                                            <tr>

                                                <td><input type="hidden" name="id" id="id" value="${housingRateList.id}" size="6px;" readonly/></td>                                                
                                                <td><fmt:formatDate value="${housingRateList.dateFrom}"  pattern="dd/MM/yy" var="date_from"/> <input type="text" id="date_From" name="date_From" value="${date_from}" size="6px;" readonly/> </td>
                                                <td><fmt:formatDate value="${housingRateList.dateTo}"  pattern="dd/MM/yy" var="date_to"/> <input type="text" id="date_To" name="date_To" value="${date_to}" size="6px;" readonly/> </td>
                                                <td><input type="text" name="rates" id="rates" value="${housingRateList.rate}" size="6px;" readonly/></td>
                                                <td id="edit${chl}"  style="display:inline-block">  <a href="#" onclick="makeEditableChl5(${chl})"><label class="button" >EDIT</label></a></td>
                                                <td id="save${chl}" style="display:none"><input  type="button"  class="savebutton" onclick="edit_HousingRate()"  value="" size="6px;"/></td>
                                                <td  id="del${chl}" style="display:none"><a href=""  onclick="confirmDelete(${housingRateList.id})"><label  class="delbutton" ></label></a></td>
                                            </tr>
                                            <c:set var="chl" value="${chl+1}"></c:set>
                                        </form>

                                    </table>
                                </c:forEach>
                            </table>
                        </div> <!-- End #tab3 -->

                    </div> <!-- End .content-box-content -->

                </div> <!-- End .content-box -->

                <div class="clear"></div>
                <jsp:include page="../common/footer.jsp"/>
            </div> <!-- End #main-content -->

        </div></body>

</html>




