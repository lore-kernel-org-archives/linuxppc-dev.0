Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3ECBFDDE34
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Dec 2006 17:01:58 +1100 (EST)
Message-ID: <458A2289.4070401@dlasys.net>
Date: Thu, 21 Dec 2006 00:58:33 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Clint Thomas <cthomas@Soneticom.com>
Subject: Re: Define Linux system memory
References: <3C02138692C13C4BB675FE7EA2409529261209@bluefin.Soneticom.local>
In-Reply-To: <3C02138692C13C4BB675FE7EA2409529261209@bluefin.Soneticom.local>
Content-Type: multipart/alternative;
	boundary="------------010900000301060409060905"
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
--------------010900000301060409060905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Clint Thomas wrote:
> To anybody who has done this before or understands how to do this, I
> was wondering if you know how to "*tell*" the kernel how much memory
> there is in the system. An example would be if I have 512MB of RAM,
> but only want the system to know that there is about 500MB in RAM, so
> that 12MB does not exist to the OS/kernel. Would this require mucking
> about in U-boot? or can I just define this in the kernel source? Thanks
>  
>  Clinton Thomas

    Most bootloaders including u-boot pass a board information structure
that includes a variety of information including the memory size.
    Also I think top of memory is also typically passed to the Linux
Kernel as a register parameter  by the boot loader.



>  
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------010900000301060409060905
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Clint Thomas wrote:
<blockquote
 cite="mid:3C02138692C13C4BB675FE7EA2409529261209@bluefin.Soneticom.local"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta content="MSHTML 6.00.5730.11" name="GENERATOR">
  <div><span class="346164916-20122006"><font face="Arial" size="2">To
anybody who has done this before or understands how to do this, I was
wondering if you know how to "<strong>tell</strong>" the kernel how
much memory there is in the system. An example would be if I have 512MB
of RAM, but only want the system to know that there is about 500MB in
RAM, so that 12MB does not exist to the OS/kernel. Would this require
mucking about in U-boot? or can I just define this in the kernel
source? Thanks</font></span></div>
  <div>&nbsp;</div>
  <div align="left"><font face="Arial" size="2">&nbsp;Clinton Thomas</font></div>
</blockquote>
<br>
&nbsp;&nbsp;&nbsp; Most bootloaders including u-boot pass a board information
structure that includes a variety of information including the memory
size.<br>
&nbsp;&nbsp;&nbsp; Also I think top of memory is also typically passed to the Linux
Kernel as a register parameter&nbsp; by the boot loader.<br>
<br>
<br>
<br>
<blockquote
 cite="mid:3C02138692C13C4BB675FE7EA2409529261209@bluefin.Soneticom.local"
 type="cite">
  <div>&nbsp;</div>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
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

--------------010900000301060409060905--
