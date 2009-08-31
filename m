Return-Path: <Louise.Yeung@Sun.COM>
Received: from brmea-mail-2.sun.com (brmea-mail-2.Sun.COM [192.18.98.43])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 95F4CB7B6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 06:53:11 +1000 (EST)
Received: from fe-amer-09.sun.com ([192.18.109.79])
	by brmea-mail-2.sun.com (8.13.6+Sun/8.12.9) with ESMTP id
	n7VKdQPd003581
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2009 20:39:26 GMT
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="Boundary_(ID_DiAf+YowXQSq9X2lfdPesg)"
Received: from conversion-daemon.mail-amer.sun.com by mail-amer.sun.com
	(Sun Java(tm) System Messaging Server 7u2-7.04 64bit (built Jul 2
	2009)) id <0KP900M00D74EG00@mail-amer.sun.com> for
	linuxppc-dev@lists.ozlabs.org; Mon, 31 Aug 2009 14:39:26 -0600 (MDT)
Received: from [129.145.154.65] ([unknown] [129.145.154.65])
	by mail-amer.sun.com
	(Sun Java(tm) System Messaging Server 7u2-7.04 64bit (built Jul 2
	2009)) with ESMTPSA id <0KP9006D9DDB2S20@mail-amer.sun.com> for
	linuxppc-dev@lists.ozlabs.org; Mon, 31 Aug 2009 14:39:12 -0600 (MDT)
Date: Mon, 31 Aug 2009 13:39:10 -0700
From: Louise.Yeung@Sun.COM
Subject: Re: ECC & Magic bitmask errors with JFFS2 file system on 6.23 kernel
	for	powerpc
In-reply-to: <OF4DA6695F.B8912DE2-ON652575F5.004F0DE0-652575F5.00519736@lntemsys.com>
Sender: Louise.Yeung@Sun.COM
To: linuxppc-dev@lists.ozlabs.org, louise <louise@Sun.COM>,
	Ravinder Kumar <Ravinder.Kumar@Sun.COM>
Message-id: <4A9C34EE.4040606@Sun.COM>
References: <OF4DA6695F.B8912DE2-ON652575F5.004F0DE0-652575F5.00519736@lntemsys.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--Boundary_(ID_DiAf+YowXQSq9X2lfdPesg)
Content-type: text/plain; CHARSET=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT

*Hi Rupesh,

We are using a Freescale processor similar to yours with NAND flash 
supporting 2KB page size .
We wonder if you were able to get any further with this problem that you 
posted.

Thanks
Louise and Ravinder
Sun embedded systems group

Rupesh Kumar* Rupesh.Kumar at Lntemsys.com 
<mailto:linuxppc-dev%40lists.ozlabs.org?Subject=Re%3A%20ECC%20%26%20Magic%20bitmask%20errors%20with%20JFFS2%20file%20system%20on%206.23%20kernel%20for%0A%09powerpc&In-Reply-To=%3COF4DA6695F.B8912DE2-ON652575F5.004F0DE0-652575F5.00519736%40lntemsys.com%3E>
/Fri Jul 17 01:03:11 EST 2009/

    * Previous message: rtas instantiation when commandline contains mem
      <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/074168.html>
    * Next message: [PATCH] mpc83xx/usb.c: fix usb mux setup for mpc834x
      <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/074147.html>
    * *Messages sorted by:* [ date ]
      <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/date.html#74140>
      [ thread ]
      <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/thread.html#74140>
      [ subject ]
      <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/subject.html#74140>
      [ author ]
      <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/author.html#74140>


------------------------------------------------------------------------

Hi

We are using Linux kernel 2.6.23 from freescale LTIB 
(MPC8313E_RDB_K26_20081226-LTIB.iso) on our custom board. 
JFFS2 is used as RFS and  nand write.jffs2 utility in the u-boot is used 
to burn the image on to the nand flash. 

When we boot for the first time everything seems to be OK. On subsequent 
reboots we are seeing following error messages reported by kernel on 
bootup. 
In addition we also see Magic bitmask errors being reported. 

///////////////////////////
mtd->read(0x400 bytes from 0x1b00000) returned ECC error
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01b001d0: 
0xfffe instead
mtd->read(0x400 bytes from 0x2500000) returned ECC error
mtd->read(0x400 bytes from 0x27c0000) returned ECC error
mtd->read(0x400 bytes from 0x2c20000) returned ECC error
mtd->read(0x400 bytes from 0x2cc0000) returned ECC error
mtd->read(0x400 bytes from 0x2d00000) returned ECC error
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x02d00074: 
0xfffe instead
Empty flash at 0x02d00078 ends at 0x02d003e4
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x02d003e4: 
0xffef instead
Empty flash at 0x02d003e8 ends at 0x02d00780
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x02d00780: 
0xfffb instead
mtd->read(0x400 bytes from 0x3320000) returned ECC error
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03320190: 
0xffff instead
Empty flash at 0x03320194 ends at 0x0332047c
////////////////////////////

