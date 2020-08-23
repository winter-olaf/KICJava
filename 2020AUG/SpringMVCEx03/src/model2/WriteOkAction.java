package model2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class WriteOkAction implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("write_ok");
		
//		arg0.setCharacterEncoding("utf-8");
		
		System.out.println(arg0.getParameter("data"));
		
//		arg0.setAttribute("data", arg0.getParameter("data"));
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("data", arg0.getParameter("data"));
		modelAndView.setViewName("write_ok");
		return modelAndView;
	}

}
