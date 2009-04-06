Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3B7FBDDE9E
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 00:29:17 +1000 (EST)
Date: Mon, 6 Apr 2009 09:29:12 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'next' branch (for 2.6.30)
Message-ID: <Pine.LNX.4.64.0904060928360.24957@blarg.am.freescale.net>
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

 arch/powerpc/Kconfig                    |    1
 arch/powerpc/boot/dts/ksi8560.dts       |    4 +--
 arch/powerpc/boot/dts/pq2fads.dts       |   20 +++++++++++++-----
 arch/powerpc/boot/dts/sbc8548.dts       |    4 +--
 arch/powerpc/boot/dts/sbc8560.dts       |    4 +--
 arch/powerpc/boot/dts/socrates.dts      |    1
 arch/powerpc/boot/dts/stx_gp3_8560.dts  |    4 +--
 arch/powerpc/boot/dts/tqm8540.dts       |    4 +--
 arch/powerpc/boot/dts/tqm8541.dts       |    4 +--
 arch/powerpc/boot/dts/tqm8555.dts       |    4 +--
 arch/powerpc/boot/dts/tqm8560.dts       |    4 +--
 arch/powerpc/include/asm/mpic.h         |   12 +++++++++++
 arch/powerpc/include/asm/reg.h          |   30 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/reg_booke.h    |   30 ----------------------------
 arch/powerpc/include/asm/sfp-machine.h  |    6 ++---
 arch/powerpc/sysdev/mpic.c              |   34 ++++++++++++++++++++++++++++++++
 drivers/serial/cpm_uart/cpm_uart_core.c |   14 ++++++-------
 drivers/video/fsl-diu-fb.c              |   34 +++++++++++++++++++-------------
 include/linux/fsl_devices.h             |   22 --------------------
 19 files changed, 139 insertions(+), 97 deletions(-)

Anton Vorontsov (1):
      fsl-diu-fb: Pass the proper device for dma mapping routines

Grant Likely (1):
      powerpc: Remove unused symbols from fsl_devices.h

Josh Boyer (1):
      powerpc: Make LOWMEM_CAM_NUM depend on FSL_BOOKE

Kumar Gala (4):
      powerpc/85xx: Use fsl,mpc85.. as prefix for memory ctrl & l2-cache nodes
      powerpc: Move SPEFSCR defines to common header
      powerpc/math-emu: Change types to work on ppc64
      powerpc: Add support for CoreInt delivery of interrupts on MPIC

Scott Wood (3):
      cpm_uart: Initialize port.dev before it's used.
      cpm_uart: Disable CPM udbg when re-initing CPM uart, even if not the console.
      powerpc/pq2fads: Update device tree for use with device-tree-aware u-boot.

Wolfgang Grandegger (1):
      powerpc/85xx: Re-add the device_type soc to socrates.dts
