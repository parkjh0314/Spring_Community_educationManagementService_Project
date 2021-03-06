<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String ctxPath = request.getContextPath();
%>

<style>



/************************************/
	 tbody > tr > td {
	 	text-align : left;
	 }

	table {
	 border: solid gray 1px;
	 margin-bottom : 5%;
	 }
	 
	 
	 
	 form#form-group {
	 	width : 100%;
	 }
	
	textarea#main {
		width : 100%;
		height : 250px;
	}
	
	textarea#reply {
		width: 90%;
      margin-top: 20px;
      border: solid 1px gray;

	}
	
	div#marketBoardMain{
		float : left;
      width: 60%;
      min-height: 550px;
     
       margin-bottom : 5%;
       margin-left : 15%;

	}
	
	div#replyContent {
		  float : left;
      width: 60%;
      /* height: 700px; */
      max-height: 1000px;
      border: solid gray 1px;
       margin-bottom : 5%;
       margin-left : 15%;

	}
	
	#replyContentTable {
		margin-top : 5%;
		margin-bottom : 1%;
		width: 80%;
	}
	
	div#sideBar {
		float : right;
		width: 15%;
		margin-right : 7%;
		margin-bottom : 1%;
		
	}
	
	
	p3 {
		width : 100%;
	}
	
	div#buttons1 {
		width : 50%;
	}
	
	div#editAndDel-div {
		float : right;
	}
	
	

	div#replyButtons {
		float : right;
	}
	
	button {
    	width: 60px;
        height: auto;
        margin: 0 5px;
        border-radius: 5%;
        border: none;
        background-color: #0841ad;
        color: white;
        padding: 4px;
    }
   
    button:hover {
    	font-weight: bold;
    }
   
   	button#letsgoback {
		float : right;
		width: 80px;
	}
	
	table.form-group {
		width : 100%;
	}
	
	#fileAttach {
		float : left;
	}	
	
	
	   img.photo {
      width: 18px;
      height: 18px;
   }
   
   h4.more:hover {
      font-weight: bolder;
      cursor: pointer;
   }
   
   span.button {
      margin: 0 10px;
   }
   
   span.button:hover {
      font-weight: bolder;
      cursor: pointer;
   }
   
   span.name {
      color: #9900e6;
      font-weight: bold;
   }
   
   span.name:hover {
      cursor: pointer;
      color: #7700b3;
   }
   
   button.myComment {
      float:right; 
      color : red;
      font-style: italic; 
      margin: 0 10px;
      background-color: #f2f2f2;
      border: none;
   }

   button:focus {
      outline: none;
   }   
			
		
	
   
   div#reply > div:first-child {
      text-align: left;
   }
   
   div#reply > div:first-child > span {
      margin: 10px 10px; 
   }

   div#reply > div:first-child > span:first-child {
      font-size: 20pt;
   }
   
   
   div#reply > div:first-child > span:last-child {
      font-size: 10pt;
         color: #9900e6;   
      font-weight: bold;
      border-radius: 20px;
      padding: 5px 5px;
   }
   
   div#reply > div:last-child {
      text-align: right;
   }
   
   textarea#cmtContent {
      height: 130px;
      resize: none;
   }
   
   button#btnComment {
      margin: 10px 35px;
   }
  
   
    div.content2 {
      float : left;
      width: 60%;
      /* height: 700px; */
      /* max-height: 1000px; */
      border: solid gray 1px;
       margin-bottom : 5%;
       margin-left : 15%;
       padding-bottom: 40px;
   }
   
   table#contentTable {
      margin-top : 5%;
      margin-bottom : 1%;
      width: 100%;
   }
   
   #contentTable2 {
      margin-top : 5%;
      margin-bottom : 1%;
      width: 90%;
      text-align: left; 
      line-height: 25px; 
      word-break: break-all; 
      margin-bottom: 20px;
   }
   
   
   
 
   
   p3 {
      width : 100%;
   }
   
   div#buttons1 {
      width : 30%;
   }
   
   div#buttons1 > button {
      height: 45px;
   }
      
   div#buttons2 {
      float : right;
      margin-right: 30px;
      margin-bottom: 20px;
   }
   
   input#commentContent {
      width : 30%;
   }

   div#replyButtons {
      float : right;
   }
   
   button {
      width: 60px;
      height: 30px;
      margin: 0 5px;
      border-radius: 5%;
      border: none;
      background-color: #0841ad;
      color: white;
   }
   
   button:hover {
      font-weight: bold;
   }
   
      button#goback {
      float : right;
      width: 80px;
      margin-right: 20px;
      margin-bottom: 20px;
   }
   
   table.form-group {
      width : 100%;
   }
   
   #fileAttach {
      float : left;
   }   
   
   div#content {
      margin-top: 20px;
      width: 95%;
      min-height: 300px;
   }
         
   div.contents {
      text-align: left;
      padding-left: 40px;
      margin-bottom: 20px;
   }


