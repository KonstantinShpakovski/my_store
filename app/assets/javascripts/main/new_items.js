function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#cropbox').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}

$("#item_images_attributes_0_image").change(function(){
    readURL(this);
});