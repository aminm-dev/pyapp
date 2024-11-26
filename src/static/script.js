function validateForm(){
    let fName = document.getElementById("firstName").value;
    let lName = document.getElementById("lastName").value;

    if(fName === "" || lName === ""){
        alert("Input for both firstname and lastname required!");
    }
}

function greetMe(event){
    
    let fName = document.getElementById("firstName").value;
    let lName = document.getElementById("lastName").value;
    let greeting = "Hello " + fName + " " + lName;

    if (validateForm()){
        document.getElementById("outputGreet").innerHTML = greeting;
        document.getElementById("greetingCard").classList.remove("hidden");
        document.getElementById("greetingCard").classList.add("visible");
    }
}
