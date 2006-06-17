Return-Path: <bennett78@digis.net>
Received: from ORML003.digis.net (orml003.digis.net [208.187.239.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 427BC67B2C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Jun 2006 05:24:20 +1000 (EST)
Message-ID: <44944F9B.8060007@digis.net>
Date: Sat, 17 Jun 2006 12:53:15 -0600
From: Frank Bennett <bennett78@digis.net>
MIME-Version: 1.0
To: Trueskew <trueskew@gmail.com>
Subject: Re: Using bestcomm in an external module (MPC5200B to be exact)
References: <4493894e.6d57ffd8.019a.ffff95b9@mx.gmail.com>
In-Reply-To: <4493894e.6d57ffd8.019a.ffff95b9@mx.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------000104020001080704060208"
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bennett78@digis.net
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
--------------000104020001080704060208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Trueskew wrote:

> I'm writing a driver for a TI codec attached to the MPC5200B PSC3 
> codec lines on a Lite5200b.  It's an external module, and I'd like to 
> use Bestcomm with it.  I've already tried a bunch of horrible things 
> to get it to work.  I could say it's close, but by close I mean the 
> FEC still runs, my stuff doesn't. 
>  
> 1. Can the Bestcomm I/F be used by an external module, or is the 
> module required to be built in if built-in drivers use Bestcomm?  
> TasksInitAPI (no so bad) and TasksLoadImage (yeah, bad) aren't really 
> supposed to be called more than once from what I've read, and the 
> kernel loads them for ethernet and ATA (no disk in my system if that 
> matters). 
>  
> 2. If it can be used by an external module, how would I do it?  I've 
> tried compiling the source into my module and replicating the 
> initialization the kernel does in addition to my own stuff.  It's not 
> too bad, though I don't get any interrupts yet.
>  
> The LTIB from Freescale includes AIC23 and AC97 drivers that use 
> Bestcomm.  I built my kernel with them set as modules, and they had 
> the same unresolved problems that my driver has on insmod, so I'm 
> pessimistic.  If someone could put me out of my misery one way or 
> another, I'd appreciate it.

Might check out the driver posted by Bob Petersen:
    http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.html
using DENX linuxppc_2_4_devel/arch/ppc/5xxx_io/  i2s.c, psc.c and Bestcomm/

Frank

>  
> Thanks.
> Sal
>  
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
*/Frank Bennett
President/*

Mathegraphics,LLC
613 Bentley Pl
Fort Collins,CO 80526
970-229-9269 (hm) 970-402-9269 (cell)
www.mathegraphics.com <http://www.mathegraphics.com>
bennett78@digis.net <mailto:bennett78@digis.net>


--------------000104020001080704060208
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Trueskew wrote:
<blockquote cite="mid4493894e.6d57ffd8.019a.ffff95b9@mx.gmail.com"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta content="MSHTML 6.00.2900.2873" name="GENERATOR">
  <div><span class="012192304-17062006"><font face="Arial" size="2">I'm
writing a driver for a TI codec attached to the MPC5200B PSC3 codec
lines on a Lite5200b.&nbsp; It's an external module, and I'd like to use
Bestcomm with it.&nbsp; I've already tried a bunch of horrible things to get
it to work.&nbsp; I could say it's close, but by close I mean the FEC still
runs, my stuff doesn't.&nbsp; </font></span></div>
  <div><span class="012192304-17062006"><font face="Arial" size="2"><span
 class="012192304-17062006"></span></font></span><span
 class="012192304-17062006"><font face="Arial" size="2"><span
 class="012192304-17062006"></span>&nbsp;</font></span></div>
  <div><span class="012192304-17062006"><font face="Arial" size="2">1.
Can the Bestcomm I/F be used by an external module, or&nbsp;is the module
required to be built in if built-in drivers use Bestcomm?&nbsp; TasksInitAPI
(no so bad) and TasksLoadImage (yeah, bad) aren't really supposed to be
called more than once from what I've read, and the kernel loads them
for ethernet and ATA (no disk in my system if that matters).&nbsp; </font></span></div>
  <div><span class="012192304-17062006"></span>&nbsp;</div>
  <div><span class="012192304-17062006"><font face="Arial" size="2">2.
If it can be used by an external module, how would I do it?&nbsp; I've tried
compiling the source into my module and replicating the initialization
the kernel does in addition to my own stuff.&nbsp; It's not too bad, though
I don't get any interrupts yet.</font></span></div>
  <div><span class="012192304-17062006"></span>&nbsp;</div>
  <div><span class="012192304-17062006"><font face="Arial" size="2"><span
 class="012192304-17062006"><font face="Arial" size="2"><span
 class="012192304-17062006"><font face="Arial" size="2">The LTIB from
Freescale includes AIC23 and AC97 drivers that use Bestcomm.&nbsp; </font></span></font></span>I
built my kernel with them set as modules, and they had the same
unresolved problems that my driver has on insmod, so I'm pessimistic.&nbsp;
If someone could put me out of my misery one way or another, I'd
appreciate it.</font></span></div>
</blockquote>
Might check out the driver posted by Bob Petersen:<br>
&nbsp;&nbsp;&nbsp; <a
 href="http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.html">http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.html</a><br>
using DENX linuxppc_2_4_devel/arch/ppc/5xxx_io/&nbsp; i2s.c, psc.c and
Bestcomm/<br>
<br>
Frank<br>
<blockquote cite="mid4493894e.6d57ffd8.019a.ffff95b9@mx.gmail.com"
 type="cite">
  <div><span class="012192304-17062006"></span>&nbsp;</div>
  <div><span class="012192304-17062006"><font face="Arial" size="2">Thanks.</font></span></div>
  <div><span class="012192304-17062006"><font face="Arial" size="2">Sal</font></span></div>
  <div><span class="012192304-17062006"></span>&nbsp;</div>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<div class="moz-signature">
<title>sign</title>
<meta content="Frank Bennett" name="author">
<pre wrap=""><b><big><font face="Times New Roman, Times, serif"><em>Frank Bennett
President</em></font></big></b>

Mathegraphics,LLC
613 Bentley Pl
Fort Collins,CO 80526
970-229-9269 (hm) 970-402-9269 (cell)
<a href="http://www.mathegraphics.com">www.mathegraphics.com</a>
<span style="text-decoration: underline;"><a
 href="mailto:bennett78@digis.net">bennett78@digis.net</a>
</span></pre>
</div>
</body>
</html>

--------------000104020001080704060208--