table {
   border-collapse: collapse;
   border-spacing: 0;
   width: 80%;
  /*  border: 1px solid #ddd; */
}

th, td {
   text-align: center;
   padding: 8px;
   border: 1px solid #ddd;
}

thead {
	background-color: #0841ad;
	font-size: 10pt;
	color: white;
}

tbody {
	font-size: 10pt;
}


img {
	width: 100%;
}

</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		
	      $("span#alert").hide();      
	      
	      $("input#startNo").val("1");
	      $("h4.more").show();      
	      goViewComment();
		
	      
	      // "?????????..." ?????? ?????????
	      $("h4.more").click(function() {
	         goViewComment($("input#startNo").val());
	      });// end of $("h4.more").click(function() {});-----------------
	      
	      
	      // ?????? ???????????? ???????????? ??????????????? ??????.
	      $("textarea#cmtContent").keyup(function() {
	         var characters = $(this).val().length;
	         $("span#characters").text(characters);
	         if (characters >= 200) {
	            $("span#alert").show();
	         }else{
	            $("span#alert").hide();
	         }
	      });
	      
	      
		getCountComeOn();
		
		// ?????? ????????? ????????? ajax??? ???????????? 1?????? ?????????.
	      $("button#verygooda").click(function() {
	         
	         var boardKindNo = "${boardvo.fk_boardKindNo}";
	         var boardNo = "${boardvo.boardNo}";
	         var loginMemberNo = "${sessionScope.loginuser.commuMemberNo}";
	         var writeMemberNo = "${boardvo.fk_commuMemberNo}";
	         
	         if (loginMemberNo != writeMemberNo) {
	        	 
	        	 
		         $.ajax({
		            url: "<%= request.getContextPath()%>/addMaketBoardUp.sky",
		            type: "POST",
		            data: {"boardKindNo": boardKindNo, "boardNo": boardNo},
		            dataType:"JSON",
		            success: function(json){
		               
		               if (json.n == 0) {
		                  alert("?????? ?????????????????????.");
		               }else{
		                  alert("?????????????????????.");
		                  getCountComeOn();
		               }
		            },
		            error: function(request, status, error){
		                     alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		              }
		         });
	         } else {
	        	 alert("?????? ?????? ????????? ????????????????????????")
	         }
	      });// end of $("button#btnUp").click(function() {});-----------------------------------
	         
	         
	      // ????????? ????????? ????????? ajax??? ??????????????? 1?????? ?????????.
	      $("button#verybadda").click(function() {
	         
	    	  var boardKindNo = "${boardvo.fk_boardKindNo}";
		      var boardNo = "${boardvo.boardNo}";
        	 
	         $.ajax({
	            url: "<%= request.getContextPath()%>/addMaketBoardDown.sky",
	            type: "POST",
	            data: {"boardKindNo":boardKindNo, "boardNo": boardNo},
	            dataType:"JSON",
	            success: function(json){
	               
	               if (json.n == 0) {
	                  alert("?????? ????????????????????????.");
	               }else{
	                  alert("????????????????????????.");
	                  getCountComeOn();
	               }
	            },
	            error: function(request, status, error){
	                     alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	              }
	         });
		     
		     
	      });// end of $("button#btnDown").click(function() {});-----------------------------------
	      
	      
	      // ?????? ????????? ????????? ajax??? ???????????? 1?????? ?????????.
	      $("button#gotopolice").click(function() {
	    	 var boardKindNo = "${boardvo.fk_boardKindNo}";
		     var boardNo = "${boardvo.boardNo}";
	         
		    
	         $.ajax({
	            url: "<%= request.getContextPath()%>/addMarketBoardReport.sky",
	            type: "POST",
	            data: {"boardKindNo":boardKindNo, "boardNo": boardNo},
	            dataType:"JSON",
	            success: function(json){
	               if (json.n == 0) {
	                  alert("?????? ?????????????????????.");
	               }else{
	                  
	                  if (json.n >= 10 ) {
		                  alert("too much ??????!");
	                	  tooMuchReportSoYouHaveToGoToThePoliceStation ();
	                  } else {
	                	  
		                  alert("?????????????????????.");
	                  }
	               }
	            },
	            error: function(request, status, error){
	                     alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	              }
	         });
	         
	         
	      });// end of $("button").click(function() {});------------------------------------------

	});
	
	function marketBoardEdit (){
		var frm = document.editAndDeleteFrm;
		frm.action = "<%= ctxPath%>/marketBoardEdit.sky";
		frm.method = "POST";
		frm.submit();
	}
	
	
	
	function marketBoardDelete () {
		var frm = document.editAndDeleteFrm;
		frm.action = "<%= ctxPath%>/marketBoardDelete.sky";
		frm.method = "POST";
		frm.submit();
	}
	
	
	
	
	
	function fileDownloadGoGo () {
		var frm = document.editAndDeleteFrm;
		frm.action = "<%= ctxPath%>/fileDownloadGoGo.sky";
		frm.method = "POST";
		frm.submit();
	}
	
	
	
	function getCountComeOn() {
		var boardKindNo = "${boardvo.fk_boardKindNo}";
        var boardNo = "${boardvo.boardNo}";
        
       
        
        $.ajax({
            url: "<%= request.getContextPath()%>/getMarketBoardCount.sky",
            type: "POST",
            data: {"boardKindNo":boardKindNo, "boardNo": boardNo},
            dataType:"JSON",
            success: function(json){
            	
            	var upCount = json.upCount;
                var downCount = json.downCount;
                
            	if (upCount == null || upCount == "") {
                    upCount = "0";
                 }
            	if (downCount == null || downCount == "") {
                    downCount = "0";
                 }
            	
            
            	
            	$("span#verygooda-span").text(upCount);
                $("span#verybadda-span").text(downCount);
            },
            error: function(request, status, error){
                     alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
              }
         });
	}

	
	function tooMuchReportSoYouHaveToGoToThePoliceStation () {
		var frm = document.editAndDeleteFrm;
		frm.action = "<%= ctxPath%>/marketTooMuchReport.sky";
		frm.method = "POST";
		frm.submit();
	}
	
	

	   ////////////////////////////////////////////////////////////////////////////////////////
	   var cmtLength = 8; // "?????????..." ????????? ???????????? ????????? ????????? ???
	   
	   // ?????? ???????????? ???????????? 
	   function goViewComment() {
	      
	        var startNo = $("input#startNo").val();
			var fk_boardKindNo = '${boardvo.fk_boardKindNo}';
			var fk_boardNo = "${boardvo.boardNo}" ;
			var noticeNo = "";
			
			if ("" != "${noticevo.noticeNo}") {
				noticeNo = "${noticevo.noticeNo}";
				
				alert(noticeNo);
				return;
			}
			
	      $.ajax({
	         url: "<%= ctxPath%>/commentList.sky",
	         data: {"startNo": startNo, "cmtLength": cmtLength, "fk_boardKindNo": "${boardvo.fk_boardKindNo}", "fk_boardNo": "${boardvo.boardNo}" },
	         type: "POST",
	         dataType: "JSON",
	         success: function(json){
	            
	            var html = "";
	            
	            if (startNo == "1" && json.length == 0) { // ???????????? ?????? ???????????? ???????????? ?????? ??????
	            	html += "<div style='color:#0841ad; font-size: 30px; text-align: center; margin-top: 25px;'>????????? ????????? ??????????????????.</div><br>";
	               $("table#contentTable2").html(html);
	               $("h4.more").hide();
	            }
	            
	            var totalCount;
	            if (json.length > 0) {
	               
	               $.each(json, function(index,item) {
	                  
	                  html += "<tr style='height:30px;'>" +
	                           "<td style='text-align:left;'><img src=/skyuniversity/resources/images/levelimg/"+item.levelImg+" class='photo' /><span class='name' onclick='addTag()'>"+item.fk_nickname+"</span> | "+item.regDate+"<div id='replyButtons'>"+
	                              "<span class='button' onclick='commentUp("+item.commentNo+")'>??????<span id='cmtUpCount"+item.commentNo+"'>"+item.cmtUpCount+"</span></span>&nbsp;&nbsp;"+
	                              "<span class='button' onclick='commentDown("+item.commentNo+")'>?????????<span id='cmtDownCount"+item.commentNo+"'>"+item.cmtDownCount+"</span></span>&nbsp;&nbsp;"+
	                              "<span class='button' style='height:30px; width: 70px; ' onclick='commentReport("+item.commentNo+")'>??????&nbsp;<img src='/skyuniversity/resources/images/report3.png' style='width: 15px; height: 15px;'/></span></div>"+
	                           "</td>"+
	                        "</tr>" + 
	                        "<tr style='height:30px; border-bottom-color: black;'>"+
	                           "<td style='text-align:left;'>";
	                  
	                  var comment = item.cmtContent;
	                  comment = comment.replaceAll("\n", "<br>");

	                  // ?????? ????????? ##????????? ????????? ##+?????? ?????? ?????? ???????????? ???????????? ????????? ???. 
	                  var arrFirst = []; // "##"??? ????????? index?????? ?????? ??????
	                  var arrLast = []; // "##"????????? ??????(" ")??? ????????? index?????? ?????? ??????
	                  
	                  var first = comment.indexOf("##");
	                  var last = 0;
	                  
	                  while (first != -1) { // "##"???????????? index??? ????????? ????????????  
	                     
	                     last = comment.indexOf(" ", first);   // ??? ?????? ??????(" ") index??? ????????????.
	                     
	                     if (last == -1) { // ?????? ??????(" ") index??? ???????????? ???????????? comment??? ????????? index(comment??? ??????)??? ?????????.
	                        last = comment.length;
	                     }

	                     arrFirst.push(first); // ????????? "##"????????? index??? ?????????.
	                     arrLast.push(last); // ????????? ??????(" ") ????????? index??? ?????????.
	                     
	                     first = comment.indexOf("##", last); // ??????(" ")????????? ?????? index?????? "##" ????????? ??? ????????? ???????????? index??? ????????????.
	                  }

	                  var firstString = ""; // "##" ????????????????????? ?????????.
	                  var secondString = ""; // "##" ??????????????? ??????(" ") ?????????????????? ?????????.
	                  var lastString = ""; // ??????(" ")????????? ?????????.

	                  var arrFirstString = []; // "##" ????????????????????? ???????????? ?????? ??????. 
	                  var arrSecondString = []; // "##" ??????????????? ??????(" ") ?????????????????? ???????????? ?????? ??????.(span????????? ?????? ????????????) 
	                  var arrLastString = []; // ??????(" ")????????? ???????????? ?????? ??????.
	                  
	                  if (arrFirst.length != 0) { // "##"??? ???????????? ???????????????
	                     
	                     for (var i = 0; i < arrFirst.length; i++) { // arrFirst ????????? ???????????? ????????????.  
	                     
	                        if (i == 0 && arrFirst.length == 1) { // ????????? ??????????????? arrFirst ????????? ????????? 1?????? ????????? ??????????????? ???????????? ??????. 
	                           arrFirstString.push( comment.substring( 0, arrFirst[i] ) );
	                           arrSecondString.push( comment.substring( arrFirst[i], arrLast[i] ) );                        
	                           arrLastString.push( comment.substring(arrLast[i]) );
	                        }else if (i == 0 && arrFirst.length != 1) { // ????????? ??????????????? arrFirst ????????? ????????? 1??? ????????? ????????? ??????????????? lastString??? ?????????????????? ????????? "##"????????? index????????????.
	                           arrFirstString.push( comment.substring( 0, arrFirst[i] ) );
	                           arrSecondString.push( comment.substring( arrFirst[i], arrLast[i] ) );                        
	                           arrLastString.push( comment.substring( arrLast[i], arrFirst[i+1] ) );
	                        }else if (i != 0 && i != arrFirst.length){ // ????????? ????????? ???????????? ????????? ????????? ????????????
	                           arrFirstString.push( comment.substring( arrFirst[i], arrFirst[i] ) );
	                           arrSecondString.push( comment.substring( arrFirst[i], arrLast[i] ) );
	                           arrLastString.push( comment.substring( arrLast[i], arrFirst[i+1] ) );
	                        }else{
	                           arrFirstString.push( comment.substring( arrFirst[i], arrFirst[i] ) );
	                           arrSecondString.push( comment.substring( arrFirst[i], arrLast[i] ) );
	                           arrLastString.push( comment.substring(arrLast[i]) );
	                        }
	                     }

	                     comment = "";
	                     for (var i = 0; i < arrFirstString.length; i++) {
	                        comment += arrFirstString[i];
	                        comment += "<span style='color:blue;'>";
	                        comment += arrSecondString[i];
	                        comment += "</span>";
	                        comment += arrLastString[i];
	                     }
	                     
	                  }

	                  html += comment;
	                  
	                  if ("${sessionScope.loginuser.fk_memberNo}" == item.fk_memberNo) { // ???????????? ????????? ?????? ???????????? ???, ?????? ?????? ????????? ???????????? ??????.
	                     html += "<div><button class='myComment' onclick='goDeleteComment("+item.commentNo+")'>??????</button>";
	                     html += "<button class='myComment' value='"+item.cmtContent+"' onclick='goChangeComment("+item.commentNo+")'>??????</button></div>";
	                  } 
	                  
	                  html +=     "</td>" +
	                        "</tr>";
	                  
	                  totalCount = item.totalCount;      
	                  
	                  // <input type='hidden' name='cc' value='"+item.cmtContent+"' />
	                  
	               });
	               
	               // ????????? ?????? ???????????? ?????????.
	               $("table#contentTable2").append(html);
	               
	               // "?????????..." ????????? ?????? ??? ???????????? ???????????? input#cmtCount??? ????????????.
	               $("input#startNo").val( Number(startNo) + cmtLength);
	               
	               // ???????????? ????????? ????????? ????????? ????????????.
	               $("input#cmtCount").val( Number($("input#cmtCount").val()) + json.length );

	               // ?????? ?????? ????????? ???????????? ????????? ?????? ????????? ?????????
	               if ( Number($("input#cmtCount").val()) == Number(totalCount) ) {
	                  $("h4.more").hide();
	                  $("input#cmtCount").val("0");
	                  $("input#startNo").val("1");
	               }
	            }
	            
	         },
	         error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           }
	      });
	   }// end of function goViewComment(startNo) {}-----------------------------------
	   
	   
	   // ???????????? ?????? - ?????? ????????? ????????? ????????? ???????????? ????????? ???????????????.
	   function goAddWrite() {
	      
	      var cmtContent = $("textarea#cmtContent").val().trim();
	      
	      if (cmtContent == null || cmtContent == "") {
	         alert("????????? ????????? ?????????.");
	         return false;
	      }
	      
	      var frm = $("form[name=addWriteFrm]").serialize();
	      
	      $.ajax({
	         url: "<%= request.getContextPath()%>/commentRegister.sky",
	         data: frm,
	         type: "POST",
	         dataType:"JSON",
	         success: function(json){
	               
	            if (json.n == 0) {
	               alert("??????????????? ??????????????????.");
	            }else if (json.n == 1){

	               // ?????? ????????? ?????? ??????????????? ??????.
	               $("textarea#cmtContent").val("");
	               $("input#startNo").val("1");
	               $("input#cmtCount").val("0");
	               $("table#contentTable2").html("");
	               $("h4.more").show();
	               
	               // ?????? ???????????? ???????????? ?????? ??????. 
	               var characters = $("textarea#cmtContent").val().length;
	               $("span#characters").text(characters);
	               if (characters >= 200) {
	                  $("span#alert").show();
	               }else{
	                  $("span#alert").hide();
	               }
	               
	               goViewComment();
	            }else{
	               alert("??????????????? ???????????? ????????? ??? ????????????.");
	            }
	            
	         },
	         error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           }
	         
	      });
	   }// end of function goAddWrite() {}----------------------------------
	   
	   
	   // ????????? ????????? ????????? ???????????? 1 ???????????? ?????????
	   function commentUp(commentNo) {
	      
	      var fk_boardKindNo = $("input[name=fk_boardKindNo]").val(); 
	      var fk_boardNo = $("input[name=fk_boardNo]").val(); 
	      
	      $.ajax({
	         url: "<%= ctxPath%>/addCommentUp.sky",
	         type: "POST",
	         data: {"fk_boardKindNo":fk_boardKindNo, "fk_boardNo":fk_boardNo, "commentNo":commentNo},
	         dataType:"JSON",
	         success: function(json){
	            
	            if (json.n == 0) {
	               alert("?????? ?????????????????????.");
	            }else{
	               alert("?????????????????????.");
	               var cmtUpCount = json.cmtUpCount;
	               var cmtDownCount = json.cmtDownCount;

	               if (cmtDownCount == null || cmtDownCount == "") {
	                  cmtDownCount = "0";
	               }
	               $("span#cmtUpCount"+commentNo).text(cmtUpCount);
	               $("span#cmtDownCount"+commentNo).text(cmtDownCount);
	            }
	         },
	         error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           }
	      });

	   }// end of function commentUp() {}-------------------------------------------
	   
	   
	   // ????????? ???????????? ????????? ??????????????? 1 ???????????? ?????????
	   function commentDown(commentNo) {
	      
	      var fk_boardKindNo = $("input[name=fk_boardKindNo]").val(); 
	      var fk_boardNo = $("input[name=fk_boardNo]").val(); 

	      $.ajax({
	         url: "<%= ctxPath%>/addCommentDown.sky",
	         type: "POST",
	         data: {"fk_boardKindNo":fk_boardKindNo, "fk_boardNo":fk_boardNo, "commentNo":commentNo},
	         dataType:"JSON",
	         success: function(json){
	            
	            if (json.n == 0) {
	               alert("?????? ????????????????????????.");
	            }else{
	               alert("????????????????????????.");
	               var cmtUpCount = json.cmtUpCount;
	               var cmtDownCount = json.cmtDownCount;

	               if (cmtUpCount == null || cmtUpCount == "") {
	                  cmtUpCount = "0";
	               }
	               $("span#cmtUpCount"+commentNo).text(cmtUpCount);
	               $("span#cmtDownCount"+commentNo).text(cmtDownCount);
	            }
	         },
	         error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           }
	      });

	   }// end of function commentDown() {}-------------------------------------------

	   
	   // ????????? ????????? ????????? ???????????? 1 ???????????? ?????????
	   function commentReport(commentNo) {
	      
	      var fk_boardKindNo = $("input[name=fk_boardKindNo]").val(); 
	      var fk_boardNo = $("input[name=fk_boardNo]").val(); 

	      $.ajax({
	         url: "<%= ctxPath%>/addCommentReport.sky",
	         type: "POST",
	         data: {"fk_boardKindNo":fk_boardKindNo, "fk_boardNo":fk_boardNo, "commentNo":commentNo},
	         dataType:"JSON",
	         success: function(json){
	            
	            if (json.n == 0) {
	               alert("?????? ?????????????????????.");
	            }else{
	               alert("?????????????????????.");
	               
	               // ??????????????? ????????? ????????? ???.
	               $("input#startNo").val("1");
	               $("input#cmtCount").val("0");
	               $("table#contentTable2").html("");
	               $("h4.more").show();
	               
	               goViewComment();
	               
	            }
	         },
	         error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           }
	      });

	   }// end of function commentReport() {}-------------------------------------------
	   
	   
	   // ?????? ?????? ????????? ????????? ????????? ??????????????? ?????????. 
	   function goDeleteComment(commentNo) {
	      
	      var fk_boardKindNo = $("input[name=fk_boardKindNo]").val(); 
	      var fk_boardNo = $("input[name=fk_boardNo]").val(); 

	      $.ajax({
	         url: "<%= ctxPath%>/deleteComment.sky",
	         type: "POST",
	         data: {"fk_boardKindNo":fk_boardKindNo, "fk_boardNo":fk_boardNo, "commentNo":commentNo},
	         dataType:"JSON",
	         success: function(json){
	            
	            if (json.n == 0) {
	               alert("????????? ??????????????????.");
	            }else{
	               alert("????????? ?????????????????????.");
	               
	               // ??????????????? ????????? ????????? ???.
	               $("input#startNo").val("1");
	               $("input#cmtCount").val("0");
	               $("table#contentTable2").html("");
	               $("h4.more").show();
	               
	               goViewComment();
	            }
	         },
	         error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           }
	      });
	      
	      
	   }// end of function goDeleteComment() {}---------------------------------
	   
	   
	   // ?????? ?????? ????????? ????????? ????????? ????????? ??? ????????? ?????? ???????????? ?????????. 
	   function goChangeComment(commentNo) {
	      
	      var $target = $(event.target); // ???????????? ????????? ???????????? ????????? $target????????? ????????? ????????????.
	      
	      var comment = $target.val();
	      comment = comment.replaceAll("<br>","\n");
	      
	      var html = "<textarea class='form-control myContent' style='resize: none;' rows='3'>"+comment+"</textarea>"+
	               "<button class='myComment' value='"+$target.val()+"' onclick='goResetUpdate("+commentNo+")'>??????</button>"+
	               "<button class='myComment' onclick='goUpdateComment("+commentNo+")'>??????</button>";
	      
	      $($target).parent().parent().html(html); // ?????? ???????????? ?????????????????? td ???????????? ????????? ????????? ????????????.
	      
	   }// end of function goChangeComment() {}---------------------------------
	   
	   
	   // ?????? ?????? ????????? ??????????????? ????????? ?????? ???????????? ?????? ????????? ????????????(update) ?????????.
	   function goUpdateComment(commentNo) {
	      
	      var $target = $(event.target);
	      
	      var cmtContent = $target.siblings("textarea").val();
	      
	      var fk_boardKindNo = $("input[name=fk_boardKindNo]").val(); 
	      var fk_boardNo = $("input[name=fk_boardNo]").val(); 

	      $.ajax({
	         url: "<%= ctxPath%>/updateComment.sky",
	         type: "POST",
	         data: {"fk_boardKindNo":fk_boardKindNo, "fk_boardNo":fk_boardNo, "commentNo":commentNo, "cmtContent": cmtContent},
	         dataType:"JSON",
	         success: function(json){

	            if (json.n == 0) {
	               alert("????????? ??????????????????.");
	            }else{
	               alert("????????? ?????????????????????.");
	               
	               // ??????????????? ????????? ????????? ???.
	               $("input#startNo").val("1");
	               $("input#cmtCount").val("0");
	               $("table#contentTable2").html("");
	               $("h4.more").show();
	               
	               goViewComment();
	            } 
	         },
	         error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           }
	      });
	      
	   }// end of function goUpdateComment(commentNo) {}------------------------------------
	   
	   
	   // ?????? ????????? ????????? ????????? ??? 
	   function goResetUpdate(commentNo) {
	      
	      var $target = $(event.target); // ???????????? ????????? ???????????? ????????? $target????????? ????????? ????????????.
	      
	      var comment = $target.val();

	      var html = comment +
	              "<div><button class='myComment' onclick='goDeleteComment("+commentNo+")'>??????</button>" +
	              "<button class='myComment' value='"+comment+"' onclick='goChangeComment("+commentNo+")'>??????</button></div>";
	         
	      $($target).parent().html(html); // ?????? ???????????? ?????????????????? td ???????????? ????????? ????????? ????????????.
	      
	   }// end of function goResetUpdate(commentNo) {}----------------------------------------
	   
	   
	   // ??? ????????? ????????? ????????? ?????????, ?????? ???????????? ##???????????? ??????????????? ??????.
	   function addTag() {
	      
	      var $target = $(event.target);
	      var nickname = $($target).text();
	      var content = $("textarea#cmtContent").val();
	      content += "##"+nickname+" ";
	      $("textarea#cmtContent").val(content);
	      
	      var characters = content.length;
	      $("span#characters").text(characters);      
	      
	      if (characters >= 200) {
	         $("span#alert").show();
	      }else{
	         $("span#alert").hide();
	      }
	      
	   }// end of function addTag(nickname) {}----------------------------
	
	   
	   function goView2(fk_boardKindNo, boardNo){
		  
		   
	      var frm = document.goViewFrm2;
	      frm.boardNo.value = boardNo;
	      frm.boardKindNo.value = fk_boardKindNo;
	      frm.method = "POST";
	      
	      if (fk_boardKindNo <= 6 || (18 <= fk_boardKindNo && fk_boardKindNo <= 22)) {
	          frm.action = "<%=request.getContextPath()%>/minsungBoardView.sky";
	       } else if (23 <= fk_boardKindNo){
	          frm.action = "<%=request.getContextPath()%>/marketBoardDetail.sky";
	       } else if (fk_boardKindNo != 7){
	          frm.action = "<%=request.getContextPath()%>/boardDetail.sky";
	       } else{
	          frm.action = "<%=request.getContextPath()%>/boardDetail2.sky";
	       }

	      
	      frm.submit();
		      
		}
