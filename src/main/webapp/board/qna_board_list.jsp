<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>    
<%@ page import = "net.board.db.*" %>    

<%
	String id = null;
	if(session.getAttribute("id") != null){
		id = (String)session.getAttribute("id");
	}
	List boardList = (List)request.getAttribute("boardlist");
	int listcount = ((Integer)request.getAttribute("listcount")).intValue();
	int nowpage = ((Integer)request.getAttribute("page")).intValue();
	int maxpage = ((Integer)request.getAttribute("maxpage")).intValue();
	int startpage = ((Integer)request.getAttribute("startpage")).intValue();
	int endpage = ((Integer)request.getAttribute("endpage")).intValue();
%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MVC 게시판3</title>
</head>
<body>
	<!-- 게시판 리스트 -->
	<table>
		<tr align="center" valign="middle" bgcolor="#cccc66">
			<td colspan="3">MVC 게시판</td>
			<td colspan="2" align="center">
				<font size="2">글 개수 : ${listcount}</font> <!-- el -->
			</td>
		</tr>	
		
		<tr align="center" valign="middle" bordercolor="#333333">
			<td style="font-family: Tahoma; font-size: 10px;" width="8%" height="26">
				<div align="center">번호</div>
			</td>
			<td style="font-family: Tahoma; font-size: 10px;" width="50%">
				<div align="center">제목</div>
			</td>
			<td style="font-family: Tahoma; font-size: 10px;" width="14%">
				<div align="center">작성자</div>
			</td>
			<td style="font-family: Tahoma; font-size: 10px;" width="17%">
				<div align="center">날짜</div>
			</td>
			<td style="font-family: Tahoma; font-size: 10px;" width="11%">
				<div align="center">조회수</div>
			</td>
		</tr>
		
		<%
			for(int i=0; i<boardList.size();i++){
				BoardBean bl = (BoardBean)boardList.get(i);
		%>	
		<tr align="center" valign="middle" bordercolor="#333333"
			onmouseover="this.style.backgroundColor='#a8Ffa8'"
			onmouseout="this.style.backgroundColor=''">
			<td height="23" style="font-family: Tahoma; font-size: 10px;">
				<%=bl.getBOARD_NUM()%>
			</td>
			
			<td style="font-family:Tahoma; font-size: 10pt;">
				<div align="left">
				<% if(bl.getBOARD_RE_LEV() != 0){ %> <!-- 답변글 레벨이 같다면 한칸씩 들여쓰기 되는 개념 -->
					<% for(int a=0; a <= bl.getBOARD_RE_LEV() * 2 ; a++){ %>
					&nbsp;
					<% } %>
					▶
				<%} else {%>	
					▶
				<% } %>
				<a href="./BoardDetailAction.bo?num=<%=bl.getBOARD_NUM()%>"> <!-- 전달되는 값은 num, 텍스트에 보여주는 값은 subject -->
					<%=bl.getBOARD_SUBJECT()%>
				</a>	
				</div>	
			</td>
			
			<td style="font-family:Tahoma;font-size: 10px;">
				<div align="center"><%=bl.getBOARD_ID() %></div>	
			</td>
			<td style="font-family:Tahoma;font-size: 10px;">
				<div align="center"><%=bl.getBOARD_DATE() %></div>	
			</td>
			<td style="font-family:Tahoma;font-size: 10px;">
				<div align="center"><%=bl.getBOARD_READCOUNT() %></div>	
			</td>
		</tr>
		<% } %>
		<tr align="center" height="20">
			<td colspan="7" style="font-family: Tahoma; font-size:10px;">
				<%if(nowpage <= 1){ %>
				[이전]&nbsp;
				<%}else{%>
				<a href="./BoardList.bo?page=<%=nowpage-1%>">[이전]</a>&nbsp;
				<%} %>
				
				<%for(int a=startpage; a <= endpage; a++) { 
					if(a==nowpage){%>
					[<%=a %>]
					<%}else{%>
					<a href="./BoardList.bo?page=<%=a %>">[<%=a %>]</a>
					&nbsp;
					<%} %>
				<%} %>	
				
				<%if(nowpage>=maxpage){ %>
				[다음]
				<%}else{%>
				<a href="./BoardList.bo?page=<%=nowpage+1%>">[다음]</a>
				<%} %>
			</td>
		</tr>		
		<tr align="right">
			<td colspan="5">
				<%if(id != null && id.equals("admin")) {%> 		 <!-- 회원 중 아이디가 admin이면 회원관리 가능. -->
					<a href="./MemberListAction.me">[회원관리]</a> <!-- .me : 멤버 -->
				<%} %>
				<a href="./BoardWrite.bo">[글쓰기]</a> 			 <!-- .bo : 게시판 -->
			</td>
		</tr>		
	</table>

</body>
</html>