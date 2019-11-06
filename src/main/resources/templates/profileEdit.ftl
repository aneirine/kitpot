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


        <input type="file" name="image" id="image" onchange="readURL(this);"/>
        <div class="image_container">
            <#if image_url??>
                <img id="blah" class="card-img" src="/img/${image_url}" style="width:250px; height:250px;">
            <#else>  <img id="blah" class="card-img" src="/img/lapka.png">
            </#if>

        </div>

        <button id="crop_button" type="button">Crop</button>

        <div class="cropped_result">
            <img src="" id="cropped_image">
        </div>

        <script type="text/javascript" defer>
            var cropper;

            function readURL(input) {
                if (cropper != null) {
                    cropper.destroy();
                }
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
                cropper = new Cropper(image, {
                    aspectRatio: 1 / 1,
                    crop: function (e) {
                        console.log(e.detail.x);
                        console.log(e.detail.y);
                    }
                });

                document.getElementById('crop_button').addEventListener('click', function () {
                    /* var cropped_image = document.getElementById('cropped_image');

                     cropped_image.src = */
                   // readURL(cropper.getCroppedCanvas().toDataURL());


                    var blah = document.getElementById('blah');
                    blah.src = cropper.getCroppedCanvas().toDataURL();
                    if (cropper != null) {
                        cropper.destroy();
                    }
                });

            }
        </script>

        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-primary" type="submit">Save</button>
        <br/><br/>
    </form>
</@cmn.page>