</script>



	<div id="marketBoardMain">
		<h1 align="left">${tableInfo.boardName}</h1>
		<div id="marketContent" style="min-height: 600px; text-align: left; border: solid gray 1px;">
			<div id="mainTitle" style="font-weight: bold; padding-left: 20px;">
				<h2><span>[${boardvo.categoryName}]&nbsp;&nbsp;</span>${boardvo.subject} </h2>
			</div>
			
			<div id="mainSubInfo" style=" padding-left: 20px; border-bottom: solid 1px gray;">
				<h5><span>????????? : <img src="<%= ctxPath %>/resources/images/levelimg/${boardvo.levelImg}" style="width: 17px; height: 17px;" />&nbsp;${boardvo.nickname}</span>???<span>????????? : ${boardvo.readCount}</span>???<span>???????????? : ${boardvo.regDate}</span>
				<c:if test="${boardvo.editDate != null}">
					???<span>???????????? : ${boardvo.editDate} </span>
				</c:if>
				&nbsp;&nbsp;&nbsp;<span style="font-size: 12pt; font-weight: bold; float: right; margin-right: 20px;"><fmt:formatNumber value="${boardvo.price}" pattern="#,###" />???</span>
				</h5>
			
			</div>
			
			<div id="content-div" style="overflow: auto; word-break: break-all;  padding: 30px; min-height: 500px;">
				${boardvo.content}
			
			</div>
			<div id="fileDownload" style=" font-weight: bold; padding-left: 20px;">
				<a href="javascript:fileDownloadGoGo();">${boardvo.orgFileName}</a>				
				
			</div>
		</div>
		<br>
		<br>
		<c:if test="${not empty paraMap.gobackURL2}">
			<button type="button" id="letsgoback" onclick="javascript:location.href='${paraMap.gobackURL2}'">????????????</button>
		</c:if>
		<c:if test="${empty paraMap.gobackURL2}">
			<button type="button" id="letsgoback" onclick="javascript:location.href='<%= ctxPath%>/marketboardList.sky?boardKindNo=${paraMap.boardKindNo}'">????????????</button>	
		</c:if>
			<div id="buttons1">
				<button type="button" id="verygooda">??????<br><span id="verygooda-span"></span></button>
				<button type="button" id="verybadda">??????<br><span id="verybadda-span"></span></button>
				<button type="button" id="gotopolice">??????<br><span id="gotopolice-span"><img src="<%= request.getContextPath()%>/resources/images/sehyeong/call.png" style="width: 20px; height: 20px;"/></span></button>
			</div>
		
		<br>
		<br>
		<div id="editAndDel-div">
			<c:if test="${boardvo.commuMemberNo eq sessionScope.loginuser.commuMemberNo}">
				<button type="button" onclick="marketBoardEdit();">??????</button>
				<button type="button" onclick="marketBoardDelete();">??????</button>
			</c:if>
		</div>
		
		<form name="editAndDeleteFrm">
			<input type="hidden" name="boardNo" value="${boardvo.boardNo}" />
			<input type="hidden" name="boardKindNo" value="${boardvo.fk_boardKindNo}" />
			<input type="hidden" name="gobackURL2" value="${paraMap.gobackURL2}" />
		</form>
		
	</div>


