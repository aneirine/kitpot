<#macro login path isRegisterForm>

    <form action="${path}" method="post" xmlns="http://www.w3.org/1999/html">

        <input type="text" name="username" value="<#if user??>${user.username}</#if>"
               class="form-control ${(usernameError??)?string('is-invalid', '')}"
               placeholder="Username"/>
        <#if usernameError??>
            <div class="invalid-feedback">
                ${usernameError}
            </div>
        </#if>


        <input type="password" name="password"
               class="form-control  ${(passwordError??)?string('is-invalid', '')}"
               placeholder="Password"/>
        <#if passwordError??>
            <div class="invalid-feedback">
                ${passwordError}
            </div>
        </#if>

        <#if isRegisterForm>

            <input type="password" name="password2"
                   class="form-control ${(password2Error??)?string('is-invalid', '')}"
                   placeholder="Retype Password"/>
            <#if password2Error??>
                <div class="invalid-feedback">
                    ${password2Error}
                </div>
            </#if>


            <input type="email" name="email" value="<#if user??>${user.email}</#if>"
                   class="form-control  ${(emailError??)?string('is-invalid', '')}"
                   placeholder="Email"/>
            <#if emailError??>
                <div class="invalid-feedback">
                    ${emailError}
                </div>
            </#if>


            <br/>

            <div class="g-recaptcha" data-sitekey="6LfFkLQUAAAAANdWFf-VQXzOB9fJr8lP96hSizTI"></div>
            <#if captchaError??>
                <div class="alert alert-danger" role="alert">
                    ${captchaError}
                </div>
            </#if>

        </#if>

        <br/>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        <center>

            <button id="confirm" type="submit">
                <span>Confirm</span>
            </button>

            <br/><br/>
            <#if !isRegisterForm><a href="/registration">Create new account</a></#if>

        </center>
    </form>
</#macro>


<#macro logout>


    <div>
        <form action="/logout" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button id="confirm" type="submit">
                <#--<span>Confirm</span>-->
            </button>
        </form>
    </div>
</#macro>
