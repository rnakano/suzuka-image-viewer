$(function(){
  $("#main").bind('drop', function(event){
    console.log("drop!");
    var formData = new FormData();
    var file = event.originalEvent.dataTransfer.files;
    console.log(file);
    f = file;
    for(var i = 0; i < file.length; i++){
      formData.append('file' + i, file[i]);
    }
    console.log(formData);

    $.ajax('/upload', {
      method: 'POST',
      contentType: false,
      processData: false,
      data: formData,
      error: function(){
        console.log("upload failed");
      },
      success: function(){
        console.log("upload successful");
      }
    });
    
    return false;
  }).bind("dragenter", function(){
    return false;
  }).bind("dragover", function(){
    return false;
  });
});