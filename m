Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E5766B7443
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 23:10:57 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33060DDDB2
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 23:10:56 +1000 (EST)
Date: Tue, 23 Jun 2009 08:10:51 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch for 2.6.31
Message-ID: <Pine.LNX.4.64.0906230810290.4417@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

 Documentation/powerpc/booting-without-of.txt     | 1168 -----------------------
 Documentation/powerpc/dts-bindings/4xx/emac.txt  |  148 ++
 Documentation/powerpc/dts-bindings/gpio/gpio.txt |   50
 Documentation/powerpc/dts-bindings/gpio/mdio.txt |   19
 Documentation/powerpc/dts-bindings/marvell.txt   |  521 ++++++++++
 Documentation/powerpc/dts-bindings/phy.txt       |   25
 Documentation/powerpc/dts-bindings/spi-bus.txt   |   57 +
 Documentation/powerpc/dts-bindings/usb-ehci.txt  |   25
 Documentation/powerpc/dts-bindings/xilinx.txt    |  295 +++++
 arch/powerpc/boot/dts/mpc8569mds.dts             |    1
 arch/powerpc/include/asm/cpm1.h                  |    2
 arch/powerpc/platforms/85xx/mpc85xx_mds.c        |    1
 arch/powerpc/platforms/85xx/smp.c                |    9
 arch/powerpc/platforms/85xx/socrates.c           |    6
 arch/powerpc/platforms/85xx/xes_mpc85xx.c        |    1
 arch/powerpc/sysdev/qe_lib/qe.c                  |    9
 16 files changed, 1157 insertions(+), 1180 deletions(-)

Anton Vorontsov (1):
      powerpc/85xx: Make eSDHC 1-bit only transfer mode default for MPC8569E-MDS

Huang Weiyi (1):
      powerpc/85xx: remove duplicated #include

Kumar Gala (4):
      powerpc/cpm1: Remove IMAP_ADDR
      powerpc/85xx: Stop using ppc_md.init on socrates
      powerpc/85xx: Fix issue found by lockdep trace in smp_85xx_kick_cpu
      powerpc: Refactor device tree binding

Randy Vinson (1):
      powerpc/85xx: Fix FSL RapidIO probing on MDS boards

Timur Tabi (1):
      powerpc/qe: add polling timeout to qe_issue_cmd()
