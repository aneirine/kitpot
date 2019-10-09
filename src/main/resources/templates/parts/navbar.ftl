<#include "security.ftl">

<#import "login.ftl" as lgn>
<#--navbar-light   bg-light-->
<div class="navigation">

<div class="container">


    <nav class="navbar navbar-expand-lg">

        <button id="logo_btn"></button>


        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">

                <div class="form-row">
                    <div class="form-group col-md-6 offset-md-2 ">

                        <div class="input-group">

                            <form action="main" class="form-inline" id="search_form">
                                <input type="text" name="filter"  placeholder="Find"
                                       class="form-control"/>
                                <#-- <button type="submit" class="btn btn-primary ml-2">Find</button>-->

                            </form>
                        </div>


                    </div>
                </div>

                <#--  <#if isAdmin>
                  <li class="nav-item active">
                      <a class="nav-link" href="/user">UserList</a>
                  </li>
                  </#if>-->

                <#--<#if user??>
                    <li class="nav-item active">
                        <a class="nav-link" href="/user/profile">Profile</a>
                    </li>
                </#if>-->


            </ul>

            <div class="navbar-text mr-3">${name}</div>
            <@lgn.logout />

        </div>


    </nav>

</div>
</div>