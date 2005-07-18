Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw4.extranet.tce.com (dmzraw4.extranet.tce.com
	[157.254.234.139]) by ozlabs.org (Postfix) with ESMTP id B32D167C42
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Jul 2005 22:42:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 18 Jul 2005 14:42:49 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D02CABBE4@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: MPC8540 DMA routines (channel 0 broken?)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Clemens Koller wrote:
>In the meanwhile, I got channel 0 working. It seems
>that the DMA#0 machine got stuck in some configuration from any
>previous (u-boot?) operation which didn't clean up things
>properly. I had to explicitly abort a (continously running?)
>transfer to be able to re-program it in the way I need.

Are you using a BDI2000?=20
Some init mode uses the DMA#0 for memory zeroing (see your .cfg file).
Also the DDR ECC U-boot code may use the DMA#0.
Isn't it possible to reset the DMA#0 from Linux?

Best regards,
--=20
Stephane