<div id="sideBar">
   <div>
      <B>?????? ?????????</B>
      <table>
         <c:forEach var="recentBoard" items="${recentBoardList}">
            <tr>
               <td colspan="2" style = "text-align:center; width:400px;"><B>${recentBoard.boardName}</B></td>
               <td colspan="2" ><a class="subject" style="cursor:pointer" 
               onclick="goView2('${recentBoard.fk_boardKindNo}', '${recentBoard.boardNo}')">
               ${recentBoard.subject}</a></td>
            </tr>
         </c:forEach>
      </table>
   </div>
   
    <div>
   
      <B>?????? ????????? ?????????</B>
      <table>
         <c:forEach var="bestBoard" items="${bestBoardList}">
            <tr>
               <td colspan="2" style = "text-align:center; width:400px;"><B>${bestBoard.boardName}</B></td>
               <td colspan="2"><a class="subject" style="cursor:pointer" 
               onclick="goView2('${bestBoard.fk_boardKindNo}', '${bestBoard.boardNo}')">
               ${bestBoard.subject} ${bestBoard.subject.length() }</a></td>
            </tr>
         </c:forEach>
      </table>
   </div>
<div>
   
      <B>?????? ?????????</B>
      <table>
         <c:forEach var="popularBoard" items="${popularBoardList}">
            <tr>
               <td colspan="2" style = "text-align:center; width:400px;"><B>${popularBoard.boardName}</B></td>
               <td colspan="2"><a class="subject" style="cursor:pointer" 
               onclick="goView2('${popularBoard.fk_boardKindNo}', '${popularBoard.boardNo}')">
               ${popularBoard.subject}</a></td>
            </tr>
         </c:forEach>
      </table>
   </div> 
