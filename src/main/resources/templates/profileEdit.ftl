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


        <#--<div class="form-group">
            <div class="custom-file">
                <input type="file" name="file" id="customFile">
                <label class="custom-file-label" for="customFile">Choose File</label>
            </div>
        </div>-->

        <input type="file" name="image" id="image" onchange="readURL(this);"/>
        <div class="image_container">
            <img id="blah" src="#" alt="your image"/>
        </div>

        <script type="text/javascript" defer>
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#blah').attr('src', e.target.result)
                    };
                    reader.readAsDataURL(input.files[0]);
                    setTimeout(initCropper, 1000);
                }
            }

            function initCropper() {
                var image = document.getElementById('blah');
                var cropper = new Cropper(image, {
                    aspectRatio: 1 / 1,
                    crop: function (e) {
                        console.log(e.detail.x);
                        console.log(e.detail.y);
                    }
                });

            }
        </script>

        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        <button class="btn btn-primary" type="submit">Save</button>
        <br/><br/>
    </form>
</@cmn.page>