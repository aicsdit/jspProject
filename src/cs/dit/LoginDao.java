/**
 * 
 */
package cs.dit;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**======================================================================
 * 패키지명 : cs.dit
 * 파일명   : LoginDao.java
 * 작성자  : 김진숙
 * 변경이력 : 
 *   2022-4-28/ 최초작성/ 김진숙
 * 프로그램 설명 : Login 테이블의 내용과 연동하여 회원관리
*======================================================================*/
public class LoginDao {

	private Connection getConnection() throws Exception{
		//1. JNDI를 이용하기 위한 객체 생성
		Context initCtx  = new InitialContext();
		
		//2. 등록된 네이밍 서비스로부터 등록된 자원을 가져옴
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		
		//3. 자원들 중 원하는 jdbc/jskim 자원을 찾아내어 데이터소스를 가져옴
		DataSource ds = (DataSource) envCtx.lookup("jdbc/jskim");
		
		//4. 커넥션 얻어옴
		Connection con = ds.getConnection();
		
		return con;
	}
	
	public void insert(LoginDto dto) {
		String sql = "INSERT INTO login(ID, NAME, PWD) VALUES(?, ?, ?)";
		
		try (
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);
		)
		{
			pstmt.setString(1,  dto.getId());
			pstmt.setString(2,  dto.getName());
			pstmt.setString(3,  dto.getPwd());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<LoginDto> list(){
		String sql = "SELECT * FROM login";
		ArrayList<LoginDto> dtos = new ArrayList<LoginDto>();
		
		try (	Connection con = getConnection();
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
			)
			{
				while(rs.next()) {
					LoginDto dto = new LoginDto();
					
					dto.setId(rs.getString("id"));
					dto.setName(rs.getString("name"));
					dto.setPwd(rs.getString("pwd"));
					
					dtos.add(dto);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		return dtos;
	}
	
	public LoginDto selectOne(String id) {
		String sql = "SELECT * FROM login WHERE id =?";
		LoginDto dto = new LoginDto();
		
		try (	Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				)
		{	pstmt.setString(1, id);
		
			try(ResultSet rs = pstmt.executeQuery();)
			{
				rs.next();
				
				dto.setId(id);
				dto.setName(rs.getString("name"));
				dto.setPwd(rs.getString("pwd"));
				
			}catch (Exception e) {
				e.printStackTrace();
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public void update(LoginDto dto) {
		String sql = "UPDATE login SET name = ?, pwd = ? WHERE id =?";
		
		try (
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);
		)
		{
			pstmt.setString(1,  dto.getName());
			pstmt.setString(2,  dto.getPwd());
			pstmt.setString(3,  dto.getId());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	public void delete(String id) {
		String sql = "DELETE FROM login WHERE id =?";
		
		try (
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);
		)
		{
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	
	public void loginChange(LoginDto dto, String flag) {
		PreparedStatement pstmt =null;
		
		try(Connection con = getConnection();
		){
			if(flag.equals("i")) {
				String sql ="INSERT INTO login(ID, NAME, PWD) VALUES(?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,  dto.getId());
				pstmt.setString(2,  dto.getName());
				pstmt.setString(3,  dto.getPwd());
			}else if(flag.equals("u")) {
				String sql ="UPDATE login SET name = ?, pwd = ? WHERE id =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,  dto.getName());
				pstmt.setString(2,  dto.getPwd());
				pstmt.setString(3,  dto.getId());
			}else if(flag.equals("d")) {
				String sql ="DELETE FROM login WHERE id =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,  dto.getId());
			}	
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public int loginCheck(String id, String pwd) {
		String sql = "SELECT pwd FROM login WHERE id =? and pwd = ?";
		int flag = 0;		
		try (	Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				)
		{	pstmt.setString(1, id);
			pstmt.setString(2, pwd);
		
			try(ResultSet rs = pstmt.executeQuery();)
			{
				if(rs.next()) {
					flag = 1;					
				}else {
					flag = 0;
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
}