</div>



   <div class="content2">
      
      <div id="reply" >
         <div><span>????????????</span><span><img  class="photo" src="<%= ctxPath%>/resources/images/levelimg/level${sessionScope.loginuser.fk_levelNo}.png"/>${sessionScope.loginuser.nickname}</span></div>
         <form name="addWriteFrm" style="margin-top: 5px; width: 90%; height: 125px;" class="form-group">
            <textarea id="cmtContent" name="cmtContent" class="form-control"></textarea>
            
            
            <input type="hidden" name="fk_boardKindNo" value="${boardvo.fk_boardKindNo}"/>
            <input type="hidden" name="fk_boardNo" value="${boardvo.boardNo}"/>
            
            
         </form>
         <div>
            <span id="alert" style="color:red; margin-right: 20px;">200?????? ????????? ????????? ????????? ??? ????????????.</span><span id="characters" style="">0</span><span> / 200</span>
            <button id="btnComment" type="button" onclick="goAddWrite()">??????</button>
         </div> 
      </div>
      <hr>
      
      <!-- ?????? ?????? -->
      <table id="contentTable2" class="form-group" ></table>
      <h4 class="more">?????????...</h4>
      <input type="hidden" id="startNo" value="1"/>
      <input type="hidden" id="cmtCount" value="0"/>
      
   </div>
	
	   <form name="goViewFrm2">
      <input type="hidden" id="boardNo" name="boardNo" value="" /> 
      <input type="hidden" id="boardKindNo" name="boardKindNo" value="" /> 
   </form>
	
