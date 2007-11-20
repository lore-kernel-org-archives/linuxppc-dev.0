Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5833BDDDDB
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 10:39:27 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lAKNdMfw000839
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 17:39:23 -0600
Date: Tue, 20 Nov 2007 17:38:05 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: Please pull from 'for-2.6.24' branch (fwd)
Message-ID: <Pine.LNX.4.64.0711201737530.19222@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

didn't cc linuxppc-dev.

---------- Forwarded message ----------
Date: Tue, 20 Nov 2007 15:40:57 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.24' branch

Please pull from 'for-2.6.24' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.24

to receive the following updates:

 arch/powerpc/boot/dts/mpc832x_mds.dts        |    7 ++
 arch/powerpc/boot/dts/mpc834x_mds.dts        |    9 ++
 arch/powerpc/boot/dts/mpc836x_mds.dts        |    9 ++
 arch/powerpc/configs/mpc832x_mds_defconfig   |   48 ++++++++++++++
 arch/powerpc/configs/mpc832x_rdb_defconfig   |   41 +++++++++++-
 arch/powerpc/configs/mpc834x_itx_defconfig   |    2
 arch/powerpc/configs/mpc834x_itxgp_defconfig |   88 ++++++++++++++++++++++++++-
 arch/powerpc/configs/mpc834x_mds_defconfig   |   48 ++++++++++++++
 arch/powerpc/configs/mpc836x_mds_defconfig   |   48 ++++++++++++++
 arch/powerpc/configs/mpc8568mds_defconfig    |   48 ++++++++++++++
 arch/powerpc/platforms/83xx/mpc832x_mds.c    |   24 -------
 arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   14 ++--
 arch/powerpc/platforms/83xx/mpc834x_mds.c    |   24 -------
 arch/powerpc/platforms/83xx/mpc836x_mds.c    |   24 -------
 14 files changed, 346 insertions(+), 88 deletions(-)

Anton Vorontsov (2):
      [POWERPC] 83xx: MPC832x RDB - remove spidev stub, use mmc_spi
      [POWERPC] 83xx: Update mpc832x_rdb_defconfig to enable MMC-over-SPI

Grant Likely (1):
      [POWERPC] 83xx: Update mpc8349emitx(gp) defconfig for USB

Kim Phillips (1):
      [POWERPC] 8xxx: MDS board RTC fixes
