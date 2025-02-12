<?php

include("connect.php");

$url = "http://cluebase.lukelav.in/clues/random";
header("Content-Type: application/json");


for ($i = 0; $i < 100; $i++) { // loop 100 times
// //call the functions
// doGet($cobj, $con);

// function doGet($cobj, $con)
// {
    $cobj = curl_init($url);

    curl_setopt($cobj, CURLOPT_RETURNTRANSFER, true); //return the response as a string
    //execute the request
    $response = curl_exec($cobj);

    $details = json_decode($response, TRUE);
    $data = $details['data'][0];
    $Answer = $data['response'];
    $Clue = $data['clue'];
    $Category = $data['category'];
    $Value = $data['value'];

    echo "GET RESPONSE " . $response . "<BR>";
    echo "Deatails : " . $Answer . ' ' . $Clue . ' ' . $Category . ' ' . $Value;


    // ----------------------------------------------------catagory table -------------------------------------------//

        // Check if category exists
        $checkCategorySql = "SELECT id FROM categories WHERE title = ?";
        $stmt = $con->prepare($checkCategorySql);
        $stmt->bind_param("s", $Category);
        $stmt->execute();
        $result = $stmt->get_result();
    
        if ($result->num_rows > 0) {
            // Get existing category_id
            $row = $result->fetch_assoc();
            $categoryId = $row['id'];
        } else {
            // Insert new category
            $insertCategorySql = "INSERT INTO categories (title) VALUES (?)";
            $stmt = $con->prepare($insertCategorySql);
            $stmt->bind_param("s", $Category);
            $stmt->execute();
            $categoryId = $stmt->insert_id; // Get the new category_id
        }
    
        // Insert question into the questions table
        $insertQuestionSql = "INSERT INTO questions (question, answer, catId, value) VALUES (?, ?, ?, ?)";
        $stmt = $con->prepare($insertQuestionSql);
        $stmt->bind_param("ssii", $Clue, $Answer, $categoryId, $Value);
    
        if ($stmt->execute()) {
            echo "Question inserted successfully!<br>";
        } else {
            echo "Failed to insert question: " . $stmt->error;
        }
    
        $stmt->close();
        curl_close($cobj);

    // $sql = "INSERT INTO categories (title) VALUES (?)";

    // $stmt = $con->prepare($sql);
    // $stmt->bind_param("s", $Category);

    // // //execute the sql
    // // if ($stmt->execute()) {
    // //     echo "Record inserted successfully.";

    // // } else {
    // //     echo "Error: " . $stmt->error;
    // // }

    // if ($con->query($sql) === TRUE) {
    //     $last_id = $con->insert_id;
    //     echo "New record created successfully. Last inserted ID is: " . $last_id;
    // } else {
    //     echo "Error: " . $sql . "<br>" . $con->error;
    // }

    // $con->close();
    // ----------------------------------------------------Question table -------------------------------------------//

    // Insert question into the questions table

    // $sqlQuestion = "INSERT INTO `questions` (`question`, `response`, `catid`, `value`) VALUES ($Clue, $Response, $last_id, $Value)";
    // $stmtQuestion = $con->prepare($sqlQuestion);
    // if (!$stmtQuestion) {
    //     die("Question prepare failed: " . $con->error);
    // }

    // if ($stmtQuestion->execute()) {
    //     echo "Question inserted successfully.<br>";
    // } else {
    //     die("Error inserting question: " . $stmtQuestion->error);
    // }
    // $stmtQuestion->close();

    // curl_close($cobj);


}//end get

?>