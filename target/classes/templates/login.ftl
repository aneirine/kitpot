<#import "parts/common_login.ftl" as cmn>
<#import "parts/login.ftl" as lgn>

<@cmn.page>

    <center><h3>Log in</h3></center>

    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
        <div class="alert alert-primary" role="alert">
            ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
        </div>
    </#if>

    <#if message??>
        <div class="alert alert-${messageType}" role="alert">
            ${message}
        </div>
    </#if>


   <@lgn.login "/login" false/>

</@cmn.page>



