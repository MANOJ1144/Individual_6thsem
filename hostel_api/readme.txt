
//create batch

http://localhost:3000/api/v1/batch/createBatch


//Add Batch 

{
"batchName": "31A"
}


//Create Block
http://localhost:3000/api/v1/block/createBlock

//Json
{
  "blockName":"OLI"
  
}

//Register student
localhost:3000/api/v1/auth/register

{
  "fname": "manoj",
  "lname": "oli",
  "image": "IMG-1686891900876.jpg",
  "username": "manoj",
  "password": "12345678",
  "batch": "64d76b839647cd45366da795",
  "block": [ "64d76b289647cd45366da793" ]
}

//login
localhost:3000/api/v1/auth/login

{
 
  "username": "manoj", 
  "password": "12345678"
}

//Upload image
localhost:3000/api/v1/auth/uploadImage



