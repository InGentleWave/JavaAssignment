package kr.or.ddit.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.service.IMemberService;
import kr.or.ddit.service.MemberServiceImpl;
import kr.or.ddit.vo.MemberVO;
import util.GsonUtil;

@WebServlet("/list.do")
public class MemberListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private IMemberService service = null;
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		boolean isAjax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));
		service = MemberServiceImpl.getInstance();
		if (isAjax) {
			System.out.println("비동기방식 doGet() 호출됨");
			
			List<MemberVO> list = service.getListAll();
			resp.setContentType("application/json; charset=UTF-8");
			
			Gson gson = GsonUtil.getInstance();
			String jsonData = gson.toJson(list);
			System.out.println(jsonData);
			PrintWriter out = resp.getWriter();
			out.write(jsonData);
			out.flush();
		} else {
			resp.setContentType("text/html; charset=UTF-8");
			List<MemberVO> list = service.getListAll();
			System.out.println(list);
			System.out.println("동기방식 doGet() 호출됨");
			req.getRequestDispatcher("/WEB-INF/views/memberList.jsp").forward(req, resp);
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
