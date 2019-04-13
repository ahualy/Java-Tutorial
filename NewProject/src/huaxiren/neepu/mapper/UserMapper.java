package huaxiren.neepu.mapper;

import org.apache.ibatis.annotations.Param;

import huxiren.neepu.po.User;

public interface UserMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(User record);  //插入接口
    
    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    User selectUserByName(@Param("username")String username, @Param("password")String password);
}