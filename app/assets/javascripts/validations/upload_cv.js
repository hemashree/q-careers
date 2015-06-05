function validateUploadCvForm() {

  $('#form_registration_upload_cv').validate({
    debug: true,
    rules: {
      "candidate[resume]": {
        required: true
      }
    },
    errorElement: "span",
    errorClass: "help-block",

    messages: {

      "candidate[resume]": {
        required: "Choose resume, it can't be blank."
      }
    },

    highlight: function(element) {
      $(element).parent().parent().addClass("has-error");
    },
    unhighlight: function(element) {
      $(element).parent().parent().removeClass("has-error");
    },
    invalidHandler: function(event, validator) {
        // 'this' refers to the form
        var errors = validator.numberOfInvalids();
        if (errors) {

          // Populating error message
          var errorMessage = errors == 1
          ? 'You missed 1 field. It has been highlighted'
          : 'You missed ' + errors + ' fields. They have been highlighted';

          // Removing the form error if it already exists
          $("#div_upload_cv_js_validation_error").remove();

          errorHtml = "<div id='div_upload_cv_js_validation_error' class=\"alert alert-danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          $("#div_modal_generic div.modal-body-main").prepend(errorHtml);

          // Show error labels
          $("div.error").show();

        } else {
          // Hide error labels
          $("div.error").hide();
          // Removing the error message
          $("#div_upload_cv_js_validation_error").remove();
        }
      },
      submitHandler: function(form) {

       form.submit();
     }

   });
}

$( document ).ready(function() {
   validateUploadCvForm();
});