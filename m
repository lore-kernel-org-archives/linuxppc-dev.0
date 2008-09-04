Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-2.online-age.net (ext-cn0ut-2.online-age.net
	[63.210.253.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 184F5DDF14
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 02:01:48 +1000 (EST)
Received: from int-cn0ut-1.online-age.net (int-cn0ut-1.online-age.net
	[3.159.252.70])
	by ext-cn0ut-2.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m84G1j8m010964
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 12:01:45 -0400
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-1.online-age.net
	[3.159.252.70])
	by int-cn0ut-1.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m84G1j2T000883
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 12:01:45 -0400
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH v5 0/2] powerpc: Board support for GE Fanuc SBC610
To: linuxppc-dev@ozlabs.org
Date: Thu, 04 Sep 2008 17:04:00 +0100
Message-ID: <20080904160400.21289.66426.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: scottwood@freescale.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series implements basic board support for GE Fanuc's SBC610, a 
6U single board computer, based on Freescale's MPC8641D.

This series provides basic functionality:
- The board can boot with a serial console.
- Ethernet works, though the phys are polled.
- The PCI bus is scanned and sata functions.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

Scott: Thanks for your feeback.

I have removed un-needed entries from of_bus_ids[] and added "simple-bus" compatible node to soc in the DTS.

Martyn

 arch/powerpc/boot/dts/gef_sbc610.dts     |  260 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig      |    9 +
 arch/powerpc/platforms/86xx/Makefile     |    1 
 arch/powerpc/platforms/86xx/gef_sbc610.c |  149 +++++++++++++++++
 4 files changed, 418 insertions(+), 1 deletions(-)
