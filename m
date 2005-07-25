Return-Path: <R00020C@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 290F067D62
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jul 2005 08:42:08 +1000 (EST)
Received: from de01smr01.am.mot.com (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	j6PGYf7p023497 for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 10:34:41 -0600 (MDT)
Received: from [10.13.64.191] (D3SWHK71-010013064191.am.freescale.net
	[10.13.64.191])
	by de01smr01.am.mot.com (8.13.1/8.13.0) with ESMTP id j6PFYcdK003947
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 10:34:39 -0500 (CDT)
From: Steve Snyder <R00020C@freescale.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 25 Jul 2005 11:28:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200507251128.35720.R00020C@freescale.com>
Subject: Seeking HOW-TO on bring up EP MPC8245 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

My company has just purchased a couple of MPC8245 boards from Embedded 
Planet.  The boards come with just the boot loader (PlanetCore v1.03) 
installed.  Now I'm trying to get the boards to boot a Linux kernel.

I downloaded the software ISO image (ppc-2005-03-07.iso) from EP's 
website.  No problems seen when building the kernel with their 
default config file.  Before taking the step on burning the kernel 
image to flash, I'm loading the image into RAM (via TFTP) and running 
it.  

When I attempt to run the kernel image nothing happens. No error 
message, or serial output of any find.

The EP documentation is pretty generic since the board can be used to 
run just about any OS.  Is there a HOW-TO on how to get this, or a 
similar, board up and running with Linux?

Thanks.
