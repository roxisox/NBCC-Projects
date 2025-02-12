<?php
include("connect.php");

$format = isset($_GET["format"]) ? $_GET["format"] : "json";//  xml or json
if ($format == "json") {
    header("Content-Type: application/json");

    $sql = "SELECT  q.id AS question_id, q.question, q.answer, q.value, c.title AS category FROM questions q JOIN categories c ON q.catId = c.id
                ORDER BY RAND() LIMIT 1";

    $result = $con->query($sql);
    if ($result && $result->num_rows > 0) {
        $row = $result->fetch_assoc();
        // $arr = array('a' => 1, 'b' => 2, 'c' => 3, 'd' => 4, 'e' => 5);
        $questionData = [
            "question_id" => $row['question_id'],
            "question" => $row['question'],
            "answer" => $row['answer'],
            "value" => $row['value'],
            "category" => $row['category']
        ];

        echo json_encode($questionData);
    } else {
        echo json_encode(["error" => "No questions available in the database."]);
    }
} else if ($format == "xml") {
    header("content-type: text/xml");
    echo "<?xml version=\"1.0\"?>";
    echo "<root>";
    echo "<value>" . $result . "</value>";
    echo "</root>";
} else { //in case they pass an invalid format
    header("content-type: text/xml");
    echo "<?xml version=\"1.0\"?>";
    echo "<root>";
    echo "<value>Invalid format-please enter XML or JSON</value>";
    echo "</root>";
}
?>