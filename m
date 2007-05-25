Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81872DDECC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 May 2007 02:56:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Advice needed
Date: Fri, 25 May 2007 09:56:50 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A215@MERCURY.inside.istor.com>
In-Reply-To: <10805157.post@talk.nabble.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm having a little trouble with memory mapped registers in both a NAND
chip and a CPLD on an 8541 design where the kernel is based on
linux-2.6.17.11 and mpc85xx_cds_common.

The NAND and CPLD are obviously not part of the memory map of the
mpc85xx_cds_common, and in our case are at local memory addresses
NAND=3D0xFF008000, 32K and CPLD=3D0xFF000000, 32K. Both need to be =
mapped
into memory in Linux.

I am looking at arch/ppc/platforms/85xx/mpc85xx_cds_common.c around
platform_init.

I wonder if a Freescale person could give me an opinion of where the
appropriate place is to call settlbcam to allow access to these two 32K
memory regions?

Charles Krinke
