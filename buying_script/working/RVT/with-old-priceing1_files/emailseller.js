function DoSubmit(){

  var g_fname;
  var g_lname;
  var g_email;
  var g_phone;
  var g_message;
  var g_terms;
  var g_phone_req;

  var regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  
  /*g_email = document.reply.from.value;
  if(reg.test(g_email) == false && g_email!="") {
    alert("Please check your email, an invalid email format was entered. Thanks!");
    return false;
  }

  g_phone = document.reply.phone.value;
  if (g_phone=="" && g_email==""){
    alert("Please enter a Phone Number or Email for the seller to contact you. Thanks!");
    return false;
  }*/

  g_message = document.reply.msg.value;
  if (!g_message){
    alert("Please enter a message. Thanks!");
    return false;
  }

  g_fname = document.reply.fname.value;
  if (!g_fname){
    alert("Please provide your name. Thanks!");
    return false;
  }

  g_email = document.reply.from.value.trim();
  if(!regex.test(g_email)) {
    alert("Oops, we need a working email address. Thanks!");
    return false;
  }
  
  g_phone = document.reply.phone.value;
  g_phone_req = document.reply.phone_req.value;
  if (g_phone_req=="1" && !g_phone){
    alert("Please provide your Phone Number. Thanks!");
    return false;
  }  
  
  g_terms = document.reply.agree2terms.checked;
  if (!document.getElementById('contact-terms').checked){
    alert("Please check box to show you have read the disclaimer. Thanks!");
    return false;
  }
}
