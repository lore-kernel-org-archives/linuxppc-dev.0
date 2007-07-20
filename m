Return-Path: <bennett78@lpbroadband.net>
Received: from sgpsmtp2.avagotech.com (bastion.smtp.avagotech.com
	[202.153.6.34]) by ozlabs.org (Postfix) with ESMTP id 7A104DDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jul 2007 07:53:47 +1000 (EST)
Message-ID: <46A0EAEC.9010607@lpbroadband.net>
Date: Fri, 20 Jul 2007 11:03:40 -0600
From: Frank Bennett <bennett78@lpbroadband.net>
MIME-Version: 1.0
To: lokowich <lokowich@acdstar.com>
Subject: Re: SDRAM failures on MPC5200B
References: <46A0D76E.4030101@acdstar.com>
In-Reply-To: <46A0D76E.4030101@acdstar.com>
Content-Type: multipart/alternative;
	boundary=------------090408030606030908010805
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bennett78@lpbroadband.net
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
--------------090408030606030908010805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

lokowich wrote:
> We're working on bringing up a MPC5200B version of our original 
> MPC5200 board using U-Boot 1.1.4 configured for Icecube/Lite5200B.  
> Other than the CPU, the board is identical.  The bootloader crashes 
> just after relocation to RAM, often with a Program Check Exception, 
> typically a memory corruption issue.  I noticed failures at different 
> stages after relocation based on content, suggesting problems with 
> upper SDRAM.  If I force the initram to 1/2 the determined size (64MB 
> instead of 128MB), then everything works well through kernel load and 
> initialization.  We've added termination resistors to improve AD 
> signals, to no avail.  Memory tests work fine too.  Any help is 
> appreciated.
Review MPC5200B errata data sheets.  I found a BDI2000 + RS232 console 
port most useful for turning on a new design.  Even
the exercise of BDI commands to tftp load/verify, memory write/verify, 
debugging u-boot to run out of ram, with & w/o cache
turned on can be enlightening.

/*/Frank Bennett
President/*/

Mathegraphics,LLC
613 Bentley Pl
Fort Collins,CO 80526
www.mathegraphics.com <http://www.mathegraphics.com/>_
_

>
> Thanks,
> Mark Lokowich
> Systems Engineer
> Advanced Communication Design
> 7901 12th Ave. So.
> Bloomington, MN 55425
> 952-854-4000
> lokowich@acdstar.com
> This email was Anti Virus checked by Astaro Security Gateway. http://www.astaro.com
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


--------------090408030606030908010805
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
lokowich wrote:
<blockquote cite="mid46A0D76E.4030101@acdstar.com" type="cite">
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <font face="Verdana">We're working on bringing up a MPC5200B version
of
our original MPC5200 board using U-Boot 1.1.4 configured for
Icecube/Lite5200B.&nbsp; Other than the CPU, the board is identical.&nbsp; The
bootloader crashes just after relocation to RAM, often with a Program
Check Exception, typically a memory corruption issue.&nbsp; I noticed
failures at different stages after relocation based on content,
suggesting problems with upper SDRAM.&nbsp; If I force the initram to 1/2
the determined size (64MB instead of 128MB), then everything works well
through kernel load and initialization.&nbsp; We've added termination
resistors to improve AD signals, to no avail.&nbsp; Memory tests work fine
too.&nbsp; Any help is appreciated.<br>
  </font></blockquote>
Review MPC5200B errata data sheets.&nbsp; I found a BDI2000 + RS232 console
port most useful for turning on a new design.&nbsp; Even<br>
the exercise of BDI commands to tftp load/verify, memory write/verify,
debugging u-boot to run out of ram, with &amp; w/o cache <br>
turned on can be enlightening.<br>
<pre><em><b><i><font color="black" face="Times New Roman" size="3"><span
 style="font-weight: bold; font-size: 12pt;">Frank Bennett
President</span></font></i></b></em></pre>
<pre><font color="black" face="Courier New" size="2"><span
 style="font-size: 10pt;">Mathegraphics,LLC</span></font><font
 color="black" face="Courier New" size="2"><span
 style="font-size: 10pt;">
613 Bentley Pl</span></font><font color="black" face="Courier New"
 size="2"><span style="font-size: 10pt;">
Fort Collins</span></font>,CO 80526<font color="black"
 face="Courier New" size="2"><span style="font-size: 10pt;">
<a onclick="return top.js.OpenExtLink(window,event,this)"
 href="http://www.mathegraphics.com/" target="_blank">www.mathegraphics.com</a></span></font><u><font
 color="black" face="Courier New" size="2"><span
 style="font-size: 10pt;">
</span></font></u></pre>
<blockquote cite="mid46A0D76E.4030101@acdstar.com" type="cite"><font
 face="Verdana"><br>
Thanks,<br>
Mark Lokowich<br>
Systems Engineer<br>
Advanced Communication Design<br>
7901 12th Ave. So.<br>
Bloomington, MN 55425<br>
952-854-4000<br>
  <a class="moz-txt-link-abbreviated" href="mailto:lokowich@acdstar.com">lokowich@acdstar.com</a><br>
  </font>
  <pre>This email was Anti Virus checked by Astaro Security Gateway. <a class="moz-txt-link-freetext" href="http://www.astaro.com">http://www.astaro.com</a></pre>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<br>
</body>
</html>

--------------090408030606030908010805--
