package huaxiren.neepu.controller;


import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import huaxiren.neepu.mapper.UserMapper;
import huxiren.neepu.po.User;

 /* 
 * @author Huaxiren
 * 2019年3月31日
 */
@Controller
public class UserController {
	
	@Resource
//  接口实现类，通过注解，直接生成一个实现类对象userMapper
    private UserMapper userMapper;
	//注册页面跳转控制器
	@RequestMapping("/regist")
	public String regist() {
		return "/regist";
	}
	
	//注册页面提交成功后跳转到登录界面
		@RequestMapping("/login")
		public String login() {
			return "/login";
	}
	//登录成功跳转到成功页面index	
		@RequestMapping("/index")
		public String index() {
			return "/index";
	}

	//注册业务实现类
	@RequestMapping("/addUser")
	public ModelAndView addUser(ModelAndView mv,@RequestParam("username")String username,
			@RequestParam("password")String password) {
	    //这里将用户信息封装到user对象中
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		//将user对象作为参数出入掺入方法
		userMapper.insert(user);
		mv.setViewName("redirect:/login");
		return mv;
	}
	
	//登录业务实现类
	@RequestMapping("/toLogin")
	public ModelAndView toLogin(ModelAndView mv,@RequestParam("username")String username,
			@RequestParam("password")String password) {
	    //这里通过用户的用户名和密码去数据库查询，看是否有此用户
		User user = userMapper.selectUserByName(username,password);
		if(user!=null) {
			mv.setViewName("redirect:/index");//登录成功跳转到index页面
		}else {
			mv.setViewName("redirect:/login");//重定向到登录页面
		}
		return mv;
	}
}
