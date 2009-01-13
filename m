Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E8C2DE11A
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 10:50:54 +1100 (EST)
Date: Tue, 13 Jan 2009 17:50:47 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch (for 2.6.29)(updated)
Message-ID: <Pine.LNX.4.64.0901131750160.16753@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updated to just be the small bug fixes and the move of the driver

- k

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

 arch/powerpc/boot/dts/mpc8315erdb.dts          |    4
 arch/powerpc/kernel/head_fsl_booke.S           |    2
 arch/powerpc/platforms/83xx/Makefile           |    1
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |  209 +++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig                 |   11 +
 drivers/i2c/chips/Kconfig                      |   11 -
 drivers/i2c/chips/Makefile                     |    1
 drivers/i2c/chips/mcu_mpc8349emitx.c           |  209 -------------------------
 8 files changed, 224 insertions(+), 224 deletions(-)

Anton Vorontsov (2):
      powerpc/83xx: Make serial ports work on MPC8315E-RDB w/ FSL U-Boots
      powerpc/83xx: Move mcu_mpc8349emitx driver out of drivers/i2c/chips/

Kumar Gala (1):
      powerpc/e500mc: Doorbells need to be taken w/exceptions disabled
