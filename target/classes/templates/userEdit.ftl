<#import "parts/common.ftl" as cmn>

<@cmn.page>
    User editor

    <form action="/user" method="post" >
        <input type="text" name="username" value="${user.username}">
        <#list roles as role>
            <div>
                <label><input type="checkbox"
                              name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>
            </div>
        </#list>
        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <button type="submit">Save</button>
    </form>

    <form method="post" action="deleteUser">
        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit">Delete</button>
    </form>


</@cmn.page>