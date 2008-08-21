Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-8.online-age.net (Ext-cn0ut-8.online-age.net
	[63.210.253.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 76E83DF0B6
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 23:47:45 +1000 (EST)
Received: from int-cn0ut-5.online-age.net (int-cn0ut-5.online-age.net
	[3.159.252.74])
	by ext-cn0ut-8.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m7LDfjAH025296
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 09:41:45 -0400
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-5.online-age.net
	[3.159.252.74])
	by int-cn0ut-5.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m7LDfjHa032112
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 09:41:45 -0400
Date: Thu, 21 Aug 2008 14:41:39 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] powerpc: Board support for GE Fanuc SBC610
Message-Id: <20080821144139.f6379c13.martyn.welch@gefanuc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org
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

Martyn Welch (2):
      powerpc: Default configuration for GE Fanuc SBC610
      powerpc: Board support for GE Fanuc SBC610


 arch/powerpc/boot/dts/gef_sbc610.dts      |  268 +++++
 arch/powerpc/configs/gef_sbc610_defconfig | 1654 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig       |    9 
 arch/powerpc/platforms/86xx/Makefile      |    1 
 arch/powerpc/platforms/86xx/gef_sbc610.c  |  187 +++
 5 files changed, 2118 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/gef_sbc610.dts
 create mode 100644 arch/powerpc/configs/gef_sbc610_defconfig
 create mode 100644 arch/powerpc/platforms/86xx/gef_sbc610.c
