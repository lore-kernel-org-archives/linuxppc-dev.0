Return-Path: <bsilverman@conceptxdesign.com>
Received: from smtprelay.hostedemail.com (smtprelay0054.hostedemail.com
	[216.40.44.54]) by ozlabs.org (Postfix) with ESMTP id 84D9EDDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 09:11:17 +1100 (EST)
Message-ID: <47C882F6.9050905@conceptxdesign.com>
Date: Fri, 29 Feb 2008 17:11:02 -0500
From: Brian Silverman <bsilverman@conceptxdesign.com>
MIME-Version: 1.0
To: Phil Hochstetler <Phil.Hochstetler@serveron.com>
Subject: Re: ML403 Linux port questions
References: <ADA5878BA63680469C75C14CEEE2FE28012F482B@mail.serveron.com>
In-Reply-To: <ADA5878BA63680469C75C14CEEE2FE28012F482B@mail.serveron.com>
Content-Type: multipart/alternative;
	boundary="------------060002080002090304060304"
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
--------------060002080002090304060304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am currently building under cygwin for the Virtex-4.  Yes, it's likely 
more of a pain, but its doable.  But any way you slice it, its not 
instantaneous to get a build environment up and running.

Anyway, here's what I'm using right now:

crosstool 0.42 (gcc3.4.1, glibc2.3.3) (possibly patched)
Linux 2.6.24-rc8-xlnx (git.xilinx.com)
    - with patch for building under cygwin: 
http://lkml.org/lkml/2007/2/22/421
    - A missing elf.h file, not in my cygwin distribution.

Also a pain with cygwin is the NFS server - I had difficulty getting it 
to work with more recent cygwin install, and have been unable to 
downgrade it.  Finally, with no loopback device in cygwin, if you want 
to create initrd's, you have to do this on a Linux box.  But this is now 
less of an issue in 2.6 with initramfs.

-bri


Phil Hochstetler wrote:
>
> I'm setting up a new development environment to get a working port of 
> Linux on the Xilinx Virtex-4 chip  (I have a Xilinx ML403 board).  I'm 
> looking for the quickest way to get a working development environment 
> for the 2.6 kernel without paying thousands of $$ (what happened to 
> MontaVista?).  My first attempt was to use google and found lots of 
> resources.  The problem is that much of the info is dated or makes 
> assumptions about your environment.  I read Grants write-up at 
> http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex.  Because I 
> want to use Windows XP SP2 as the host if possible, I went down the 
> path of installing the current Cygwin and was able to create cross 
> tools (gcc 4.1) successfully.  The problem I am having is that the 
> Linux build process requires a newer gcc than 3.4.4-3 which is what 
> Cygwin provides.  I have used the EDK to build a bsp package 
> successfully so that is not a problem.  I tried to compile the 
> 2.6.24.2 mainline kernel but it fails to compile using the Cygwin 
> tools (it never gets as far as using them).
>
>  
>
> I guess what I am looking for is advise on the lowest risk, easiest to 
> set up environment to setup that will just work.  Also advise on which 
> kernel to use.   I don't need a detailed tutorial but a high level 
> direct that is known to work.  I am thinking of using either the 
> secret lab tree or the Xilinx tree as recommended in Grants wiki 
> page.  Should I just forget using XP and install a Linux (x86 
> processor so I must use cross tools)?   If so, what is the recommend 
> distro and what version?
>
>  
>
> Thanks for all your sharing of experience.  I hope to contribute back 
> as soon as I can.
>
>  
>
> --phil
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Brian Silverman
Concept X, LLC


--------------060002080002090304060304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
I am currently building under cygwin for the Virtex-4.&nbsp; Yes, it's
likely more of a pain, but its doable.&nbsp; But any way you slice it, its
not instantaneous to get a build environment up and running.<br>
<br>
Anyway, here's what I'm using right now:<br>
<br>
crosstool 0.42 (gcc3.4.1, glibc2.3.3) (possibly patched)<br>
Linux 2.6.24-rc8-xlnx (git.xilinx.com)<br>
&nbsp;&nbsp;&nbsp; - with patch for building under cygwin:
<a class="moz-txt-link-freetext" href="http://lkml.org/lkml/2007/2/22/421">http://lkml.org/lkml/2007/2/22/421</a><br>
&nbsp;&nbsp;&nbsp; - A missing elf.h file, not in my cygwin distribution.<br>
<br>
Also a pain with cygwin is the NFS server - I had difficulty getting it
to work with more recent cygwin install, and have been unable to
downgrade it.&nbsp; Finally, with no loopback device in cygwin, if you want
to create initrd's, you have to do this on a Linux box.&nbsp; But this is
now less of an issue in 2.6 with initramfs.<br>
<br>
-bri<br>
<br>
<br>
Phil Hochstetler wrote:
<blockquote
 cite="mid:ADA5878BA63680469C75C14CEEE2FE28012F482B@mail.serveron.com"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta name="Generator" content="Microsoft Word 12 (filtered medium)">
  <style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
..MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
  </style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1" />
 </o:shapelayout></xml><![endif]-->
  <div class="Section1">
  <p class="MsoNormal">I&#8217;m setting up a new development environment to
get a
working port of Linux on the Xilinx Virtex-4 chip&nbsp; (I have a Xilinx
ML403
board).&nbsp; I&#8217;m looking for the quickest way to get a working
development environment for the 2.6 kernel without paying thousands of
$$ (what
happened to MontaVista?).&nbsp; My first attempt was to use google and found
lots of resources.&nbsp; The problem is that much of the info is dated or
makes
assumptions about your environment.&nbsp; I read Grants write-up at <a
 moz-do-not-send="true"
 href="http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex">http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex</a>.&nbsp;
Because I want to use Windows XP SP2 as the host if possible, I went
down the
path of installing the current Cygwin and was able to create cross
tools (gcc
4.1) successfully.&nbsp; The problem I am having is that the Linux build
process requires a newer gcc than 3.4.4-3 which is what Cygwin
provides.&nbsp;
I have used the EDK to build a bsp package successfully so that is not
a
problem.&nbsp; I tried to compile the 2.6.24.2 mainline kernel but it fails
to
compile using the Cygwin tools (it never gets as far as using them).<o:p></o:p></p>
  <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
  <p class="MsoNormal">I guess what I am looking for is advise on the
lowest risk,
easiest to set up environment to setup that will just work.&nbsp; Also
advise
on which kernel to use.&nbsp;&nbsp; I don&#8217;t need a detailed tutorial but
a high level direct that is known to work.&nbsp; I am thinking of using
either
the secret lab tree or the Xilinx tree as recommended in Grants wiki
page.&nbsp; Should I just forget using XP and install a Linux (x86 processor
so
I must use cross tools)?&nbsp;&nbsp; If so, what is the recommend distro and
what version?<o:p></o:p></p>
  <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
  <p class="MsoNormal">Thanks for all your sharing of experience.&nbsp; I
hope to
contribute back as soon as I can.<o:p></o:p></p>
  <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
  <p class="MsoNormal">--phil<o:p></o:p></p>
  </div>
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
Brian Silverman
Concept X, LLC
</pre>
</body>
</html>

--------------060002080002090304060304--
