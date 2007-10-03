Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A50ADDE0C
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 06:09:11 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l93K96hT007079
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 13:09:06 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l93K95KN017739
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 15:09:05 -0500 (CDT)
Subject: [PATCH 0/5] Add MPC8610 HPCD Base Port
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1191442145.21463.73.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 03 Oct 2007 15:09:05 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar and Paul,

These five patches add the base port for the newly
introduced MPC8610 HPCD reference board.  We would
like to see these added to 2.6.24 if possible!

Thanks,
jdl


 arch/powerpc/boot/dts/mpc8610_hpcd.dts      |  191 +++++
 arch/powerpc/configs/mpc8610_hpcd_defconfig | 1023 +++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig         |   13 +
 arch/powerpc/platforms/86xx/Makefile        |    1 +
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c  |  267 +++++++
 arch/powerpc/sysdev/fsl_pci.c               |    1 +
 include/linux/pci_ids.h                     |    1 +
 7 files changed, 1497 insertions(+), 0 deletions(-)