We verified erase size passed as an argument for creating jffs2 file 
system (initial googling on the issue).
After contacting freescale we came to know that, it is a known issue and 
they dont have planned to work on this in near future. :(
Please give your valuable suggestions so that we can fix this problem and 
make our board running properly.

Thanks
Rupesh

------------------------------------------------------------------------

    * Previous message: rtas instantiation when commandline contains mem
      <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/074168.html>
    * Next message: [PATCH] mpc83xx/usb.c: fix usb mux setup for mpc834x
      <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/074147.html>
    * *Messages sorted by:* [ date ]
      <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/date.html#74140>
      [ thread ]
      <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/thread.html#74140>
      [ subject ]
      <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/subject.html#74140>
      [ author ]
      <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/author.html#74140>


------------------------------------------------------------------------
More information about the Linuxppc-dev mailing list 
<https://lists.ozlabs.org/listinfo/linuxppc-dev>

--Boundary_(ID_DiAf+YowXQSq9X2lfdPesg)
Content-type: text/html; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<b>Hi Rupesh,<br>
<br>
We are using a Freescale processor similar to yours with NAND flash
supporting 2KB page size .<br>
We wonder if you were able to get any further with this problem that
you posted.<br>
<br>
Thanks<br>
Louise and Ravinder<br>
Sun embedded systems group<br>
<br>
Rupesh Kumar</b> <a
 href="mailto:linuxppc-dev%40lists.ozlabs.org?Subject=Re%3A%20ECC%20%26%20Magic%20bitmask%20errors%20with%20JFFS2%20file%20system%20on%206.23%20kernel%20for%0A%09powerpc&amp;In-Reply-To=%3COF4DA6695F.B8912DE2-ON652575F5.004F0DE0-652575F5.00519736%40lntemsys.com%3E"
 title="ECC &amp; Magic bitmask errors with JFFS2 file system on 6.23 kernel for	powerpc">Rupesh.Kumar
at Lntemsys.com </a><br>
<i>Fri Jul 17 01:03:11 EST 2009</i>
<ul>
  <li>Previous message: <a
 href="http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/074168.html">rtas
instantiation when commandline contains mem
    </a></li>
  <li>Next message: <a
 href="http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/074147.html">[PATCH]
mpc83xx/usb.c: fix usb mux setup for mpc834x
    </a></li>
  <li> <b>Messages sorted by:</b> <a
 href="http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/date.html#74140">[
date ]</a> <a
 href="http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/thread.html#74140">[
thread ]</a> <a
 href="http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/subject.html#74140">[
subject ]</a> <a
 href="http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/author.html#74140">[
author ]</a> </li>
</ul>
<hr><!--beginarticle-->
<pre>Hi

We are using Linux kernel 2.6.23 from freescale LTIB 
(MPC8313E_RDB_K26_20081226-LTIB.iso) on our custom board. 
JFFS2 is used as RFS and  nand write.jffs2 utility in the u-boot is used 
to burn the image on to the nand flash. 

When we boot for the first time everything seems to be OK. On subsequent 
reboots we are seeing following error messages reported by kernel on 
bootup. 
In addition we also see Magic bitmask errors being reported. 

///////////////////////////
mtd-&gt;read(0x400 bytes from 0x1b00000) returned ECC error
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01b001d0: 
0xfffe instead
mtd-&gt;read(0x400 bytes from 0x2500000) returned ECC error
mtd-&gt;read(0x400 bytes from 0x27c0000) returned ECC error
mtd-&gt;read(0x400 bytes from 0x2c20000) returned ECC error
mtd-&gt;read(0x400 bytes from 0x2cc0000) returned ECC error
mtd-&gt;read(0x400 bytes from 0x2d00000) returned ECC error
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x02d00074: 
0xfffe instead
Empty flash at 0x02d00078 ends at 0x02d003e4
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x02d003e4: 
0xffef instead
Empty flash at 0x02d003e8 ends at 0x02d00780
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x02d00780: 
0xfffb instead
mtd-&gt;read(0x400 bytes from 0x3320000) returned ECC error
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03320190: 
0xffff instead
Empty flash at 0x03320194 ends at 0x0332047c
////////////////////////////

We verified erase size passed as an argument for creating jffs2 file 
system (initial googling on the issue).
After contacting freescale we came to know that, it is a known issue and 
they dont have planned to work on this in near future. :(
Please give your valuable suggestions so that we can fix this problem and 
make our board running properly.

Thanks
Rupesh
</pre>
<!--endarticle-->
<hr>
<ul>
<!--threads-->
  <li>Previous message: <a
 href="http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/074168.html">rtas
instantiation when commandline contains mem
    </a></li>
  <li>Next message: <a
 href="http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/074147.html">[PATCH]
mpc83xx/usb.c: fix usb mux setup for mpc834x
    </a></li>
  <li> <b>Messages sorted by:</b> <a
 href="http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/date.html#74140">[
date ]</a> <a
 href="http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/thread.html#74140">[
thread ]</a> <a
 href="http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/subject.html#74140">[
subject ]</a> <a
 href="http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-July/author.html#74140">[
author ]</a> </li>
</ul>
<hr>
<a href="https://lists.ozlabs.org/listinfo/linuxppc-dev">More
information about the Linuxppc-dev
mailing list</a>
</body>
</html>

--Boundary_(ID_DiAf+YowXQSq9X2lfdPesg)--
