function validateUsername(){
    const username = document.getElementById("username").value;
    const nonNullRegex = /[a-zA-Z]/g;
    console.log(username.match(nonNullRegex));
    return username.match(nonNullRegex)!=null;
}

function validateName(){
    const name = document.getElementById("name").value;
    const nonNullRegex = /[a-zA-Z]/g;
    console.log(name.match(nonNullRegex));
    return name.match(nonNullRegex)!=null;
}

function validateEmail(){
    const email = document.getElementById("email").value;
    const emailRegex=/[a-z]+@[a-z]+.com/g;
    console.log(email.match(emailRegex));
    return email.match(emailRegex)!=null;
}

function validateAge(){
    const age = document.getElementById("age").value;
    const ageRegex = /[0-9]+/g;
    console.log(age.match(ageRegex));
    return age.match(ageRegex)!=null;
}



function validateRegister() {
    if(!validateUsername() || !validateName() || !validateEmail() || !validateAge() || !validateHometown() || !validateImg())
        alert("Invalid parameters, can't register!");
    else
    {
        document.getElementById("registerForm").submit();
    }

}

function validateUpdateInfo() {
    if(!validateName() || !validateEmail() || !validateAge() || !validateHometown() || !validateImg())
        alert("Invalid parameters, can't update!");
    else {
        if (confirm('Are you sure you want to update?'))
            document.getElementById("updateForm").submit();
    }

}