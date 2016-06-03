<?php
	$cloud = 'AWS';

	if (strpos($_ENV['HOST'], 'metapod')) {
		$cloud = 'Metapod';
	}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
  <title>Miggins <?=$cloud?> Container Website</title>
  <meta name="description" content="free website template" />
  <meta name="keywords" content="enter your keywords here" />
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=9" />
  <link rel="stylesheet" type="text/css" href="style.css" />
  <script type="text/javascript" src="jquery.min.js"></script>
</head>

<body>
  <div id="main">
    <div id="header">
	  <div id="banner">
	    <div id="welcome">
	      <h1>Miggins.net</h1>
	    </div><!--close welcome-->
	    <div id="menubar">
          <ul id="menu">
            <li class="current"><a href="index.html"  >Home</a></li>
            <li><a href="time"  >Latest News</a></li>
            <li><a href="christmas"  >Seasonal</a></li>
        <li><a href="http://mantl.io"  >Cisco MANTL</a></li>

          </ul>
        </div><!--close menubar-->	  
	  </div><!--close banner-->	
    </div><!--close header-->	
    
	<div id="site_content">		

      <div class="slideshow">  
      <ul class="slideshow">
          <li class="show"><img width="900" height="350" src="banner-1.jpg" alt="M.E.C. :: Miggins Employee Connection" /></li>
      </ul>
      </div><!--close slideshow-->		
	 
	  <div id="content">
<!--        <div class="content_item">
		  <h1>Miggins Container Test Page</h1>
		  <p style="font-size: 1.2em;">Cloud: <?=$cloud?><br />Container ID: <?=$_ENV['HOSTNAME']?></p>-->
<!--		 <?php print_r($_ENV); print_r($_REQUEST); print_r($_SERVER); ?>-->
      </div><!--close content-->   
	  
	  <div class="container">
	    <div class="ourwork">
	      <h3 style="color: red">Piealicious</h3>
		  <p><img style="float: right; padding-left: 1em;"src="piealicious.png" />
		  <p>Preview the latest app.</p>
		  <p>Please share your thoughts (every comment will get a free pie).</p>
		  <div class="more">
		    <a style="color: red"   href="http://private.ukidcv.local/confidential.html">Piealicious</a>
		  </div><!--close more-->      
	    </div><!--close ourwork-->
	    <div class="projects">
	      <h3>Running on <?=$cloud?> (ID: <?=$_ENV['HOSTNAME']?>)</h3>
		  <p><img style="float: right; padding-left: 1em; width: 50%;"src="logo.png" />
		  Powered by Cisco MANTL<br />A batteries included end to end solution for your microservices infrastructure.
		  <div class="more">
		    <a   href="http://mantl.io/">Read more</a>
		  </div><!--close more-->        
	    </div><!--close projects-->

	    <div class="testimonials">
	      <h3>As Featured in Time</h3>
		  <p><img style="float: right; padding-left: 1em;"src="time.jpg" />
		  Our CEO was featured in Time Magazine this month, read what he had to say in this thrilling insight in to the world of big-pie</p>
		  <div class="more">
		    <a   href="time">Read more</a>
		  </div><!--close more-->        
	    </div><!--close testimonials-->	  
	  </div><!--close container-->
	
	</div><!--close site_content--> 

  </div><!--close main-->
  
  <div id="footer_container">
    <div id="footer">
	  <a href="http://validator.w3.org/check?uri=referer">Valid XHTML</a> | <a href="http://fotogrph.com/">Images</a> | Heart Internet <a href="http://www.heartinternet.co.uk/web-hosting/">web hosting</a> | website template by <a href="http://www.araynordesign.co.uk">ARaynorDesign</a>
    </div><!--close footer-->  
  </div><!--close footer_container-->  
  
</body>
</html>
