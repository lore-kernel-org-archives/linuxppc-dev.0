Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F685DDF07
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 03:26:09 +1100 (EST)
Date: Mon, 23 Feb 2009 10:26:03 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch
Message-ID: <Pine.LNX.4.64.0902231025400.12668@blarg.am.freescale.net>
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

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

 arch/powerpc/include/asm/cputable.h  |    4 ++-
 arch/powerpc/include/asm/dbell.h     |   43 ++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/mmu.h       |    4 +--
 arch/powerpc/kernel/Makefile         |    2 -
 arch/powerpc/kernel/cputable.c       |    3 +-
 arch/powerpc/kernel/dbell.c          |   44 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/head_fsl_booke.S |    6 +++-
 arch/powerpc/kernel/traps.c          |   21 ++++++++++++++++
 arch/powerpc/mm/tlb_nohash_low.S     |   44 +++++++++++++++++++++++++++++------
 arch/powerpc/platforms/83xx/usb.c    |    3 +-
 arch/powerpc/sysdev/fsl_soc.c        |    4 +++
 arch/powerpc/sysdev/ipic.c           |    6 +---
 drivers/i2c/busses/i2c-mpc.c         |    9 ++-----
 13 files changed, 169 insertions(+), 24 deletions(-)

Anton Vorontsov (1):
      powerpc/83xx: Do not configure or probe disabled FSL DR USB controllers

Kumar Gala (2):
      powerpc/fsl-booke: Add support for tlbilx instructions
      powerpc: Add support for using doorbells for SMP IPI

Timur Tabi (1):
      i2c-mpc: do not allow interruptions when waiting for I2C to complete

dayu@datangmobile.cn (1):
      powerpc/83xx: Fix the interrupt loss problem on ipic
