package com.krry.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import com.krry.entity.User;

/**
 * service层：处理业务逻辑（impl里面实现）
 * @author asusaad
 *
 */
public interface IUserService {
	
	/**
	 * 根据用户名查询用户是否存在
	 * com.krry.service 
	 * 方法名：getLogin
	 * @author krry 
	 * @param email
	 * @param password
	 * @return User
	 * @exception 
	 * @since  1.0.0
	 */
	/*这里用@Param("name")String name适用于单个参数的传递，在web层调用此方法的时候，就可以传递web层从前台获取的参数，
	      在sql的xml中WHERE email = #{name} or username = #{name}使用此参数，多个参数传递一般使用实体类对象传递    */
	public User getLogin(@Param("name")String name);
	
	/**
	 * 用户名存在时，查询密码是否正确
	 * com.krry.service 
	 * 方法名：getpass
	 * @author krry 
	 * @param email
	 * @param password
	 * @return User
	 * @exception 
	 * @since  1.0.0
	 */
	public User getpass(@Param("name")String name,@Param("password")String password);
	
	/**
	 * 注册时根据输入的昵称查找用户
	 * com.krry.service 
	 * 方法名：getothername
	 * @author krry 
	 * @param name
	 * @return User
	 * @exception 
	 * @since  1.0.0
	 */
	public User getothernameres(@Param("name")String name);
	
	/**
	 * 注册时根据输入的账号查找用户
	 * com.krry.service 
	 * 方法名：getemailres
	 * @author krry 
	 * @param password
	 * @return User
	 * @exception 
	 * @since  1.0.0
	 */
	public User getemailres(@Param("email")String email);
	
	/**
	 * 注册方法
	 * com.krry.service 
	 * 方法名：csaveUser
	 * @author krry 
	 * @param user void
	 * @exception 
	 * @since  1.0.0
	 */
	public void saveUser(User user);
	
}
