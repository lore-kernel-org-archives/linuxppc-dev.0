Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AEDFC67B1A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Sep 2006 14:30:25 +1000 (EST)
Received: from [206.223.20.236] (port=4857)
	by mx.dlasys.net with esmtpa (Exim 4.62 #1 (Debian))
	id 1GRLTU-0004A1-F4 by authid <dhlii> with plain_server
	for <linuxppc-embedded@ozlabs.org>; Sun, 24 Sep 2006 00:20:16 -0400
Message-ID: <451608B7.9010707@dlasys.net>
Date: Sun, 24 Sep 2006 00:25:27 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Booting problems
Content-Type: multipart/alternative;
	boundary="------------070007080904030405080004"
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
--------------070007080904030405080004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


    I am booting a compressed initramfs kernel.

    I have hit what appears to be a size issue. simply adding more data
to the initramfs source directory,
    or adding even a small amount of unused code to my  kernel causes it
to hang after relocation during boot.
    The point of failure varies with the size of the kernel image.

    I have tried blindly jiggering with the  CONFIG_ADVANCED_OPTIONS
setting with no noticable effect.
    The total zImage.elf size is just shy of 3Mb.

    Does anyone have an idea what I need to do to be able to load a
larger image ?

--------------070007080904030405080004
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial"><br>
&nbsp;&nbsp;&nbsp; I am booting a compressed initramfs kernel.<br>
<br>
&nbsp;&nbsp;&nbsp; I have hit what appears to be a size issue. simply adding more data
to the initramfs source directory, <br>
&nbsp;&nbsp;&nbsp; or adding even a small amount of unused code to my&nbsp; kernel causes
it to hang after relocation during boot.<br>
&nbsp;&nbsp;&nbsp; The point of failure varies with the size of the kernel image.<br>
<br>
&nbsp;&nbsp;&nbsp; I have tried blindly jiggering with the&nbsp; CONFIG_ADVANCED_OPTIONS
setting with no noticable effect.<br>
&nbsp;&nbsp;&nbsp; The total zImage.elf size is just shy of 3Mb.<br>
<br>
&nbsp;&nbsp;&nbsp; Does anyone have an idea what I need to do to be able to load a
larger image ?<br>
</font>
</body>
</html>

--------------070007080904030405080004--
