Return-Path: <sebastian.haepe@eads.com>
Received: from mail.eads.net (mail.eads.net [53.122.156.212])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail-in1.intra.corp",
	Issuer "mail-in1.intra.corp" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C205A67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Mar 2005 20:43:44 +1100 (EST)
Received: from ohm.smart.lfk.eads.net ([53.146.48.56])
	by mail.eads.net (8.12.3/8.12.3/Debian-6.6) with ESMTP id
	j229Yl5l027778
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Mar 2005 10:34:47 +0100
Message-ID: <2D9AB865A49FD511914700105A0EF6790252BB8B@morse.smart.lfk.eads.net>
From: =?iso-8859-1?Q?=22H=E4pe=2C_Sebastian=2C_HRD/AB=22?=
	<sebastian.haepe@eads.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Wed, 2 Mar 2005 10:34:46 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Custom serial driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi!

I'm currently porting a Linux kernel v2.4 to a custom PowerPC =
603e-based
board.
For decompression and starting the kernel i use U-Boot. Since I have a
non-standard serial communication-ship, I wrote a small driver for
communication with U-Boot. Everything works fine but when I start the
kernel, I get no output and it crashes somewhere.

I guess I have to add a driver for the initial console to the kernel to =
see
any output.
But where do I have to add it? I searched the net for a good tutorial, =
but
in vain.

Can anyone tell me, where I have to put this driver or to get a nice
tutorial?

Greetings,
Sebastian H=E4pe
