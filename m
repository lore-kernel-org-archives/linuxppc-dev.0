Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id B6CDFDE05B
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 03:18:38 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2KGIZKv029911
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 09:18:36 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2KGIZ4R006679
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 11:18:35 -0500 (CDT)
Subject: [PATCH 0/2 Rev 2]
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1174407515.6595.414.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 20 Mar 2007 11:18:35 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 
Kumar and Paul,

This two-part patch series adds the basic MPC8544DS platform
support files.  These patches have been through one round
of review and cleanup, and should apply to Paul's current
for-2.6.22 branch.

This is Rev 2, which modifies the interrupts so they
are no longer offset by 16, as per Kumar's request.

Follow-up patches will provide added functionality for
peripherals such as PCI and SATA.

Thanks,
jdl
                                                                                                                
                                                                                                                
                                                                                                                
 arch/powerpc/boot/dts/mpc8544ds.dts       |  136 ++++
 arch/powerpc/configs/mpc8544_ds_defconfig | 1077 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig       |    9 +-
 arch/powerpc/platforms/85xx/Makefile      |    1 +
 arch/powerpc/platforms/85xx/mpc8544_ds.c  |  144 ++++
 5 files changed, 1366 insertions(+), 1 deletions(-)
