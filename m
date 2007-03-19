Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id A5AB7DDF25
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 10:26:50 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2JNQl5o014034
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 16:26:47 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2JNQkQl029571
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 18:26:46 -0500 (CDT)
Subject: [PATCH 0/2] Basic MPC8544DS Platform port
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1174346806.6595.359.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 19 Mar 2007 18:26:46 -0500
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

Follow-up patches will provide added functionality for
peripherals such as PCI and SATA.

Thanks,
jdl

                                                                                                
 arch/powerpc/boot/dts/mpc8544ds.dts       |  137 ++++
 arch/powerpc/configs/mpc8544_ds_defconfig | 1077 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig       |    9 +-
 arch/powerpc/platforms/85xx/Makefile      |    1 +
 arch/powerpc/platforms/85xx/mpc8544_ds.c  |  147 ++++
 5 files changed, 1370 insertions(+), 1 deletions(-)
