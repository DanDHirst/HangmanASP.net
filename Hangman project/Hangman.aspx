<%@ Page Language="C#" %> 
<%@ Import Namespace="System.Data.OleDb" %>
<script runat="server">

    void Page_Load(){
        Random rnd = new Random();
        int ranNum = rnd.Next(1, 200000);
        String cs = "Provider=Microsoft.ACE.OLEDB.12.0;" + "Data Source=" + Server.MapPath("Words.accdb") + ";";
        OleDbConnection cn = new OleDbConnection(cs);
        OleDbCommand cmd;
        String h;
        OleDbDataReader r;
        String sql  = "SELECT * FROM Words WHERE id=" + ranNum;
        cmd = new OleDbCommand(sql, cn);
        cn.Open();
        r = cmd.ExecuteReader();
        while(r.Read()){
            h = r["Words"].ToString();
            msg.InnerText = h;
        }
        cn.Close();


    }
    void btnLogon_Click(Object s, EventArgs e){ 
        String user;
        String pass;
        user = txtUserName.Value;
        pass = txtPassWord.Value;
        String cs = "Provider=Microsoft.ACE.OLEDB.12.0;" + "Data Source=" + Server.MapPath("userdb.accdb") + ";";
        OleDbConnection cn = new OleDbConnection(cs);
        OleDbCommand cmd;
        String h;
        OleDbDataReader r;
        String sql  = "SELECT ID,Highscore FROM userdb WHERE Username='" + user + "' AND Password='" + pass + "'";
        cmd = new OleDbCommand(sql, cn);
        cn.Open();
        r = cmd.ExecuteReader();
        while (r.Read()){
            h = r["ID"].ToString();
            userid.InnerText = h;
            Score.InnerText = r["Highscore"].ToString();
        }
        cn.Close();
    }
    void btnRegister_click(Object s, EventArgs e){ 
        String user;
        String pass;
        user = txtUserName.Value;
        pass = txtPassWord.Value;
        bool Skip = false;
        String cs = "Provider=Microsoft.ACE.OLEDB.12.0;" + "Data Source=" + Server.MapPath("userdb.accdb") + ";";
        OleDbConnection cn = new OleDbConnection(cs);
        OleDbCommand cmd;
        String h;
        int I;
        OleDbDataReader r;
        String sql  = "SELECT ID FROM userdb WHERE Username='" + user + "'";
        cmd = new OleDbCommand(sql, cn);
        cn.Open();
        r = cmd.ExecuteReader();
        while (r.Read())
        {
            h = r["ID"].ToString();
            I = Int32.Parse(h);
            if (I > 1)
            {
                userid.InnerText = "Username is in use";
                Skip = true;

            }

        }
        if (Skip==false)
        {
            sql = "INSERT INTO userdb ([Username],[Password]) VALUES ( " + "'" + user + "'" + ",  " + "'" + pass + "'" + ")";
            cmd = new OleDbCommand(sql, cn);
            cmd.ExecuteNonQuery();
        }
        cn.Close();

    }
    void btnHighscore_click(Object s, EventArgs e){
        int Userid = Int32.Parse(userid.InnerText);
        String score = (scorehidden.Value);
        String cs = "Provider=Microsoft.ACE.OLEDB.12.0;" + "Data Source=" + Server.MapPath("userdb.accdb") + ";";
        OleDbConnection cn = new OleDbConnection(cs);
        String sql;
        OleDbCommand cmd;
        sql  = "UPDATE userdb SET Highscore=" + Int32.Parse(score) +" WHERE id =" + Userid;
        cmd = new OleDbCommand(sql, cn);
        cn.Open();
        cmd.ExecuteNonQuery();
        OleDbDataReader r;
        sql  = "SELECT Highscore FROM userdb WHERE id="+ Userid;
        cmd = new OleDbCommand(sql, cn);
        r = cmd.ExecuteReader();
        while (r.Read()){
            Score.InnerText = r["Highscore"].ToString();
        }
        cn.Close();
    }
    void btnlogout(Object s, EventArgs e){
        userid.InnerText = "";
        scorehidden.Value = "";
        Score.InnerText = "";
        


    }
</script>

