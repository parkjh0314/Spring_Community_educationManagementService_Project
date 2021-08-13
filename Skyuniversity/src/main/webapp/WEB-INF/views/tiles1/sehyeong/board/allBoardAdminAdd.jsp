<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>
<style type="text/css">

	div.container {
		width: 80%;
		height: 1000px;
		border: solid 1px gray;
	}

	select#categoryNo {
		width: 20%;
	}

	input#subject {
		width: 76%;
	}


	ul {
		list-style: none;
	}
	
	ul > li:nth-child(4), li:nth-child(5) {
		margin-top: 20px;
	}
	
	span {
		color: red;
	}
	
	button {
		width: 80px;
		height: 30px;
		margin: 0 20px;
		border-radius: 5%;
		border: none;
		background-color: #0841ad;
		color: white;
	}
	
	button:hover {
		font-weight: bold;
	}
	
	div#register-div {
		line-height: 1.5;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		
		$("input#subject").val("[공지]");
			
		var check = $("textarea#content").val();
		
		if (check != ""){
			$("input#subject").val("${noticevo.subject}");
		}
		
		
		$("select#fk_boardKindNo").find("option[value=${paraMap.boardKindNo}]").prop("selected", true);
		
		//전역변수
		var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
	        sSkinURI: "<%= ctxPath %>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : false,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : false,
	        }
	    });
	    
	    
	    
	    
	    //쓰기버튼
	    $("#allBoardAdminAdd").click(function(){
	    	
	        //id가 content인 textarea에 에디터에서 대입
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	        
           //스마트에디터 사용시 무의미하게 생기는 p태그 제거
	        var contentval = $("textarea#content").val();
	        // === 확인용 ===
	        // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
	        // "<p>&nbsp;</p>" 이라고 나온다.
	        
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
	        // 글내용 유효성 검사 
	        if(contentval == "" || contentval == "<p>&nbsp;</p>") {
	        	alert("글내용입력혀라~!!");
	        	return;
	        }
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
	        contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
	    /*    
	              대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
	        ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
	                     그리고 뒤의 gi는 다음을 의미합니다.
	
	        	g : 전체 모든 문자열을 변경 global
	        	i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
	    */    
	        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환 
	        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	        $("textarea#content").val(contentval);
	     // alert(contentval);
	     
	      
	      	// 글제목 유효성 검사
	         var subjectVal = $("input#subject").val().trim();
	         if(subjectVal == "") {
	            alert("글제목을 입력부탁!!");
	            return;
	         }
     
	 	   var frm = document.allBoardAdminAddFrm;
	 	   frm.action = '<%= ctxPath%>/allBoardAdminAddEnd.sky';
	 	   frm.method = "POST";
	 	   frm.submit();
	    });
	   
	    
	    
	  	//수정버튼
	    $("#allBoardAdminEdit").click(function(){
	    	
	        //id가 content인 textarea에 에디터에서 대입
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	        
           //스마트에디터 사용시 무의미하게 생기는 p태그 제거
	        var contentval = $("textarea#content").val();
	        // === 확인용 ===
	        // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
	        // "<p>&nbsp;</p>" 이라고 나온다.
	        
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
	        // 글내용 유효성 검사 
	        if(contentval == "" || contentval == "<p>&nbsp;</p>") {
	        	alert("글내용입력혀라~!!");
	        	return;
	        }
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
	        contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
	    /*    
	              대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
	        ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
	                     그리고 뒤의 gi는 다음을 의미합니다.
	
	        	g : 전체 모든 문자열을 변경 global
	        	i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
	    */    
	        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환 
	        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	        $("textarea#content").val(contentval);
	     // alert(contentval);
	     
	      
	      	// 글제목 유효성 검사
	         var subjectVal = $("input#subject").val().trim();
	         if(subjectVal == "") {
	            alert("글제목을 입력부탁!!");
	            return;
	         }
     
	 	   var frm = document.allBoardAdminAddFrm;
	 	   frm.action = '<%= ctxPath%>/noticeEditEnd.sky';
	 	   frm.method = "POST";
	 	   frm.submit();
	    });
	   
   });// end of $(document).ready(function() {});-------------------------------------

   
  
  

</script>
    
<div class="container"  align="left" class="form-group" id="register-div">
	<form class="form-inline" name="allBoardAdminAddFrm" enctype="multipart/form-data">		
		<ul>
			<c:if test="${empty noticevo}">
				<li><h2>게시판 공지 작성</h2></li>
			</c:if>
			<c:if test="${not empty noticevo}">
				<li><h2>게시판 공지 수정</h2></li>
			</c:if>
			<li><h3>작성자&nbsp;:&nbsp;<img src="<%= ctxPath %>/resources/images/levelimg/${sessionScope.loginuser.levelvo.levelImg}" style="margin-bottom: 4px; width: 20px; height: 20px;" />&nbsp;${sessionScope.loginuser.nickname}</h3></li>
			<li>
			
				<select class="form-control" id="fk_boardKindNo" name="fk_boardKindNo">
					<c:forEach items="${boardList}" var="board" varStatus="status">
						<option value="${board.boardKindNo}">${board.boardName}</option>
					</c:forEach>
				</select>
				
				
				
				<c:if test="${empty noticevo}">
					<input class="form-control" type="text" id="subject" name="subject" placeholder="제목" autocomplete="off" maxlength="40" />
				</c:if>
				<c:if test="${not empty noticevo}">
					<input class="form-control" type="text" id="subject" name="subject" placeholder="제목" autocomplete="off" maxlength="40" />
				</c:if>
				
				
			</li>
			
			<li>
			
				<c:if test="${empty noticevo}">
					<textarea class="form-control" id="content" name="content" rows="30" style="width: 96%; resize: none;" placeholder="내용을 입력해주세요" ></textarea>
				</c:if>
				<c:if test="${not empty noticevo}">
					<textarea class="form-control" id="content" name="content" rows="30" style="width: 96%; resize: none;" placeholder="내용을 입력해주세요" >${noticevo.content }</textarea>
				</c:if>
			</li>
			<li>
				<input type="hidden" name="writerIp" id="writerIp" value="${paraMap.writerIp}" />
			</li>
		</ul>
		<br>
		<div align="center">
				<c:if test="${empty noticevo}">
					<button type="button" id="allBoardAdminAdd" >등록</button>
				</c:if>
				<c:if test="${not empty noticevo}">
					<button type="button" id="allBoardAdminEdit" >수정</button>
				</c:if>
			<button type="button" onclick="javascript:location.href='<%= ctxPath%>/marketboardList.sky?boardKindNo=${paraMap.boardKindNo}'">취소</button>
		</div>
		
		<c:if test="${not empty noticevo}">
			<input type="hidden" name="noticeNo" value="${noticevo.noticeNo}" />
			<input type="hidden" name="gobackURL2" value="${paraMap.gobackURL2}" />
			
		</c:if>
	</form>
	
</div>    
