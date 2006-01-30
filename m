Return-Path: <bennett78@digis.net>
Received: from mercury.testsyseng.com (unknown [209.120.144.205])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D513E689AE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jan 2006 07:28:27 +1100 (EST)
Message-ID: <43DE76DE.2080306@digis.net>
Date: Mon, 30 Jan 2006 13:28:14 -0700
From: bennett78 <bennett78@digis.net>
MIME-Version: 1.0
To: David Summers <embeddedxilinx@gmail.com>
Subject: Re: Getting started with Xilinx V4 PPC?
References: <e4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com>
In-Reply-To: <e4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------010605030609020704020308"
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Frank Bennett <bennett78@digis.net>
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
--------------010605030609020704020308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Summers wrote:

>I am starting a new project where I need to have a flash file system
>and an ethenet interface (HTTP and FTP).  The project is a solar
>physics experiment that will be launched on a sub-orbital rocket
>flight this fall.  The idea is that the experiment will write data
>files to the flash file system while in flight, and then I can
>download the data using ethernet after the experiment returns to
>earth.
>
>I think that Linux is the way to go for this project because of the
>JFFS2 filesystem and the strong networking support.  The only problem
>is that I am totally new to embedded linux.
>  
>
Add Das U-Boot to your list as well!

>I am prototyping my system on an Avnet FX12 development board ( Specs
>here: http://tinyurl.com/4gfdv ) which is pretty similar to the Xilinx
>ML403 board except with less memory and no SystemACE slot.
>  
>
Interesting dev board.  What is the low volume price/power consumption
is for the Virtex-4?

>I will eventually build my own custom board with the same Xilinx
>Virtex 4 FX12 FPGA and additional flash memory and some custom
>interface hardware. My background is primarily as a hardware designer,
>and I am very confortable with the FPGA part of this project.   I am
>comfortable as a Linux user, and I am a pretty good C coder (for a
>hardware guy anyway :).  I have never built a linux system (embedded
>or desktop) before, and I need some help getting started with embedded
>linux.
>  
>
The ML403 is a PPC core, JTAG/COP with Xilinx gates around it, right?  
Then what
are your plans for the rest of the SOC?  DRAM controller, local bus for 
Flash, FEC,
PHY controller internal or external, timers, GPIO, Bestcom DMA?

If you are a C coder then I assume you would use Verilog I hope....VHDL 
is for
ADA programmers!

>I have already found the following websites which have been a big help so far:
>
>http://www.klingauf.de/v2p/index.phtml
>http://splish.ee.byu.edu/projects/LinuxFPGA/configuring.htm
>http://www.crhc.uiuc.edu/IMPACT/gsrc/hardwarelab/docs/kernel-HOWTO.html#toc1
>
>I have a few questions that I hope someone can help me with:
>
>1. What is the best linux distribution to start out with?  I am
>currently working with the 2.4 kernel code from
>ppc.bkbits.net/linuxppc_2_4_devel, but I'm not sure that this version
>be being updated.  (MontaVista also seems to be making it rather
>difficult to download their free Linux Preview Kit, so I wouldn't mind
>finding another distribution)    Does the DENX distribution have good
>PPC support?  Are there any others that I should look at, or should I
>just download the kernel source directly from kernel.org?
>  
>
I am pleased with the DENX distribution todate for support of MPC5200, which
is a low power PPC based SOC. The cross-compile and userland support is
also part of this distribution.

>2. kernel 2.4 or 2.6?
>
>It is my understanding that the latest version of MTD and JFFS2 have
>dropped support for kernel 2.4.  I would like to use JFFS2 on a NAND
>flash device, so it seems like I should use 2.6.  (Can I use JFFS2 on
>a NAND device with kernel v 2.4?)
>  
>
I had some trouble with MTD/JFFS2 until a switched to the cvs version of
linuxppc_2_4_devel which added a few additional flash parts and is 
working well for me under 2.4.

I think 2.6 is still pretty much bleeding edge for embedded work, IMHO.

>Being a complete newbie, am I biting off more that I can handle by
>trying to use 2.6?
>
>I have been lurking on the mailing list for a while, and I know that
>there are several people working on 2.6.x patches for the Xilinx
>virtex 4 parts.  Could someone point me to a list of the patches that
>I need to get me started?  I think that the ML403 patches should work
>with my board, but I don't know which ones I need to download.
>
>
>Thank you for your help,
>
>David Summers
>University of Colorado
>  
>
Go RAMS!

>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  
>
Frank Bennett (aka CSUtennis)

*/Technical Contractor/*

/Triad Systems Engineering
200 West Mountain Avenue, Suite 103C
Ft. Collins, CO 80521
/http://www.traidsyseng.com <http://www.triadsyseng.com>


640K ought to be enough for anybody. 

-Microsoft Chairman Bill Gates, 1981





--------------010605030609020704020308
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
David Summers wrote:
<blockquote
 cite="mide4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com"
 type="cite">
  <pre wrap="">I am starting a new project where I need to have a flash file system
and an ethenet interface (HTTP and FTP).  The project is a solar
physics experiment that will be launched on a sub-orbital rocket
flight this fall.  The idea is that the experiment will write data
files to the flash file system while in flight, and then I can
download the data using ethernet after the experiment returns to
earth.

I think that Linux is the way to go for this project because of the
JFFS2 filesystem and the strong networking support.  The only problem
is that I am totally new to embedded linux.
  </pre>
</blockquote>
Add Das U-Boot to your list as well!<br>
<blockquote
 cite="mide4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com"
 type="cite">
  <pre wrap="">I am prototyping my system on an Avnet FX12 development board ( Specs
here: <a class="moz-txt-link-freetext" href="http://tinyurl.com/4gfdv">http://tinyurl.com/4gfdv</a> ) which is pretty similar to the Xilinx
ML403 board except with less memory and no SystemACE slot.
  </pre>
</blockquote>
Interesting dev board.&nbsp; What is the low volume price/power consumption <br>
is for the Virtex-4?<br>
<blockquote
 cite="mide4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com"
 type="cite">
  <pre wrap="">I will eventually build my own custom board with the same Xilinx
Virtex 4 FX12 FPGA and additional flash memory and some custom
interface hardware. My background is primarily as a hardware designer,
and I am very confortable with the FPGA part of this project.   I am
comfortable as a Linux user, and I am a pretty good C coder (for a
hardware guy anyway :).  I have never built a linux system (embedded
or desktop) before, and I need some help getting started with embedded
linux.
  </pre>
</blockquote>
The ML403 is a PPC core, JTAG/COP with Xilinx gates around it, right?&nbsp;
Then what <br>
are your plans for the rest of the SOC?&nbsp; DRAM controller, local bus for
Flash, FEC,<br>
PHY controller internal or external, timers, GPIO, Bestcom DMA?<br>
<br>
If you are a C coder then I assume you would use Verilog I hope....VHDL
is for<br>
ADA programmers!<br>
<blockquote
 cite="mide4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com"
 type="cite">
  <pre wrap="">I have already found the following websites which have been a big help so far:

<a class="moz-txt-link-freetext" href="http://www.klingauf.de/v2p/index.phtml">http://www.klingauf.de/v2p/index.phtml</a>
<a class="moz-txt-link-freetext" href="http://splish.ee.byu.edu/projects/LinuxFPGA/configuring.htm">http://splish.ee.byu.edu/projects/LinuxFPGA/configuring.htm</a>
<a class="moz-txt-link-freetext" href="http://www.crhc.uiuc.edu/IMPACT/gsrc/hardwarelab/docs/kernel-HOWTO.html#toc1">http://www.crhc.uiuc.edu/IMPACT/gsrc/hardwarelab/docs/kernel-HOWTO.html#toc1</a>

I have a few questions that I hope someone can help me with:

1. What is the best linux distribution to start out with?  I am
currently working with the 2.4 kernel code from
ppc.bkbits.net/linuxppc_2_4_devel, but I'm not sure that this version
be being updated.  (MontaVista also seems to be making it rather
difficult to download their free Linux Preview Kit, so I wouldn't mind
finding another distribution)    Does the DENX distribution have good
PPC support?  Are there any others that I should look at, or should I
just download the kernel source directly from kernel.org?
  </pre>
</blockquote>
I am pleased with the DENX distribution todate for support of MPC5200,
which<br>
is a low power PPC based SOC. The cross-compile and userland support is
<br>
also part of this distribution.<br>
<blockquote
 cite="mide4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com"
 type="cite">
  <pre wrap="">2. kernel 2.4 or 2.6?

It is my understanding that the latest version of MTD and JFFS2 have
dropped support for kernel 2.4.  I would like to use JFFS2 on a NAND
flash device, so it seems like I should use 2.6.  (Can I use JFFS2 on
a NAND device with kernel v 2.4?)
  </pre>
</blockquote>
I had some trouble with MTD/JFFS2 until a switched to the cvs version
of <br>
linuxppc_2_4_devel which added a few additional flash parts and is&nbsp; <br>
working well for me under 2.4.<br>
<br>
I think 2.6 is still pretty much bleeding edge for embedded work, IMHO.<br>
<blockquote
 cite="mide4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com"
 type="cite">
  <pre wrap="">
Being a complete newbie, am I biting off more that I can handle by
trying to use 2.6?

I have been lurking on the mailing list for a while, and I know that
there are several people working on 2.6.x patches for the Xilinx
virtex 4 parts.  Could someone point me to a list of the patches that
I need to get me started?  I think that the ML403 patches should work
with my board, but I don't know which ones I need to download.


Thank you for your help,

David Summers
University of Colorado
  </pre>
</blockquote>
Go RAMS!<br>
<blockquote
 cite="mide4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com"
 type="cite">
  <pre wrap="">_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>
  </pre>
</blockquote>
<span style="font-style: italic; font-weight: bold;">Frank Bennett (aka
CSUtennis)</span>
<div class="moz-signature">
<pre wrap=""><b><big><font face="Times New Roman, Times, serif"><em>Technical Contractor</em></font></big></b><span
 style="text-decoration: underline;">
</span>
<i><font face="Helvetica, Arial, sans-serif">Triad Systems Engineering
200 West Mountain Avenue, Suite 103C
Ft. Collins, CO 80521
</font></i><a href="http://www.triadsyseng.com">http://www.traidsyseng.com</a>
<span style="text-decoration: underline;"></span>

640K ought to be enough for anybody. 

-Microsoft Chairman Bill Gates, 1981


<span style="text-decoration: underline;">
</span>
</pre>
</div>
</body>
</html>

--------------010605030609020704020308--
