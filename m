Return-Path: <dhlii@dlasys.net>
Received: from rwcrmhc14.comcast.net (rwcrmhc14.comcast.net [216.148.227.154])
	by ozlabs.org (Postfix) with ESMTP id C7CD967B6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jul 2006 14:10:18 +1000 (EST)
Message-ID: <44C59875.4000309@dlasys.net>
Date: Tue, 25 Jul 2006 00:05:09 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: PHY Howto ?
References: <44BFC2EF.5020305@dlasys.net>
	<20060720220136.29326857@vitb.ru.mvista.com>
In-Reply-To: <20060720220136.29326857@vitb.ru.mvista.com>
Content-Type: multipart/alternative;
	boundary="------------070103010502070109020002"
Cc: linuxppc-embedded@ozlabs.org
Reply-To: dhlii@comcast.net
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
--------------070103010502070109020002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Vitaly Bordug wrote:
> On Thu, 20 Jul 2006 13:52:47 -0400
> "David H. Lynch Jr." <dhlii@dlasys.net> wrote:
>
>   
>>  If I am writing a network MAC driver, for hardware that has a phy
>> that is already supported, if I provide the appropriate mdio_read() and
>> mdio_write() calls to access the phy registers, and setup my config to
>> include phylib and drivers for my specific phy,  what else do I have to
>> take care of with respect to the phy within my driver ?
>> 	
>> 	Are there some resources, howto's, examples, ... demonstrating 
>> how to use phylib ?
>>     
> There is pretty good writeup in Documentation about your concern, find it at 
> Documentation/networking/phy.txt . Live example is obviously drivers/net/gianfar*
>
>
>   
    Thanks that proved useful. I am already using gianfar as a reference
- but it is not a NIC I am familiar with.
    And I still have some questions:

          What is the distinction/interaction between phylib and MII
support ?
   
          Are they independent ways of doing something similar ? Or do
they work together.

          To get MII working I need to provide/populate  an mii_if_info
structure and supply register read/write routines.
   
          Since communicating with the PHY is MAC dependent shouldn't I
need to do the same for PHYLIB ?

  
         
   
          


          As I understand it although PHY's are similar, and the same
PHY may be used on different NIC's
          Communications to the PHY typically go through the NIC.
          So my Network driver has to provide routines to read/write the
registers of the PHY, which phylib and the phy driver then use.

      

   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------070103010502070109020002
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Vitaly Bordug wrote:
<blockquote cite="mid20060720220136.29326857@vitb.ru.mvista.com"
 type="cite">
  <pre wrap="">On Thu, 20 Jul 2006 13:52:47 -0400
"David H. Lynch Jr." <a class="moz-txt-link-rfc2396E"
 href="mailto:dhlii@dlasys.net">&lt;dhlii@dlasys.net&gt;</a> wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap=""> If I am writing a network MAC driver, for hardware that has a phy
that is already supported, if I provide the appropriate mdio_read() and
mdio_write() calls to access the phy registers, and setup my config to
include phylib and drivers for my specific phy,  what else do I have to
take care of with respect to the phy within my driver ?
	
	Are there some resources, howto's, examples, ... demonstrating 
how to use phylib ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->There is pretty good writeup in Documentation about your concern, find it at 
Documentation/networking/phy.txt . Live example is obviously drivers/net/gianfar*


  </pre>
</blockquote>
<font face="Arial">&nbsp;&nbsp;&nbsp; Thanks that proved useful. I am already using
gianfar as a reference - but it is not a NIC I am familiar with.<br>
&nbsp;&nbsp;&nbsp; And I still have some questions:<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; What is the distinction/interaction between phylib and MII
support ?<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Are they independent ways of doing something similar ? Or do
they work together.<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; To get MII working I need to provide/populate&nbsp; an mii_if_info
structure and supply register read/write routines.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Since communicating with the PHY is MAC dependent shouldn't I
need to do the same for PHYLIB ?<br>
<br>
&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; As I understand it although PHY's are similar, and the same
PHY may be used on different NIC's<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Communications to the PHY typically go through the NIC.<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; So my Network driver has to provide routines to read/write
the registers of the PHY, which phylib and the phy driver then use.<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; <br>
<br>
&nbsp;&nbsp;&nbsp; <br>
<br>
</font><br>
<pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated"
 href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a
 class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
</pre>
</body>
</html>

--------------070103010502070109020002--
