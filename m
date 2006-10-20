Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABBAC679E9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 16:15:31 +1000 (EST)
Message-ID: <45386964.8040809@dlasys.net>
Date: Fri, 20 Oct 2006 02:15:00 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Sharon Feldman <sharonf@scopus.net>
Subject: Re: Looking For XILINX TEMAC Driver For linux 2.4 or 2.6
References: <8506C3905ED0764F889ADEB33E3A9E8062CECA@MAIA.scopus.net>
In-Reply-To: <8506C3905ED0764F889ADEB33E3A9E8062CECA@MAIA.scopus.net>
Content-Type: multipart/alternative;
	boundary="------------060701000204070909000204"
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
--------------060701000204070909000204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sharon Feldman wrote:
>
> I Need XILINX ll_temac Or PLB_Temac Drivers For Linux 2.4 Or 2.6
>
> I Understand There Is A Driver For MV That Can Be Used.
>
> Best Regards/
>

    there is more than one implimentation of the ll_temac
    as well as m ore than one of the plb_temac.
    I have a combined 2.6 driver that I am working on.
       It works (or it did last time I tried it) for the ll_temac 
without the DMA engine.
       no interrupts, slow with a fairly high rate of dropped packets.
       The plb_temac portion is only for Fifo based plb_temacs, and is 
close but not quite working yet.
    It supports MII and autonegotiation (the last incarnation of the 
Xilinx MV driver I save posted did not.)
    I have used the Xilinx MV 2.6 driver - you can find links to it in 
the ML archives, seems to work well enough
    but is one speed - I forget which one. It is fairly simple to change 
the code to a different speed, but it does not support autonegotiation 
or MII.

    There is a monsterous patch to the linux-2.6 git tree at  
http://web.dlasys.net:8888/clients/pico/pico.patch that is for the Pico 
E12/E14 boards.
    Aside from the board support it includes My temac driver, The Xilinx 
MV edk driver, my Uartlite driver, Peter Korsgaard's Uartlite driver
    as well as in progress support for assorted other facets of the Pico 
E12/E14.

    You should be able to apply it to a 2.6.18 source tree, and have 
support for some additional Xilinx hardware for your board - BUT, most 
of the drivers
    require additional data in you board support code.

   
 

-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------060701000204070909000204
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Sharon Feldman wrote:
<blockquote
 cite="mid:8506C3905ED0764F889ADEB33E3A9E8062CECA@MAIA.scopus.net"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta name="Generator" content="MS Exchange Server version 6.5.7226.0">
  <title>Looking For XILINX TEMAC Driver For linux 2.4 or 2.6 </title>
<!-- Converted from text/rtf format -->
  <p dir="ltr"><font face="Arial" size="2">I Need XILINX ll_temac Or
PLB_Temac Drivers For Linux 2.4 Or 2.6</font></p>
  <p dir="ltr"><font face="Arial" size="2">I Understand There Is A
Driver For MV That Can Be Used.</font></p>
  <p dir="ltr"><font face="Arial" size="2">Best Regards/</font></p>
</blockquote>
<br>
&nbsp;&nbsp;&nbsp; there is more than one implimentation of the ll_temac<br>
&nbsp;&nbsp;&nbsp; as well as m ore than one of the plb_temac.<br>
&nbsp;&nbsp;&nbsp; I have a combined 2.6 driver that I am working on.<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; It works (or it did last time I tried it) for the ll_temac
without the DMA engine.<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; no interrupts, slow with a fairly high rate of dropped packets.<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; The plb_temac portion is only for Fifo based plb_temacs, and is
close but not quite working yet.<br>
&nbsp;&nbsp;&nbsp; It supports MII and autonegotiation (the last incarnation of the
Xilinx MV driver I save posted did not.)<br>
&nbsp;&nbsp;&nbsp; I have used the Xilinx MV 2.6 driver - you can find links to it in
the ML archives, seems to work well enough<br>
&nbsp;&nbsp;&nbsp; but is one speed - I forget which one. It is fairly simple to
change the code to a different speed, but it does not support
autonegotiation or MII.<br>
<br>
&nbsp;&nbsp;&nbsp; There is a monsterous patch to the linux-2.6 git tree at&nbsp;
<a class="moz-txt-link-freetext" href="http://web.dlasys.net:8888/clients/pico/pico.patch">http://web.dlasys.net:8888/clients/pico/pico.patch</a> that is for the Pico
E12/E14 boards.<br>
&nbsp;&nbsp;&nbsp; Aside from the board support it includes My temac driver, The
Xilinx MV edk driver, my Uartlite driver, Peter Korsgaard's Uartlite
driver <br>
&nbsp;&nbsp;&nbsp; as well as in progress support for assorted other facets of the
Pico E12/E14.<br>
<br>
&nbsp;&nbsp;&nbsp; You should be able to apply it to a 2.6.18 source tree, and have
support for some additional Xilinx hardware for your board - BUT, most
of the drivers<br>
&nbsp;&nbsp;&nbsp; require additional data in you board support code.<br>
<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;<br>
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

--------------060701000204070909000204--
