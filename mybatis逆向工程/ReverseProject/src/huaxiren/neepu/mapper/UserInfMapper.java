package huaxiren.neepu.mapper;

import huxiren.neepu.po.UserInf;
import huxiren.neepu.po.UserInfExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UserInfMapper {
    int countByExample(UserInfExample example);

    int deleteByExample(UserInfExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(UserInf record);

    int insertSelective(UserInf record);

    List<UserInf> selectByExample(UserInfExample example);

    UserInf selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") UserInf record, @Param("example") UserInfExample example);

    int updateByExample(@Param("record") UserInf record, @Param("example") UserInfExample example);

    int updateByPrimaryKeySelective(UserInf record);

    int updateByPrimaryKey(UserInf record);
}