<#include "security.ftl">

<#import "login.ftl" as lgn>
<#--navbar-light   bg-light-->
<div class="navigation">

    <div class="container">


        <nav class="navbar navbar-expand-lg">


            <nav class="navbar">
                <a class="navbar-brand" href="/">
                    <img src="../public/img/logo_pink_small.png" width="30" height="40" alt="">
                </a>
            </nav>

            <#--<button id="logo_btn"></button>-->


            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">

                    <div class="form-row">
                        <div class="form-group offset-md-1 ">

                            <div class="input-group">

                                <form action="main" class="form-inline" id="search_form">
                                    <input type="text" name="filter" placeholder="Find"
                                           class="form-control"/>
                                    <#-- <button type="submit" class="btn btn-primary ml-2">Find</button>-->

                                </form>
                            </div>


                        </div>
                    </div>


                    <#--<#if user??>
                        <li class="nav-item active">
                            <a class="nav-link" href="/user/profile">Profile</a>
                        </li>
                    </#if>-->


                </ul>

                <#if isAdmin>
                    <a class="nav-link links" href="/user">UserList</a>
                </#if>


                <#--<div class="name-form">
                    <div class="navbar-text mr-3">
                        <a class="nav-link links" href="/user/profile"> ${name}</a>
                    </div>
                </div>

-->
                <#--<nav class="navbar">
                    <a class="navbar-brand links" href="/myMessages/${currentUserId}">
                        My messages
                        <img src="../public/img/oval.png" class="offset-md-2 mr-3">

                    </a>
                </nav>-->


                <nav class="navbar">
                    <a class="navbar-brand links" href="/user/profile/${currentUserId}">
                        ${name}
                        <img src="../public/img/oval.png" class="offset-md-2 mr-3">

                    </a>
                </nav>

                <#-- <div class="user-image mr-3">
                     <img src="../public/img/oval.png">
                 </div>-->

                <div class="mr-3">
                    <@lgn.logout />
                </div>
            </div>


        </nav>

    </div>
</div>