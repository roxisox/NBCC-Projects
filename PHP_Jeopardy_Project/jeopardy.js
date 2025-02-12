let currentQuestion = {}; // Global variable to store the current question
let totalQuestions = 0;
let correctAnswers = 0;

function getQuestion() {
    // Fetch a new question from GetQuestion.php
    fetch("GetQuestion.php?format=json")
        .then(response => response.json())
        .then(data => {
            console.log("Fetched Question:", data); // Debugging
            if (data.error) {
                alert(data.error);
            } else {
                // Populate the fields
                document.getElementById("lblCategory").textContent = data.category;
                document.getElementById("lblClue").textContent = data.question;
                document.getElementById("lblValue").textContent = "$" + data.value;

                // Store the question globally 
                currentQuestion = data;
                totalQuestions++;
            }
        })
        .catch(error => {
            console.error("Error fetching question:", error);
            alert("Failed to load question. Please try again.");
        });
}

function levenshtein(a, b) {
    const matrix = [];

    // Increment along the first column of each row
    for (let i = 0; i <= b.length; i++) {
        matrix[i] = [i];
    }

    // Increment each column in the first row
    for (let j = 0; j <= a.length; j++) {
        matrix[0][j] = j;
    }

    // Fill in the rest of the matrix
    for (let i = 1; i <= b.length; i++) {
        for (let j = 1; j <= a.length; j++) {
            if (b.charAt(i - 1) === a.charAt(j - 1)) {
                matrix[i][j] = matrix[i - 1][j - 1];
            } else {
                matrix[i][j] = Math.min(
                    matrix[i - 1][j - 1] + 1, // Substitution
                    matrix[i][j - 1] + 1,     // Insertion
                    matrix[i - 1][j] + 1      // Deletion
                );
            }
        }
    }

    return matrix[b.length][a.length];
}



function CheckAnswer() {
    let userAnswer = document.getElementById("txtResponse").value.trim();

    if (!userAnswer) {
        alert("Please enter your response.");
        return false;
    }

    console.log("User's Answer:", userAnswer); // debugging
    console.log("Current Question:", currentQuestion);

    if (currentQuestion && currentQuestion.answer) {

        let correctAnswer = currentQuestion.answer.trim().toLowerCase();
        userAnswer = userAnswer.toLowerCase();

        let distance = levenshtein(userAnswer, correctAnswer);
        console.log("Levenshtein Distance:", distance);

        let typoTolerance = Math.max(1, Math.floor(correctAnswer.length * 0.2));

        if (userAnswer === correctAnswer) {
            alert("Correct");
            correctAnswers++;
        } else if (distance <= typoTolerance) {
            alert(`Close enough, correct answer is: ${correctAnswer}`);
            correctAnswers++;
        } else {
            alert(`sorry correct answer is  ${correctAnswer}`);
        }

        let percentage = (correctAnswers / totalQuestions) * 100;
        document.getElementById("lblScore").textContent = `${correctAnswers} / ${totalQuestions} ${percentage.toFixed(1)}%`;

        // Clear field for the next question
        document.getElementById("txtResponse").value = "";

        // new question after the alert
        getQuestion();
    } else {
        alert("No question loaded. Please load a question first.");
    }

    return true;
}

function ResetScore() {
    totalQuestions = 0;
    correctAnswers = 0;

    // Update the displayed score
    document.getElementById("lblScore").textContent = `0 / 0 - 0%`;

    alert("Score has been reset!");
}

let nextChar = 1;
function ShowHint() {
    // let correctAnswer = currentQuestion.answer.trim().toLowerCase();
    let word = currentQuestion.answer;
    if (nextChar > word.length){
        alert("no more hints avaliabe");
        return false;
    }
        document.getElementById("txtResponse").value = word.substring(0, nextChar++);
return true;
}
