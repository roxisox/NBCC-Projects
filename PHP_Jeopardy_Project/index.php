<!--  -->
<!DOCTYPE html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>    Nick's Jeopardy game</title>
    <!-- Bootstrap core JavaScript-->
    <script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" ></script>    
    <script src="jeopardy.js"></script>
    <link href="bootstrap.min.css" rel="stylesheet">
    <script>
    window.onload = getQuestion;    
    
    </script>
  </head>
  <body>
<div >	
    <div class="col-md-6">
            <!--<img alt="image" src="" />-->
    </div>
    <div class="jumbotron text-center">
            <h1>Nick's jeopardy game</h1>
            <h2>You've got a lot to learn</h2>			
    </div>	
</div>
<div class="row">
    <div class="col-sm-2">
        <label >Category&nbsp;</label>
    </div>
    <div class="col-sm-10 font-weight-bold">
        <label id="lblCategory"></label>
    </div>
</div>
<div class="row">
    <label class="col-sm-2">Clue&nbsp;</label>
    <div class="col-sm-10">
        <label id="lblClue" class="cols-sm-2"></label>        		
    </div>
</div>
<div class="row">
    <label class="col-sm-2">Dollar Value&nbsp;</label>
    <div class="col-sm-10">        
        <label id="lblValue" class="cols-sm-2"></label>        
    </div>
</div>
<div class="row">
    <label for="response" class="col-sm-2">Response&nbsp;</label>
    <div class="col-sm-10">
        <div class="input-group">
            <input type="text" class="form-control" required name="txtResponse" id="txtResponse"  placeholder="ENTER YOUR RESPONSE HERE"/>
            <input type="button" onclick="CheckAnswer()" name="button" id="btnSubmit" value="Submit" class="btn btn-primary btn-sm login-button"/>
            <input type="button" onclick="ShowHint()" name="button" id="btnHint" value="Show Hint" class="btn btn-primary btn-sm login-button"/>
        </div>
    </div>
</div>
<div class="row">
    <label class="col-sm-2 control-label">Your Score&nbsp;</label>
    <div class="col-sm-5">        
        <label id="lblScore"></label>&nbsp;
        <input type="button" onclick="ResetScore()" name="button" id="button" value="Reset Score" class="btn btn-primary btn-sm login-button"/>
    </div>
</div>    
  </body>
</html>