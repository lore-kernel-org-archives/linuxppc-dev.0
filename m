Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80CAEDDDB2
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 09:19:42 +1100 (EST)
Date: Thu, 2 Apr 2009 17:19:36 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch (for 2.6.29)
Message-ID: <Pine.LNX.4.64.0904021718450.27069@blarg.am.freescale.net>
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

Added a few minor commits..

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

 arch/powerpc/Kconfig                   |    1 +
 arch/powerpc/boot/dts/ksi8560.dts      |    4 ++--
 arch/powerpc/boot/dts/sbc8548.dts      |    4 ++--
 arch/powerpc/boot/dts/sbc8560.dts      |    4 ++--
 arch/powerpc/boot/dts/socrates.dts     |    1 +
 arch/powerpc/boot/dts/stx_gp3_8560.dts |    4 ++--
 arch/powerpc/boot/dts/tqm8540.dts      |    4 ++--
 arch/powerpc/boot/dts/tqm8541.dts      |    4 ++--
 arch/powerpc/boot/dts/tqm8555.dts      |    4 ++--
 arch/powerpc/boot/dts/tqm8560.dts      |    4 ++--
 arch/powerpc/include/asm/reg.h         |   30 ++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/reg_booke.h   |   30 ------------------------------
 arch/powerpc/include/asm/sfp-machine.h |    6 +++---
 include/linux/fsl_devices.h            |   22 ----------------------
 14 files changed, 51 insertions(+), 71 deletions(-)

Grant Likely (1):
      powerpc: Remove unused symbols from fsl_devices.h

Josh Boyer (1):
      powerpc: Make LOWMEM_CAM_NUM depend on FSL_BOOKE

Kumar Gala (3):
      powerpc/85xx: Use fsl,mpc85.. as prefix for memory ctrl & l2-cache nodes
      powerpc: Move SPEFSCR defines to common header
      powerpc/math-emu: Change types to work on ppc64

Wolfgang Grandegger (1):
      powerpc/85xx: Re-add the device_type soc to socrates.dts
