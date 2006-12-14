Return-Path: <peter.ryser@xilinx.com>
Received: from outbound7-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2005967C6E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Dec 2006 06:21:26 +1100 (EST)
Received: from outbound7-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound7-blu-R.bigfish.com (Postfix) with ESMTP id 4D610215E2F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 19:21:23 +0000 (UTC)
Received: from mail108-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound7-blu.bigfish.com (Postfix) with ESMTP id 40B7516300A4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 19:21:23 +0000 (UTC)
Received: from mail108-blu (localhost.localdomain [127.0.0.1])
	by mail108-blu-R.bigfish.com (Postfix) with ESMTP id 1BDF63F0638
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 19:21:23 +0000 (UTC)
Received: from newsgate.xilinx.com (gateway4.xilinx.com [149.199.60.204])
	by mail108-blu.bigfish.com (Postfix) with ESMTP id 9BEC2A0806A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 19:21:17 +0000 (UTC)
Received: from cliff.xilinx.com (cliff [149.199.38.103])
	by newsgate.xilinx.com (8.11.6p2/8.11.6) with ESMTP id kBEJLGi04773
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 11:21:16 -0800 (PST)
Received: from xsj-exchfesmtp2.xlnx.xilinx.com (localhost [127.0.0.1])
	by cliff.xilinx.com (8.12.9/8.11.6) with ESMTP id kBEJNrwL025931
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 11:24:05 -0800 (PST)
Message-ID: <4581A3F2.3010901@xilinx.com>
Date: Thu, 14 Dec 2006 11:20:18 -0800
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: ppc <linuxppc-embedded@ozlabs.org>
Subject: Re: system ace programming xf60
References: <45a1b53e0612140805p589b5bdfpd4fb3347cdb60ded@mail.gmail.com>
In-Reply-To: <45a1b53e0612140805p589b5bdfpd4fb3347cdb60ded@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------080003050409020701090507"
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
--------------080003050409020701090507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wade,

the v4fx60 has two PPC405. Please make sure that both PPC405 are 
connected to the jtagppc_cntrl in your MHS hardware project file. You 
might want to compare your setup with the ML410 reference design 
available at 
http://www.xilinx.com/products/boards/ml410/designs/ml410_bsb_design.zip.

The JTAG IR length of the v4fx60 is 14 (6 for the FPGA + 4 for each 
PPC405, i.e. for the 4vfx60 it's 6+4+4=14)

- Peter


Wade Maxfield wrote:

> Hi,
>
>   We are trying to generate a system ace file that will program an 
> xf60 using Xilinx scripts,
> (and even their impact GUI), using 8.1i, service pack 3 EDK.
>
>   Unfortunately, if we choose the ml410 board from Xilinx's genace.tcl 
> script
> in their EDK/data/xmd directory, it errors with an invalid instruction 
> register length.
> The irlength is listed as 14 in the xilinx script files.  I looked and 
> googled and could
> not find the irlength listed for that xf60 part in any literature.
>
>   Also, if we try to include the zImage.elf file, the script errors out.
>
>   Conversely, if we choose an ml403 board (and switch the project to 
> the xf12 chip),
> we can combine the zImage.elf file and generate a system.ace file that 
> loads on an
> ml403 board.
>
>   We can take the download.bit file that refuses to load when combined 
> into the system.ace,
> and load it over the jtag port.  It programs the xf60 just fine.
>
>   If we create an empty system.ace file,  the system ace chip on our 
> board signals everything is ok,
> but of course, the xilinx chip is not programmed.  If we pull the 
> compact flash out of the board,
> the system ace chip signals that is can't find the compact flash by 
> flashing the error light.
>
>   Has anyone on this list had any experience with this that could lead 
> us in a right direction?  We've
> tried about 10 different combinations so far with no luck.
>
> thanks,
> wade
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

--------------080003050409020701090507
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Wade,<br>
<br>
the v4fx60 has two PPC405. Please make sure that both PPC405 are
connected to the jtagppc_cntrl in your MHS hardware project file. You
might want to compare your setup with the ML410 reference design
available at
<a class="moz-txt-link-freetext" href="http://www.xilinx.com/products/boards/ml410/designs/ml410_bsb_design.zip">http://www.xilinx.com/products/boards/ml410/designs/ml410_bsb_design.zip</a>.<br>
<br>
The JTAG IR length of the v4fx60 is 14 (6 for the FPGA + 4 for each
PPC405, i.e. for the 4vfx60 it's 6+4+4=14)<br>
<br>
- Peter<br>
<br>
<br>
Wade Maxfield wrote:<br>
<blockquote
 cite="mid45a1b53e0612140805p589b5bdfpd4fb3347cdb60ded@mail.gmail.com"
 type="cite">Hi,<br>
  <br>
&nbsp; We are trying to generate a system ace file that will program an xf60
using Xilinx scripts, <br>
(and even their impact GUI), using 8.1i, service pack 3 EDK.<br>
  <br>
&nbsp; Unfortunately, if we choose the ml410 board from Xilinx's genace.tcl
script <br>
in their EDK/data/xmd directory, it errors with an invalid instruction
register length.<br>
The irlength is listed as 14 in the xilinx script files.&nbsp; I looked and
googled and could<br>
not find the irlength listed for that xf60 part in any literature.
  <br>
  <br>
&nbsp; Also, if we try to include the zImage.elf file, the script errors out.<br>
  <br>
&nbsp; Conversely, if we choose an ml403 board (and switch the project to
the xf12 chip), <br>
we can combine the zImage.elf file and generate a system.ace file that
loads on an<br>
ml403 board.<br>
  <br>
&nbsp; We can take the download.bit file that refuses to load when combined
into the system.ace, <br>
and load it over the jtag port.&nbsp; It programs the xf60 just fine.<br>
  <br>
&nbsp; If we create an empty system.ace file,&nbsp; the system ace chip on our
board signals everything is ok,<br>
but of course, the xilinx chip is not programmed.&nbsp; If we pull the
compact flash out of the board,<br>
the system ace chip signals that is can't find the compact flash by
flashing the error light.
  <br>
  <br>
&nbsp; Has anyone on this list had any experience with this that could lead
us in a right direction?&nbsp; We've<br>
tried about 10 different combinations so far with no luck.<br>
  <br>
thanks,<br>
wade<br>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
</body>
</html>

--------------080003050409020701090507--
