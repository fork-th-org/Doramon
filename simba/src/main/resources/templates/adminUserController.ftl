package ${appPath}.controller;

import ${appPath}.constants.AdminConstant;
import ${appPath}.view.LoginResponseEntity;
import ${appPath}.view.AccountEntity;
import java.util.HashMap;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import me.zzp.am.Record;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author robot
 */
@Slf4j
@RestController
@RequestMapping(AdminConstant.ADMIN_API_V1 + "/" + "privilege")
public class AdminUserController implements InitializingBean {

    private Map<String, AccountEntity> userMap = new HashMap<>();

    @PostMapping("login/account")
    public LoginResponseEntity account(@RequestBody Record record) {
        log.debug("用户登录account：" + record);
        AccountEntity account = userValid(record);
        if (null != account){
            return LoginResponseEntity.build(account);
        }
        return LoginResponseEntity.loginFail();
    }

    private AccountEntity userValid(Record record){
        if(!record.isEmpty()){
            String name = record.getStr("userName");
            if(userMap.containsKey(name)){
                AccountEntity account = userMap.get(name);
                if(account.getPassword().equals(record.getStr("password"))){
                    return account;
                }
            }
        }
        return null;
    }

    @Override
    public void afterPropertiesSet() {
        userMap.put("admin", AccountEntity.of("admin", "admin@123", "admin"));
        userMap.put("like", AccountEntity.of("like", "like@123", "admin"));
        userMap.put("user", AccountEntity.of("user", "user@123", "user"));
        userMap.put("guest", AccountEntity.of("guest", "guest", "guest"));
    }
}
