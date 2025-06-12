package util;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/**
 * myBatis의 환경 설정 파일(mybatis-config.xml)을 읽어와서  SqlSessionFactory를 생성,
 * 생성된 SqlSessionFactory 객체를 이용하여  SqlSession 객체를 생성하고 
 * SqlSession객체를 반환하는 메서드를 갖는 클래스
 *  
 * @author SEM-PC
 *
 */
public class MyBatisUtil {
	private static SqlSessionFactory sqlSessionFactory = null;
	
	static {
		Reader rd = null;  
		try {
			System.out.println("MyBatis 초기화 시도...");
			rd = Resources.getResourceAsReader("config/mybatis-config.xml");
			
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(rd);
			System.out.println("MyBatis 초기화 성공!!!");
		} catch (Exception e) {
			System.out.println("myBatis 초기화 실패!!!");
			e.printStackTrace();
		} finally {
			if(rd!=null) try { rd.close(); }catch(IOException e) {}
		}
	}
	
	/**
	 * SqlSessionFactory객체를 이용하여 SQL문을 처리할 SqlSession객체를 반환하는 메서드
	 * 
	 * @return SqlSession객체
	 */
	public static SqlSessionFactory  getSessionFactory() {
		return  sqlSessionFactory;
	}
	
	public static SqlSession getSqlSession() {
		SqlSession session = sqlSessionFactory.openSession(true);
		return session;
	}
	
	public static SqlSession getSqlSession(boolean autoComm) {
		SqlSession session = sqlSessionFactory.openSession(autoComm);
		return session;
	}
}
