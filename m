Return-Path: <bsilverman@conceptxdesign.com>
Received: from smtprelay.hostedemail.com (smtprelay0247.hostedemail.com
	[216.40.44.247]) by ozlabs.org (Postfix) with ESMTP id 14828DE389
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Apr 2008 02:13:04 +1000 (EST)
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtprelay03.hostedemail.com (Postfix) with SMTP id 7A537D162A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 16:12:59 +0000 (UTC)
Received: from [192.168.1.38] (pool-71-248-32-176.bltmmd.east.verizon.net
	[71.248.32.176])
	(Authenticated sender: bsilverman@conceptxdesign.com)
	by omf03.hostedemail.com (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 16:12:59 +0000 (UTC)
Message-ID: <4810B196.7000300@conceptxdesign.com>
Date: Thu, 24 Apr 2008 12:13:10 -0400
From: Brian Silverman <bsilverman@conceptxdesign.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: EABI
Content-Type: multipart/alternative;
	boundary="------------080703000800080806020709"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080703000800080806020709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Is it possible to compile a Linux application using an EABI compiler 
(specfically, Xilinx's EDK powerpc-eabi-gcc.exe)?
 
The issue at hand is that we'd like for our customers to be able to use 
the Xilinx EDK toolchain (which we know they will have) to compile Linx 
apps without having to install another toolchain (crosstool, ELDK, etc).
 
So, what I'm hoping is that the EDK toolchain can be configured to be 
Linux compatible binaries, or that there is some kind of wrapper that 
will handle the incompatible interfaces.  Searching around, I've seen 
some mention of Linux EABI compatibility (for Debian ARM releases), but 
I haven't found any clear concensus...

P.S. My apologies if this message appears on the mailing list twice...

-- 
Brian Silverman
Concept X, LLC


--------------080703000800080806020709
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<div><span class="768110114-24042008"><font face="Arial" size="2">Is it
possible to compile a Linux application using an EABI compiler
(specfically, Xilinx's EDK powerpc-eabi-gcc.exe)?</font></span></div>
<div><span class="768110114-24042008"></span>&nbsp;</div>
<div><span class="768110114-24042008"><font face="Arial" size="2">The
issue at hand is that&nbsp;we'd like for our customers to be able to use the
Xilinx EDK toolchain (which we know they will have) to compile Linx
apps without having to install another toolchain (crosstool, ELDK, etc).</font></span></div>
<div><span class="768110114-24042008"></span>&nbsp;</div>
<div><span class="768110114-24042008"><font face="Arial" size="2">So,
what I'm hoping is that the EDK toolchain can be configured to be Linux
compatible binaries, or that there is some kind of wrapper that will
handle the incompatible interfaces.&nbsp; Searching around, I've seen some
mention of Linux EABI compatibility (for Debian ARM releases), but I
haven't found any clear concensus...<br>
<br>
P.S. My apologies if this message appears on the mailing list twice...<br>
</font></span></div>
<pre class="moz-signature" cols="72">-- 
Brian Silverman
Concept X, LLC
</pre>
</body>
</html>

--------------080703000800080806020709--
