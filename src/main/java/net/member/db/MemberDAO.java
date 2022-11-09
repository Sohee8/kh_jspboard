package net.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	DataSource ds;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public MemberDAO(){ //생성자
		try {
			Context init = new InitialContext();
			ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleDB");
		}catch(Exception ex) {
			System.out.println("DB연결 실패 : " + ex);
			return;
		}
	}
	
	
	//11.회원
	public int isMember(MemberBean member) {
		String sql = "SELECT MEMBER_PW FROM MEMBER2 WHERE MEMBER_ID = ? ";
		int result = -1;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getMEMBER_ID());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("MEMBER_PW").equals(member.getMEMBER_PW())) { //입력한 비번과 DB의 비번이 일치한다면
					result = 1; //일치 , boolean이 아닌 숫자로 판별가능하다.(숫자로 할때는 세개이상의 조건 판별가능)
				}else {
					result = 0; //불일치
				}
			}else {
				result = -1; //아이디 존재하지 않음(-1은 초기값, 레코드를 받지 못함)
			}
		}catch(Exception ex) {
			System.out.println("isMember 에러 : " + ex);
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();}catch(SQLException ex) {}
			if(con != null) try {con.close();}catch(SQLException ex) {}
		}
		return result;
	}


	//22. 회원가입
	public boolean joinMember(MemberBean member) {
		String sql = "INSERT INTO MEMBER2 VALUES (?,?,?,?,?,?)";
		int result = 0;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getMEMBER_ID());
			pstmt.setString(2, member.getMEMBER_PW());
			pstmt.setString(3, member.getMEMBER_NAME());
			pstmt.setInt(4, member.getMEMBER_AGE());
			pstmt.setString(5, member.getMEMBER_GENDER());
			pstmt.setString(6, member.getMEMBER_EMAIL());
			result = pstmt.executeUpdate(); //리턴타입 Int
		
			if(result != 0) { //0이 아니라면 = 정상적으로 insert가 되었다면 true를 리턴
				return true;
			}
		}catch(Exception ex) {
			System.out.println("joinMember 에러 : 44" + ex);
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();}catch(SQLException ex) {}
			if(con != null) try {con.close();}catch(SQLException ex) {}
		}
		return false;
	}

	
	//33.회원목록(admin 계정 로그인시 '회원관리')
	public List getMemberList() {
	  //String sql = "SELECT * FROM MEMBER2";
		String sql = "SELECT distinct member_id, member_pw, member_name,"
				+ " member_age, member_gender, member_email"
				+ " FROM MEMBERBOARD m2, MEMBER2 mm WHERE mm.MEMBER_ID = m2.BOARD_ID "; //pk = fk
		//회원가입 후 게시글을 쓴 회원을 추출
		
		List memberlist = new ArrayList();
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberBean mb = new MemberBean();
				mb.setMEMBER_ID(rs.getString("MEMBER_ID"));
				mb.setMEMBER_PW(rs.getString("MEMBER_PW"));
				mb.setMEMBER_NAME(rs.getString("MEMBER_NAME"));
				mb.setMEMBER_AGE(rs.getInt("MEMBER_AGE"));
				mb.setMEMBER_GENDER(rs.getString("MEMBER_GENDER"));
				mb.setMEMBER_EMAIL(rs.getString("MEMBER_EMAIL"));
				
				memberlist.add(mb);
			}
			
			return memberlist;
		}catch(Exception ex) {
			System.out.println("getDetailMember 에러 : " + ex);
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();}catch(SQLException ex) {}
			if(con != null) try {con.close();}catch(SQLException ex) {}
		}
		return null;
	}

	//44. 회원상세보기
	public MemberBean getDetailMember(String id) {
		String sql = "SELECT * FROM MEMBER2 WHERE MEMBER_ID = ?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			rs.next();
			
			MemberBean mb = new MemberBean(); //DTO
			mb.setMEMBER_ID(rs.getString("MEMBER_ID"));
			mb.setMEMBER_PW(rs.getString("MEMBER_PW"));
			mb.setMEMBER_NAME(rs.getString("MEMBER_NAME"));
			mb.setMEMBER_AGE(rs.getInt("MEMBER_AGE"));
			mb.setMEMBER_GENDER(rs.getString("MEMBER_GENDER"));
			mb.setMEMBER_EMAIL(rs.getString("MEMBER_EMAIL"));
			
			return mb;
		}catch(Exception ex) {
			System.out.println("getDetailMember 에러 : " + ex);
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();}catch(SQLException ex) {}
			if(con != null) try {con.close();}catch(SQLException ex) {}
		}
		return null;
	}

	//회원상세에서 삭제
	public boolean deleteMember(String id) {
		String sql = "DELETE FROM MEMBER2 WHERE MEMBER_ID = ?";
		int result = 0;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			result = pstmt.executeUpdate();
			if(result != 0) {
				return true;
			}
		}
		catch(Exception ex) {
			System.out.println("deleteMember에러 : " + ex);
		}
		finally {
			if(rs != null) try {rs.close();}catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();}catch(SQLException ex) {}
			if(con != null) try {con.close();}catch(SQLException ex) {}
		}
		
		return false;
	}
		
}
