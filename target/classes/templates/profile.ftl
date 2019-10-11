<#import "parts/common.ftl" as cmn>
<#include "parts/navbar.ftl">
<@cmn.page>
    <h3>${username}</h3>
${message?ifExists}

    <form method="post" xmlns="http://www.w3.org/1999/html">


        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Password: </label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control"
                       placeholder="Password"/>
            </div>
        </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label"> Mail: </label>
                <div class="col-sm-6">
                    <input type="email" name="email" class="form-control"
                           placeholder="Email" value="${email!''}"/>
                </div>
            </div>


        <div class="form-group">
            <div class="custom-file">
                <input type="file" name="file" id="customFile">
                <label class="custom-file-label" for="customFile">Choose File</label>
            </div>
        </div>


        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        <button class="btn btn-primary" type="submit">Save</button>
        <br/><br/>
    </form>
</@cmn.page>