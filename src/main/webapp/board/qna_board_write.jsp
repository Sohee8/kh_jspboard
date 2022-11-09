<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MVC 게시판</title>
<script type="text/javascript">
	function addboard() {
		boardform.submit();
	}
</script>
</head>
<body>
	<!-- 게시판 등록 -->
	<form action="./BoardAddAction.bo" method="post" enctype="multipart/form-data" name="boardform"> <!-- cos.jar가 있어야 enctype사용가능 -->
		<input type="hidden" name="BOARD_ID" value="<%=id %>">
		<table>
			<tr align="center" valign="middle">
				<td colspan="5">MVC 게시판 write</td>
			</tr>
			<tr>
				<td style="font-family: 돋움;font-size: 12" height="16">
					<div align="center">글쓴이</div>
				</td>
				<td>
					<%=id %>
				</td>
			</tr>
			
			<tr>
				<td style="font-family: 돋움;font-size: 12" height="16">
					<div align="center">제 목</div>
				</td>
				<td>
					<input name="BOARD_SUBJECT" type="text" size="50" maxlength="100"
						value=""/>
				</td>
			</tr>		
			<tr>
				<td style="font-family: 돋움; font-size: 12">
					<div align="center">내 용</div>
				</td>
				<td>
					<textarea name="BOARD_CONTENT" rows="15" cols="67"></textarea>
				</td>
			</tr>	
			
			
			<tr>
				<td style="font-family: 돋움;font-size: 12">
					<div align="center">파일첨부</div>
				</td>
				<td>
					<input name="BOARD_FILE" type="file"/>
				</td>
			</tr>	
			<tr bgcolor="cccccc">
				<td colspan="2" style="height:1px;">
				</td>
			</tr>
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr align="center" valign="middle">
				<td colspan="5">
					<a href="javascript:addboard()">[등록]</a>&nbsp;&nbsp;
					<a href="javascript:history.go(-1)">[뒤로]</a>
				</td>
			</tr>	
		</table>
	</form>
	<!-- 게시판 등록 끝 -->
</body>
</html>