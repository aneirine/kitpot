<#import "parts/common.ftl" as cmn>

<@cmn.page>
    <div>
        <a href="/main">Main Page</a>
    </div>

    List of users

    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Role</th>
            <th></th>
        </tr>
        </thead>

        <tbody>
        <#list users as user>
            <tr>
                <td>${user.username}</td>
                <td><#list user.roles as role>${role}<#sep>, </#list></td>
                <td><a href="/user/${user.id}">Edit User</a></td>

            </tr>

        </#list>

        </tbody>

    </table>




</@cmn.page>