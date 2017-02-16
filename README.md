# ns-radius

ns-radius is a radius server to simulate the two-factor authentication for netscaler.

It designed for testing below two scenarios:

- Two-Factor authentication like VipToken or RSAToken
- SMS passcode/token validation as a second factor

---

## Usage

### Deployment

Recommend deploy ns-radius using docker, there is a AUTOMATED BUILD on docker hub.

### Configure NetScaler
1. Add a radius server point to your docker container and use port 1812/udp
2. The hard coded secret is `2003.r2`
3. Create a policy and bind to NetScaler Gateway Virtual Server，then test

### Testing
**scenario 1: For Two-Factor like VipToken/RSAToken**

- Enter `000000` as password 2 to simulate a **failed**/incorrect token
- Enter `888888` as password 2 to simulate a **successful**/correct token

**scenario 2: SMS passcode/token**

1. leave password 2 as **blank** or enter **anything except 000000 and 888888**, then login to simulate the request
2. if user info successfully authenticate via LDAP, netscaler will redirect to the page to validate SMS passcode/token
3. Enter `888888` to simulate a success token, anything else ns-radius will resend challenge again.

## 使用方法

### 部署
建议通过docker方式部署，目前在docker hub上有AUTOMATED BUILD

### 配置NetScaler
1. 添加一个radius server指向docker container，端口为1812，目前只支持UDP
2. radius secret目前代码中硬编码，为 `2003.r2`
3. 创建policy并bind到NetScaler Gateway Virtual Server之后进行测试

### 测试
**场景1： 模拟类似VipToken/RSAToken场景**

- 使用`000000` 作为 password2 来模拟 **错误** token
- 使用`888888` 作为 password2 来模拟 **正确** token

**场景2: 短信验证码场景**

1. password2 **留空** 或者输入**除 000000以及888888 以外**的任何内容
2. 如果用户名和密码验证成功，将跳转到短信验证码验证界面
3. 输入 `888888` 来模拟正确的验证码，任何其他内容模拟错误的验证码。（注：验证码验证失败的话，真实环境会重新生成一个新的验证码，但目前模拟场景不会）