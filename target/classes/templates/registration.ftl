<#import "parts/common_login.ftl" as cmn>
<#import "parts/login.ftl" as lgn>

<@cmn.page>
    <center><h3>Add new user</h3></center>
    <@lgn.login "/registration" true/>
</@cmn.page>
