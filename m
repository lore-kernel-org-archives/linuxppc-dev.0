Return-Path: <dibacco@inwind.it>
Received: from smtp6.libero.it (smtp6.libero.it [193.70.192.59])
	by ozlabs.org (Postfix) with ESMTP id 9BEC067B78
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 10:34:02 +1100 (EST)
Received: from localhost (172.16.1.84) by smtp6.libero.it (7.0.027-DD01)
	id 43E2251900BED488 for linuxppc-embedded@ozlabs.org;
	Sat, 11 Feb 2006 00:33:59 +0100
Received: from smtp1.libero.it ([172.16.1.224])
	by localhost (asav5.libero.it [193.70.192.154]) (amavisd-new,
	port 10024)
	with ESMTP id 09885-13-3 for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 00:33:59 +0100 (CET)
Received: from libero.it (172.16.1.219) by smtp1.libero.it (7.0.027-DD01)
	id 431C3A4201A50340 for linuxppc-embedded@ozlabs.org;
	Sat, 11 Feb 2006 00:33:59 +0100
Date: Sat, 11 Feb 2006 00:33:59 +0100
Message-Id: <IUHW4N$47B2C300D721E9A22AAA3B454F79F6F4@libero.it>
Subject: kernel startup
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "dibacco\@inwind\.it" <dibacco@inwind.it>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Normally is it the uboot that uncompresses the kernel or the kernel uncom=
press itself? 

The function called by uboot when I type boot is _start?

What does it mean that the load address is 0x00000000? 
