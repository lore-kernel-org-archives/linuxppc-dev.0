Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw3.extranet.thmulti.com (dmzraw3.extranet.thmulti.com
	[141.11.234.71]) by ozlabs.org (Postfix) with ESMTP id 64731DDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jul 2007 22:34:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How to access physical memory from user space for MPC8260 chip
Date: Thu, 12 Jul 2007 14:07:52 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB178@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "suresh suresh" <sureshtang@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

suresh suresh wrote:
>I have to map physical memory to user space or kernel space. I am
writing >driver for MPC8260 chip and I want to know how to map any
32-bit address >space to user space and kernel space.

Your question is a linuxppc-embedded FAQ. User-land access is documented

in Denx's FAQ[1], and accessible through shorter URL[2]. For more=20
information, please follow this thread[3] (not ppc specific actually).

[1]
http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acce
ssingPeripheralsFromUserSpace
[2] http://tinyurl.com/6c7th
[3] http://article.gmane.org/gmane.linux.ports.ppc.embedded/5053

In kernel land, ioremap() is all you need.

Don't forget to use the 'eieio' asm instruction if you want explicit=20
I/O ordering.

Best Regards,
--=20
Stephane, the userland ioremap bot
