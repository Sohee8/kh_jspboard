<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>    
<%@ page import = "net.member.db.*" %>
<%
	List memberlist = (List)request.getAttribute("memberlist");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리 시스템 관리자모드(회원목록보기)</title>
</head>
<body>

	<table border="1">
		<tr align = "center">
			<td colspan="2">관리자 회원목록 보기</td>
		</tr>	
		<%
			for(int i=0; i<memberlist.size(); i++){
				MemberBean member = (MemberBean)memberlist.get(i);
		%>
		<tr align="center">
			<td>
				<a href="MemberViewAction.me?id=<%=member.getMEMBER_ID()%>">
					<%=member.getMEMBER_ID() %>
				</a>
			</td>
			<td>
			<a href="MemberDeleteAction.me?id=<%=member.getMEMBER_ID() %>"> 삭 제 </a>
			</td>
		</tr>
		<% } %>
		
		<tr align="center">
			<td colspan="2">
				<a href="./BoardList.bo">[게시판 이동]</a>					
			</td>
		</tr>		
	</table>

</body>
</html>