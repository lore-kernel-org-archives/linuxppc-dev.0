Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DE5A67B7A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 09:05:22 +1000 (EST)
Message-ID: <4509DF7A.2020009@dlasys.net>
Date: Thu, 14 Sep 2006 19:02:18 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Michael Galassi <mgalassi@c-cor.com>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
References: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
	<002501c6d79e$cca7ee40$800101df@monstertop>
	<528646bc0609131852s41a8bc4ev44b84d68f51b1d2d@mail.gmail.com>
	<45093A94.2080407@dlasys.net>
	<200609141353.k8EDrkPN065101@penguin.ncube.com>
In-Reply-To: <200609141353.k8EDrkPN065101@penguin.ncube.com>
Content-Type: multipart/alternative;
	boundary="------------090805070606010300080908"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090805070606010300080908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael Galassi wrote:
>
> It is also worth noting that as released in MVL pro 4.0.1 it only
> supports hard_temac 1.00.a and plb_temac 2.00.a, both of which are
> tagged as deprecated in the current version (8.2.01i) of Xilinx's
> EDK. The current version of {plb,hard}_temac (3.00.a) goes to great
> lengths to break compatibility with older versions.  This will
> presumably be fixed next month when it is rumored that wonderful new
> things will come from Xilinx.  In the mean-time it is possible, though
> neither simple, nor fun, to create Virtex4 designs with the older IP.
>   
    Fortunately, I have little to do with the firmware.
    Unfortunately, after the firmware is in the product, I am the guy 
who has to make the drivers work.

    I am also not straight - though I am somewhat clearer, on exactly 
what any given flavor of TEMAC is.

    As best as I can tell, the V4 FX chipsets contain some dedicated 
hardware that forms the basis for the TEMAC.
    (or possibly several TEMAC's depending on how it is built).
   
    Separately Xilinx provides a plethora of wrapper logic, that allows 
you to implement  a slew of different incarnations.
    All similar yet different at the same time. Ranging from the Local 
Link TEMAC which is the simplest to the
    PLB SG DMA driven TEMAC which is probably the most complex.

    Then there is an assortment of PDF's from Xilinx, none of which 
quite match whatever you might have.

    And at the risk of Goring somebodies Ox, the MV/EDK based drivers 
may/may not have the attribute of
    being portable accross multiple OS's, but they seem to pretty much 
deliberately violate almost every style
    quideline for Linux drivers. Linux is written in C, not preprocessor 
Macros.

    For anyone at MV I have ticked off - Sorry, I am sure it is 
brilliantly written preprocessor Macros.
   
   
   




> -michael
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------090805070606010300080908
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Michael Galassi wrote:
<blockquote cite="mid200609141353.k8EDrkPN065101@penguin.ncube.com"
 type="cite">
  <pre wrap=""><!---->
It is also worth noting that as released in MVL pro 4.0.1 it only
supports hard_temac 1.00.a and plb_temac 2.00.a, both of which are
tagged as deprecated in the current version (8.2.01i) of Xilinx's
EDK. The current version of {plb,hard}_temac (3.00.a) goes to great
lengths to break compatibility with older versions.  This will
presumably be fixed next month when it is rumored that wonderful new
things will come from Xilinx.  In the mean-time it is possible, though
neither simple, nor fun, to create Virtex4 designs with the older IP.
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; Fortunately, I have little to do with the firmware. <br>
&nbsp;&nbsp;&nbsp; Unfortunately, after the firmware is in the product, I am the guy
who has to make the drivers work.<br>
<br>
&nbsp;&nbsp;&nbsp; I am also not straight - though I am somewhat clearer, on exactly
what any given flavor of TEMAC is.<br>
<br>
&nbsp;&nbsp;&nbsp; As best as I can tell, the V4 FX chipsets contain some dedicated
hardware that forms the basis for the TEMAC.<br>
&nbsp;&nbsp;&nbsp; (or possibly several TEMAC's depending on how it is built).<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; Separately Xilinx provides a plethora of wrapper logic, that allows
you to implement&nbsp; a slew of different incarnations.<br>
&nbsp;&nbsp;&nbsp; All similar yet different at the same time. Ranging from the Local
Link TEMAC which is the simplest to the <br>
&nbsp;&nbsp;&nbsp; PLB SG DMA driven TEMAC which is probably the most complex.<br>
<br>
&nbsp;&nbsp;&nbsp; Then there is an assortment of PDF's from Xilinx, none of which
quite match whatever you might have.<br>
<br>
&nbsp;&nbsp;&nbsp; And at the risk of Goring somebodies Ox, the MV/EDK based drivers
may/may not have the attribute of <br>
&nbsp;&nbsp;&nbsp; being portable accross multiple OS's, but they seem to pretty much
deliberately violate almost every style <br>
&nbsp;&nbsp;&nbsp; quideline for Linux drivers. Linux is written in C, not
preprocessor Macros.<br>
<br>
&nbsp;&nbsp;&nbsp; For anyone at MV I have ticked off - Sorry, I am sure it is
brilliantly written preprocessor Macros.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; <br>
<br>
<br>
<br>
<br>
<blockquote cite="mid200609141353.k8EDrkPN065101@penguin.ncube.com"
 type="cite">
  <pre wrap="">
-michael
  </pre>
</blockquote>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated" href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
</pre>
</body>
</html>

--------------090805070606010300080908--
