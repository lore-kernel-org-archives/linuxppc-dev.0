Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E573DE0E0
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 22:08:15 +1100 (EST)
Date: Wed, 11 Mar 2009 06:08:09 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch (missed a few patches)
Message-ID: <Pine.LNX.4.64.0903110607160.8788@blarg.am.freescale.net>
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

In the last pull I think you might have had a tree of mine before these
few minor commits.

 arch/powerpc/Makefile                          |    4 ++--
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |    2 +-
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    2 +-
 arch/powerpc/math-emu/Makefile                 |    5 ++---
 arch/powerpc/platforms/85xx/ksi8560.c          |    2 --
 5 files changed, 6 insertions(+), 9 deletions(-)

Liu Yu (1):
      powerpc/math-emu: Fix efp dependence

Ted Peters (1):
      powerpc/85xx: Fix MPC8572DS PCI protected interrupt sources

Thomas Gleixner (1):
      powerpc/85xx: remove setup_irq(NULL action) in ksi8560
