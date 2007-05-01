Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57096DE004
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 14:56:34 +1000 (EST)
Message-ID: <4636C829.4040907@dlasys.net>
Date: Tue, 01 May 2007 00:55:05 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: rvk <rvkisley@yahoo.com>
Subject: Re: ram not at 0? anyone?
References: <10255622.post@talk.nabble.com>
In-Reply-To: <10255622.post@talk.nabble.com>
Content-Type: multipart/alternative;
	boundary="------------040407010104050807010604"
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
--------------040407010104050807010604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

rvk wrote:
> I've learned a little more, looking at PPC_MEMSTART from
> include/asm-ppc/page.h, and it seems there is some relevant infra.  However
> I'm still worried about the tophys() and tovirt() implementations used by
> head_4xx.S. Can anyone comment who has experience with RAM not at physical
> 0? I don't have the board yet, but it will be Xilinx Virtex 4 ppc405.
>   
    You might want to try posting to the uClinux list.
    Boards running uClinux are much more likely to have odd memory
configurations.

    I am fairly certain that you can get a board running with base
memory elsewhere than 0.
    But I also suspect it will add substantially to your time.

    My hardware engineers told me that memory at 0 was going to be
impossible,
    until I told them it make take 2-3 more months to get Linux running.
    Miraculously I got new firmware with memory at 0 the next day.

    The PPC405 is part of the V4 FPGA, regardless of the rest of the
board design,
    what the ppc sees is almost certainly controlled by the FPGA.
    After you get your board working with an odd memory map, then you
will have to maintain it.
    Your board will become the test case for flexible memory handling
for future Linux development.
    That means future grief for you.




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------040407010104050807010604
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
rvk wrote:
<blockquote cite="mid10255622.post@talk.nabble.com" type="cite">
  <pre wrap="">I've learned a little more, looking at PPC_MEMSTART from
include/asm-ppc/page.h, and it seems there is some relevant infra.  However
I'm still worried about the tophys() and tovirt() implementations used by
head_4xx.S. Can anyone comment who has experience with RAM not at physical
0? I don't have the board yet, but it will be Xilinx Virtex 4 ppc405.
  </pre>
</blockquote>
<font face="Arial">&nbsp;&nbsp;&nbsp; You might want to try posting to the uClinux
list.<br>
&nbsp;&nbsp;&nbsp; Boards running uClinux are much more likely to have odd memory
configurations.<br>
<br>
&nbsp;&nbsp;&nbsp; I am fairly certain that you can get a board running with base
memory elsewhere than 0.<br>
&nbsp;&nbsp;&nbsp; But I also suspect it will add substantially to your time.<br>
<br>
&nbsp;&nbsp;&nbsp; My hardware engineers told me that memory at 0 was going to be
impossible, <br>
&nbsp;&nbsp;&nbsp; until I told them it make take 2-3 more months to get Linux running.<br>
&nbsp;&nbsp;&nbsp; Miraculously I got new firmware with memory at 0 the next day.<br>
<br>
&nbsp;&nbsp;&nbsp; The PPC405 is part of the V4 FPGA, regardless of the rest of the
board design, <br>
&nbsp;&nbsp;&nbsp; what the ppc sees is almost certainly controlled by the FPGA.<br>
&nbsp;&nbsp;&nbsp; After you get your board working with an odd memory map, then you
will have to maintain it.<br>
&nbsp;&nbsp;&nbsp; Your board will become the test case for flexible memory handling
for future Linux development.<br>
&nbsp;&nbsp;&nbsp; That means future grief for you.<br>
<br>
<br>
<br>
</font><br>
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

--------------040407010104050807010604--
