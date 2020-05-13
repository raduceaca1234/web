<%@ page import="model.User" %>
<%@ page import="java.util.List" %><%--<%@ page import="model.User" %>&lt;%&ndash;--%>

<%
    if (request.getParameter("level") != null && request.getParameter("ini_len") != null) {
        int $level = 1;
        try {
            $level = Integer.parseInt(request.getParameter("level"));
        } catch (Exception e) {
        }
        int $ini_len = 0;
        try {
            $ini_len = Integer.parseInt(request.getParameter("ini_len"));
        } catch (Exception e) {
        }
        if ($level < 0) {
            $level = 1;
        }
        if ($level > 10) {
            $level = 10;
        }
        if ($ini_len < 1) {
            $ini_len = 1;
        }
        if ($ini_len > 20) {
            $ini_len = 20;
        }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Snake v1.0</title>
    <script type="text/javascript">
        window.onload = function(){

            // Constants
            var KEY_UP = 38;
            var KEY_LEFT = 37;
            var KEY_DOWN = 40;
            var KEY_RIGHT = 39;
            var DIR_UP = 38;
            var DIR_LEFT = 37;
            var DIR_DOWN = 40;
            var DIR_RIGHT = 39;

            var ground_width = 700;
            var ground_height = 700;

            var snake_width = 15;
            var snake_audio = new Audio("b.ogg");
            var snake_speed = 100;
            var snake_initial_length = <%= $ini_len%>;

            var game_level =  <%= $level%>;
            var speed_increment = 10;
            var game_score = 0;

            var body = document.getElementsByTagName('body')[0];
            body.style.padding = "0px";
            body.style.margin = "0px";

            var minutesLabel = document.getElementById("minutes");
            var secondsLabel = document.getElementById("seconds");
            var totalSeconds = 0;
            var refreshIntervalId = setInterval(setTime, 1000);

            function setTime(val) {
                if(val===true)
                    clearInterval(refreshIntervalId);
                else
                {++totalSeconds;
                secondsLabel.innerHTML = pad(totalSeconds % 60);
                minutesLabel.innerHTML = pad(parseInt(totalSeconds / 60));}
            }

            function pad(val) {
                var valString = val + "";
                if (valString.length < 2) {
                    return "0" + valString;
                } else {
                    return valString;
                }
            }

            var minutesS='00';
            var secondsS='00';
            var totalSeconds2 = 0;
            var refreshIntervalId2 = setInterval(setTime2, 1000);

            function setTime2(val) {
                if(val===true)
                    clearInterval(refreshIntervalId2);
                else
                {++totalSeconds2;
                    secondsS = pad2(totalSeconds2 % 60);
                    minutesS = pad2(parseInt(totalSeconds2 / 60));}
            }

            function pad2(val) {
                var valString = val + "";
                if (valString.length < 2) {
                    return "0" + valString;
                } else {
                    return valString;
                }
            }
            // Snake ground
            var snake_ground = document.createElement("div");
            snake_ground.style.background = "#000000";
            snake_ground.style.display = "block";
            snake_ground.style.width = ground_width + "px";
            snake_ground.style.height = ground_height + "px";
            snake_ground.style.margin = "0px";
            snake_ground.style.padding = "0px";
            snake_ground.style.position = "relative";
            snake_ground.style.overflow = "hidden";

            // Add snake ground
            body.appendChild(snake_ground);

            // Food block
            var food = document.createElement("div");
            var obstacles1 = document.createElement("div");
            var obstacles2 = document.createElement("div");
            var obstacles3 = document.createElement("div");

            var food_position = [0,0]
            var obstacles_positions1 = [0,0]
            var obstacles_positions2 = [0,0]
            var obstacles_positions3 = [0,0]


            var boundary = 50;
            var max1 = ground_width - boundary;
            var max2 = ground_height - boundary;
            var min1 = snake_width + boundary;
            var min2 = snake_width + boundary;

            var boundary2 = 51;
            var max11 = ground_width - boundary2;
            var max22 = ground_height - boundary2;
            var min11 = snake_width + boundary2;
            var min22 = snake_width + boundary2;
            var map_food_position = function(){
                console.log('('+min1+','+max1+') , ('+min2+', '+max2+')');
                food_position[0] = Math.floor((Math.random() * (max11 - min11) + min11)/min11) * min11;
                food_position[1] = Math.floor((Math.random() * (max22 - min22) + min22)/min22) * min22;
            }

            var map_obstacles_position = function(){
                obstacles_positions1[0] = Math.floor((Math.random() * (max1 - min1) + min1)/min1) * min1;
                obstacles_positions1[1] = Math.floor((Math.random() * (max2 - min2) + min2)/min2) * min2;
                obstacles_positions2[0] = Math.floor((Math.random() * (max1 - min1) + min1)/min1) * min1;
                obstacles_positions2[1] = Math.floor((Math.random() * (max2 - min2) + min2)/min2) * min2;
                obstacles_positions3[0] = Math.floor((Math.random() * (max1 - min1) + min1)/min1) * min1;
                obstacles_positions3[1] = Math.floor((Math.random() * (max2 - min2) + min2)/min2) * min2;

            }
            map_food_position();
            map_obstacles_position();

            food.style.background = "#FF0000";
            food.style.display = "block";
            food.style.width = snake_width + "px";
            food.style.height = snake_width + "px";
            food.style.position = "absolute";
            food.style.left = food_position[0] + "px";
            food.style.top = food_position[1] + "px";
            food.style.border = "2px solid #000000";
            obstacles1.style.background = "#939393";
            obstacles1.style.display = "block";
            obstacles1.style.width = snake_width + "px";
            obstacles1.style.height = snake_width + "px";
            obstacles1.style.position = "absolute";
            obstacles1.style.left = obstacles_positions1[0] + "px";
            obstacles1.style.top = obstacles_positions1[1] + "px";
            obstacles1.style.border = "2px solid #000000";
            obstacles2.style.background = "#939393";
            obstacles2.style.display = "block";
            obstacles2.style.width = snake_width + "px";
            obstacles2.style.height = snake_width + "px";
            obstacles2.style.position = "absolute";
            obstacles2.style.left = obstacles_positions2[0] + "px";
            obstacles2.style.top = obstacles_positions2[1] + "px";
            obstacles2.style.border = "2px solid #000000";
            obstacles3.style.background = "#939393";
            obstacles3.style.display = "block";
            obstacles3.style.width = snake_width + "px";
            obstacles3.style.height = snake_width + "px";
            obstacles3.style.position = "absolute";
            obstacles3.style.left = obstacles_positions3[0] + "px";
            obstacles3.style.top = obstacles_positions3[1] + "px";
            obstacles3.style.border = "2px solid #000000";
            // Add food block to ground
            snake_ground.appendChild(food);
            snake_ground.appendChild(obstacles1);
            snake_ground.appendChild(obstacles2);
            snake_ground.appendChild(obstacles3);

            // Game stats
            var game_stat_right = document.createElement('div');
            game_stat_right.style.display = 'block';
            game_stat_right.style.position = 'absolute';
            game_stat_right.style.right = '10px';
            game_stat_right.style.top = '10px';
            game_stat_right.style.font = 'bold 15px Monospace';
            game_stat_right.style.color = '#FFFFFF';

            var game_stat_middle = document.createElement('div');
            game_stat_middle.style.display = 'block';
            game_stat_middle.style.position = 'absolute';
            game_stat_middle.style.center = '10px';
            game_stat_middle.style.bottom = '10px';
            game_stat_middle.style.font = 'bold 15px Monospace';
            game_stat_middle.style.color = '#FFFFFF';

            var game_stat_left = document.createElement('div');
            game_stat_left.style.display = 'block';
            game_stat_left.style.position = 'absolute';
            game_stat_left.style.left = '10px';
            game_stat_left.style.top = '10px';
            game_stat_left.style.font = 'bold 15px Monospace';
            game_stat_left.style.color = '#FFFFFF';

            // Add game stats to ground
            snake_ground.appendChild(game_stat_right);
            snake_ground.appendChild(game_stat_middle);
            snake_ground.appendChild(game_stat_left);


            // Snake
            var snake = new Array();

            // Define first two blocks or elements of snake
            snake[0] = [Math.floor(ground_width/(2*snake_width)) * snake_width, Math.floor(ground_height/(2 * snake_width)) * snake_width];
            for(var i = 1; i <= snake_initial_length; i++){
                snake[i] = [snake[0][0] - i * snake_width, snake[0][1]];
            }
            // Set initial direction to right
            var snake_direction = DIR_RIGHT;
            var dir_array = [];
            dir_array.push('DIR_RIGHT')
            // Variable to track game position
            var game_over = false;

            var trigger_keydown_event =
                function(key_code){
                    // Create and dispatch an keyEvent to move snake's head towards snake_direction
                    if( window.KeyEvent ) {
                        var evObj = document.createEvent("KeyEvents");
                        evObj.initKeyEvent( "keydown", true, true, window, false, false, false, false, key_code, 0 );
                    } else {
                        var evObj = document.createEvent("UIEvents");
                        evObj.initUIEvent( "keydown", true, true, window, 1 );
                        evObj.keyCode = key_code;
                    }
                    document.dispatchEvent(evObj);
                }

            // Add nav keys for non-compatible browsers
            var button_up = document.createElement('button');
            button_up.style.position = 'absolute';
            button_up.style.display = 'block';
            button_up.style.width = '40px';
            button_up.style.height = '30px';
            button_up.innerHTML = '&uarr;';
            button_up.style.font = '15px Arial';
            button_up.style.top = (ground_height - 60) + 'px';
            button_up.style.left = (ground_width / 2 - 20) + 'px';

            var button_down = document.createElement('button');
            button_down.style.position = 'absolute';
            button_down.style.display = 'block';
            button_down.style.width = '40px';
            button_down.style.height = '30px';
            button_down.innerHTML = '&darr;';
            button_down.style.font = '15px Arial';
            button_down.style.top = (ground_height - 30) + 'px';
            button_down.style.left = (ground_width/2 - 20) + 'px';

            var button_left = document.createElement('button');
            button_left.style.position = 'absolute';
            button_left.style.display = 'block';
            button_left.style.width = '40px';
            button_left.style.height = '30px';
            button_left.innerHTML = '&larr;';
            button_left.style.font = '15px Arial';
            button_left.style.top = (ground_height - 30) + 'px';
            button_left.style.left = (ground_width / 2 - 60) + 'px';

            var button_right = document.createElement('button');
            button_right.style.position = 'absolute';
            button_right.style.display = 'block';
            button_right.style.width = '40px';
            button_right.style.height = '30px';
            button_right.innerHTML = '&rarr;';
            button_right.style.font = '15px Arial';
            button_right.style.top = (ground_height - 30) + 'px';
            button_right.style.left = (ground_width / 2 + 20) + 'px';

            // Handle button input
            button_left.onclick =
                function(){
                    trigger_keydown_event(KEY_LEFT);
                }
            button_right.onclick =
                function(){
                    trigger_keydown_event(KEY_RIGHT);
                }
            button_down.onclick =
                function(){
                    trigger_keydown_event(KEY_DOWN);
                }
            button_up.onclick =
                function(){
                    trigger_keydown_event(KEY_UP);
                }

            // Loop for as long as needed
            var game_loop =
                function(){
                    if(!game_over){
                        trigger_keydown_event(snake_direction);
                        window.setTimeout(game_loop, snake_speed - speed_increment * game_level);
                    }else{
                        setTime(true);
                        var gameover_dialog = document.createElement("div");
                        gameover_dialog.style.display = "block";
                        gameover_dialog.style.position = "absolute";
                        gameover_dialog.style.width = "200px";
                        gameover_dialog.style.height = "200px";
                        gameover_dialog.style.font = "bold 20px Arial";
                        gameover_dialog.style.color = "#FF0000";
                        gameover_dialog.style.left = (ground_width/2 - 100) + "px";
                        gameover_dialog.style.top = (ground_height/2 - 100) + "px";
                        gameover_dialog.style.textAlign = "center";
                        gameover_dialog.innerHTML = "GAME OVER!";
                        gameover_dialog_button = document.createElement("button");
                        gameover_dialog_button.style.display = "inline-block";
                        gameover_dialog_button.innerHTML = "Click To Play Again";
                        gameover_dialog_button.onclick = function(){
                            document.location.reload(false);
                        }
                        gameover_dialog.appendChild(gameover_dialog_button);
                        body.appendChild(gameover_dialog);
                        gameover_dialog_button.focus();

                        back = document.createElement("button");
                        back.style.display = "inline-block";
                        back.innerHTML = "Back to the homepage";
                        back.onclick = function(){
                            location.href='homepage.jsp'
                        }
                        gameover_dialog.appendChild(back);
                        body.appendChild(gameover_dialog);
                        back.focus();
                        for (i = 0; i < dir_array.length; i++)
                            console.log((i+1) + ": " + dir_array[i].toString());
                    }
                }

            window.setTimeout(game_loop, snake_speed);


            // Experimental: Time wrap
            document.onclick = function(e){
                snake[0][0] = e.clientX;
                snake[0][1] = e.clientY;
            }


            // Add keyDown event handler
            document.onkeydown = function(e){

                // Ignore keyDown events if game is over
                if(game_over){
                    return null;
                }

                // Prevent snake from moving in reverse direction
                if(snake_direction === DIR_UP && e.keyCode === KEY_DOWN){
                    return null;
                }

                if(snake_direction === DIR_RIGHT && e.keyCode === KEY_LEFT){
                    return null;
                }

                if(snake_direction === DIR_LEFT && e.keyCode === KEY_RIGHT){
                    return null;
                }

                if(snake_direction === DIR_DOWN && e.keyCode === KEY_UP){
                    return null;
                }

                // If one of the four navigation keys was pressed
                if(e.keyCode === KEY_UP || e.keyCode === KEY_LEFT || e.keyCode === KEY_DOWN || e.keyCode === KEY_RIGHT){

                    // Store position of last block, will be used when adding new tail block i.e. when snake's head eats food block
                    var last_x_position = snake[snake.length - 1][0];
                    var last_y_position = snake[snake.length - 1][1];

                    // Update every element to move to position of block ahead
                    for(var i = snake.length - 1; i > 0 ; i--){
                        snake[i][0] = snake[i-1][0];
                        snake[i][1] = snake[i-1][1];
                    }

                    // If UP key was pressed ( basically released )
                    if(e.keyCode === KEY_UP){
                        snake[0][1] -= snake_width;
                        snake_direction = DIR_UP;
                        dir_array.push('KEY_UP')
                        //document.writeln((dir_array.length) + ": " + dir_array[dir_array.length-1]);
                    }

                    // If LEFT key was pressed
                    if(e.keyCode === KEY_LEFT){
                        snake[0][0] -= snake_width;
                        snake_direction = DIR_LEFT;
                        dir_array.push('KEY_LEFT')
                        //document.writeln((dir_array.length) + ": " + dir_array[dir_array.length-1]);
                    }

                    // If DOWN key was pressed
                    if(e.keyCode === KEY_DOWN){
                        snake[0][1] += snake_width;
                        snake_direction = DIR_DOWN;
                        dir_array.push('KEY_DOWN')
                        //document.writeln((dir_array.length) + ": " + dir_array[dir_array.length-1]);
                    }

                    // If RIGHT key was pressed
                    if(e.keyCode === KEY_RIGHT){
                        snake[0][0] += snake_width;
                        snake_direction = DIR_RIGHT;
                        dir_array.push('KEY_RIGHT')
                        //document.writeln((dir_array.length) + ": " + dir_array[dir_array.length-1]);

                    }

                    // Wrap the snake at right egde
                    if(snake[0][0] > ground_width){
                        snake[0][0] = 0;
                    }

                    // Wrap the snake at bottom edge
                    if(snake[0][1] > ground_height){
                        snake[0][1] = 0;
                    }

                    // Wrap the snake at left edge
                    if(snake[0][0] < 0){
                        snake[0][0] = ground_width;
                    }

                    // Wrap the snake at top edge
                    if(snake[0][1] < 0){
                        snake[0][1] = ground_height;
                    }

                    for(var i = 1; i < snake.length; i++){
                        if(snake[0][0] === snake[i][0] && snake[0][1] === snake[i][1]){
                            game_over = true;
                        }
                    }


                }

                // If snake's head has approached a food block
                if(Math.abs(snake[0][0] - food_position[0]) < snake_width && Math.abs(snake[0][1] - food_position[1]) < snake_width){

                    // Add a new tail block
                    snake[snake.length] = [last_x_position, last_y_position];

                    game_score++;
                    if(game_score != 0 && game_score%10 == 0 && game_level != 10){
                        game_level++;
                    }

                    // Play the audio
                    snake_audio.play();

                    // Find and update food block's new position
                    map_food_position();
                    food.style.left = food_position[0] + 'px';
                    food.style.top = food_position[1] + 'px';
                }

                if(Math.abs(snake[0][0] - obstacles_positions1[0]) < snake_width && Math.abs(snake[0][1] - obstacles_positions1[1]) < snake_width){

                    game_over=true;
                }
                if(Math.abs(snake[0][0] - obstacles_positions2[0]) < snake_width && Math.abs(snake[0][1] - obstacles_positions2[1]) < snake_width){

                    game_over=true;
                }
                if(Math.abs(snake[0][0] - obstacles_positions3[0]) < snake_width && Math.abs(snake[0][1] - obstacles_positions3[1]) < snake_width){

                    game_over=true;
                }

                game_stat_left.innerHTML = 'Score: ' + game_score;
                game_stat_middle.innerHTML = minutesS + ":" +secondsS;
                game_stat_right.innerHTML = 'Level: ' + (game_level + 1);



                // Add or modify snake blocks on each event
                for(var i = 0; i < snake.length; i++){
                    var snake_elem = document.getElementById("snake_"+i);
                    if(snake_elem == null){
                        snake_elem = document.createElement("div");
                        snake_elem.setAttribute("id", "snake_"+i);
                        snake_elem.style.position = "absolute";
                        snake_elem.style.display = "block";
                        snake_elem.style.width = snake_width + "px";
                        snake_elem.style.height = snake_width + "px";
                        snake_elem.style.background = "#00FF00";
                        snake_elem.style.border = "2px solid #000000";
                        snake_ground.appendChild(snake_elem);
                    }
                    snake_elem.style.left = snake[i][0] + "px";
                    snake_elem.style.top = snake[i][1] + "px";
                }
            };
        }
    </script>
</head>
<body>
<label id="minutes">00</label>:<label id="seconds">00</label>
</body>
</html>
<% } else {%>
<!DOCTYPE html>
<html>
<head>
    <title>Snake v1.0</title>
</head>
<body>
<%--<%--%>
<%--    List<User> users = (ArrayList<User>)session.getAttribute("users");--%>
<%--    out.println("<table>");--%>
<%--    out.println("<thead>");--%>
<%--    out.println("<th>name</th>");--%>
<%--    out.println("<th>email</th>");--%>
<%--    out.println("<th>age</th>");--%>
<%--    out.println("<th>hometown</th>");--%>
<%--    out.println("<th>picture</th>");--%>
<%--    out.println("</thead>");--%>
<%--    out.println("<tbody>");--%>
<%--    if (users!=null)--%>
<%--        for(User user:users){--%>
<%--            out.println("<tr>");--%>
<%--            out.println("<td>" + user.getName() +"</td>");--%>
<%--            out.println("<td>" + user.getEmail() +"</td>");--%>
<%--            out.println("<td>" + user.getAge() +"</td>");--%>
<%--            out.println("<td>" + user.getHometown() +"</td>");--%>
<%--            out.println("<td><img src=\"/imgs/" + user.getPicture() + ".jpg\"></td>");--%>
<%--            out.println("</tr>");--%>
<%--        }--%>
<%--    out.println("</tbody>");--%>
<%--    out.println("</table>");--%>
<%--%>--%>
</body>
</html>
<%
    }
%>