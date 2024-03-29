﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@page import="java.sql.PreparedStatement"%>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	String seq = request.getParameter("seq");
	
	String subject = "";
	String writer = "";
	String mail = "";
	String content=  "";
	String mail1= "";
	String mail2= "";
	String emot = "";
	String emots = "";
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource dataSource = (DataSource)envCtx.lookup("jdbc/mariadb1");
		conn = dataSource.getConnection();
		
		
		String sql = "select subject,emot,writer,mail,content from emoji_board where seq=?";
		pstmt = conn.prepareStatement(sql);	
		pstmt.setString(1, seq);
		
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			subject = rs.getString("subject");
			mail = rs.getString("mail");
			if (!mail.equals("")) {
				int gIdx = mail.indexOf("@");
				mail1 = mail.substring(0, gIdx);
				mail2 = mail.substring(gIdx+1);	
			}
			emot = rs.getString("emot");
			int emotInt = Integer.parseInt(emot);
			writer = rs.getString("writer");
			content = rs.getString("content").replaceAll("\n","<br>");
			int emotsCnt = 1;
			for (int i=1; i<=3; i++) {
				emots += "<tr>";
				for (int j=1; j<=15; j++) {
					if (emotInt == emotsCnt) {
						if (emotsCnt <=9) {
							emots += "<td><img src='../../images/emoticon/emot0"+Integer.toString(emotsCnt)+".png' width='25' /><br /> <input type='radio' name='emot' value='emot" +Integer.toString(emotsCnt)+"' class='input_radio' checked='checked'/></td>";
						} else {
							emots += "<td><img src='../../images/emoticon/emot"+Integer.toString(emotsCnt)+".png' width='25' /><br /> <input type='radio' name='emot' value='emot" +Integer.toString(emotsCnt)+"' class='input_radio' checked='checked'/></td>";
						}
					} else if (emotsCnt <=9) {
						emots += "<td><img src='../../images/emoticon/emot0"+Integer.toString(emotsCnt)+".png' width='25' /><br /> <input type='radio' name='emot' value='emot" +Integer.toString(emotsCnt)+"' class='input_radio' /></td>";
					} else {
						emots += "<td><img src='../../images/emoticon/emot"+Integer.toString(emotsCnt)+".png' width='25' /><br /> <input type='radio' name='emot' value='emot" +Integer.toString(emotsCnt)+"' class='input_radio' /></td>";
					}
					emotsCnt++;
				}
				emots += "</tr>";
			}
		}
	} catch (NamingException e) {
		System.out.println("[modify1에러] : "+e.getMessage());
	} catch (SQLException e) { 
		System.out.println("[modify1에러] : "+e.getMessage());
	} finally {
		if (conn != null) conn.close();
		if (pstmt != null) pstmt.close();
		if (rs != null) rs.close();
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../../css/board_write.css">
<script type="text/javascript">
	window.onload = function() {
		document.getElementById('mbtn').onclick = function() {
			if (document.mfrm.password.value.trim() == '') {
				alert('비밀번호를 입력해야 합니다.');
				return false
			};
			if (document.mfrm.subject.value.trim() == '') {
				alert('제목을 입력해야 합니다.');
				return false
			};
			document.mfrm.submit();
		};
	};
</script>
</head>

<body>
<!-- 상단 디자인 -->
<div class="con_title">
	<h3>게시판</h3>
	<p>HOME &gt; 게시판 &gt; <strong>게시판</strong></p>
</div>
<div class="con_txt">
	<form action="./board_modify1_ok.jsp" method="post" name="mfrm">
		<input type="hidden" name="seq" value="<%= seq %>"/>
		<div class="contents_sub">	
			<!--게시판-->
			<div class="board_write">
				<table>
				<tr>
					<th class="top">글쓴이</th>
					<td class="top" colspan="3"><input type="text" name="writer" value="<%= writer %>" class="board_view_input_mail" maxlength="5" readonly/></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" name="subject" value="<%= subject %>" class="board_view_input" /></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td colspan="3"><input type="password" name="password" value="" class="board_view_input_mail"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<!--  텍스트에리어는 body 부분에 넣어주면 된다 -->
					<td colspan="3"><textarea name="content" class="board_editor_area"><%= content %></textarea></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan="3"><input type="text" name="mail1" value="<%= mail1 %>" class="board_view_input_mail"/> @ <input type="text" name="mail2" value="<%= mail2 %>" class="board_view_input_mail"/></td>
				</tr>
				<tr>
					<th>이모티콘</th>
					<td colspan="3" align="center">
						<table>
						<%= emots %>
						</table>
					</td>
				</tr>
				</table>
			</div>
			
			<div class="btn_area">
				<div class="align_left">
					<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='board_list1.jsp'" />
					<input type="button" value="보기" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='board_view1.jsp'" />
				</div>
				<div class="align_right">
					<input type="button" id="mbtn" value="수정" class="btn_write btn_txt01" style="cursor: pointer;" />
				</div>
			</div>
			<!--게시판-->
		</div>
	</form>
</div>
<!-- 하단 디자인 -->

</body>
</html>