<html>
  <head><title></title>
      <style type="text/css">
          .center {
              width: 413px;
              margin-left: 284px;
          }
      </style>
  </head>
  <body onload="underscore_gen()">
    <form runat="server">
      <div style='float:right;  margin:0px; border: 1px solid lightgray;'>
        Username<input id="txtUserName" type="text" runat="server" ><br>
        Password <input id="txtPassWord" type="text" runat="server" ><br>
        <input id="btnLogon" type="submit" value="Logon" runat="server" onserverclick="btnLogon_Click" />
        <input id="btnRegister" type="submit" value="Register" runat="server" onserverclick="btnRegister_click" />
        <input id="logout" type="button" value="logout" runat="server" onserverclick="btnlogout">
        <input id="btnHighscore" type="submit" value="Next word" runat="server" onserverclick="btnHighscore_click" hidden/>
        <input id="scorehidden" type="text" runat="server" hidden>
      </div>
      <div style='float:left; width: 89px;border: 1px solid lightgray;'>
      <p id="msg" runat="server" hidden></p>
      User id:<p id="userid" runat="server"></p>
      score:<p id="Score" runat="server" >0</p>
      </div>
    </form>
      
      <img src="base.jpg" id="hangman" style="width:200px;height:200px;  margin-left: 270px;">
      <p id="parWord" style="margin-left: 396px; width: 792px;"></p>
      <table class ="center" >
	<tr>
		<td>
			<input type="button" value="Q" id="q" onclick="Checkword(this.id)" >
			<input type="button" value="W" id="w" onclick="Checkword(this.id)">
			<input type="button" value="E" id="e" onclick="Checkword(this.id)">
			<input type="button" value="R" id="r" onclick="Checkword(this.id)">
			<input type="button" value="T" id="t" onclick="Checkword(this.id)">
			<input type="button" value="Y" id="y" onclick="Checkword(this.id)">
			<input type="button" value="U" id="u" onclick="Checkword(this.id)">
			<input type="button" value="I" id="i" onclick="Checkword(this.id)">
			<input type="button" value="O" id="o" onclick="Checkword(this.id)">
			<input type="button" value="P" id="p" onclick="Checkword(this.id)">
		</td>
	</tr>
	<tr>
		<td>
			<input type="button" value="A" id="a" onclick="Checkword(this.id)">
			<input type="button" value="S" id="s" onclick="Checkword(this.id)">
			<input type="button" value="D" id="d" onclick="Checkword(this.id)">
			<input type="button" value="F" id="f" onclick="Checkword(this.id)">
			<input type="button" value="G" id="g" onclick="Checkword(this.id)">
			<input type="button" value="H" id="h" onclick="Checkword(this.id)">
			<input type="button" value="J" id="j" onclick="Checkword(this.id)">
			<input type="button" value="K" id="k" onclick="Checkword(this.id)">
			<input type="button" value="L" id="l" onclick="Checkword(this.id)">
		</td>		
	</tr>
	<tr>
		<td>
			<input type="button" value="Z" id="z" onclick="Checkword(this.id)">
			<input type="button" value="X" id="x" onclick="Checkword(this.id)">
			<input type="button" value="C" id="c" onclick="Checkword(this.id)">
			<input type="button" value="V" id="v" onclick="Checkword(this.id)">
			<input type="button" value="B" id="b" onclick="Checkword(this.id)">
			<input type="button" value="N" id="n" onclick="Checkword(this.id)">
			<input type="button" value="M" id="m" onclick="Checkword(this.id)">
            <p id ="feedback"></p>
		</td>		
	</tr>

</table>

  </body>
</html>
<script language = "javaScript">
    var storedword = msg.innerText.toLowerCase();
    var lives = 0;
    function underscore_gen() {// replaces letters with "_"'s  
        for (var i = 0; i < storedword.length; i++) {
            parWord.innerText = parWord.innerText + "_";
        }
    }
    function Checkword(letter) {
        
        var word = parWord.innerText;
        var count = 0;
        for (var i = 0; i < storedword.length; i++) {
            if (storedword[i] == letter) {
                count = count + 1; 
                word = word.substr(0, i) + letter + word.substr(i + 1);
                parWord.innerText = word;
                document.getElementById(letter).style.background = '#00ff00';
                document.getElementById(letter).disabled = true;
                CheckWin()
            }
        }
        if (count == 0) {
            lives = lives + 1;
            response("incorrect")
            document.getElementById(letter).style.background = '#ff0000';
            document.getElementById(letter).disabled = true;
            CheckGameOver()
            ChangeImage()
        }
    }
    function CheckGameOver() { // checks if user lives is less than 5 then alerts the user that the game is over 
        if (lives > 5) {
            alert("gameover word was " + storedword)
            if (userid.innerText == "") {// force a refresh if wrong
                window.location.reload(true);  
            }
            else {
                document.getElementById("btnLogon").click();
            }
        }
    }
    function CheckWin() { // if whole word user see matches the storedword it adds score on then saves.
        response("Correct")
        if (parWord.innerText == storedword) {
            alert("Correct, good job.")
            Score.innerText = storedword.length + parseInt(Score.innerText);
            document.getElementById('scorehidden').value = Score.innerText;
            if (userid.innerText == "") {
                feedback.innerText = "Login to save your scores!"
            }
            else {
                save();
            }
        }
    }
    function response(x) {
        if (x == "Correct") {            
            feedback.innerText = "Correct!";

        }
        else {
            feedback.innerText = "Incorrect!";
        }
    }

    function save() { // clicks the save button that submits the hidden score to be added back on to the DB for the user acc.
        document.getElementById("btnHighscore").click();
    }
    function ChangeImage() {// changes the image when the user gets a letter wrong.
        document.getElementById('hangman').src="image" + lives +".jpg"
    }
</script>
