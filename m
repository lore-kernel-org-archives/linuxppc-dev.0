Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <18768.28189.286604.897494@cargo.ozlabs.ibm.com>
Date: Tue, 23 Dec 2008 15:50:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Commits added to powerpc.git next and master branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Includes commits pulled from Grant Likely's and Arnd Bergmann's trees.

Anton Vorontsov (5):
      powerpc: Make default kexec/crash_kernel ops implicit
      powerpc: Remove default kexec/crash_kernel ops assignments
      powerpc: Prepare xmon_save_regs for use with kdump
      powerpc/32/kdump: Implement crash_setup_regs() using ppc_save_reg=
s()
      powerpc/32: Allow __ioremap on RAM addresses for kdump kernel

Arnd Bergmann (1):
      powerpc/cell: fix build breakage with CONFIG_SPUFS disabled

Benjamin Herrenschmidt (1):
      powerpc: Fix missing 'blr' in _tlbia()

Benjamin Krill (1):
      powerpc/cell: add QPACE as a separate Cell platform

Dale Farnsworth (4):
      powerpc: Setup OF properties for ppc32 kexec
      powerpc/32: Setup OF properties for kdump
      powerpc/32: Add the ability for a classic ppc kernel to be loaded=
 at 32M
      powerpc/32: Wire up the trampoline code for kdump

Grant Likely (4):
      powerpc/mpc5200: Document and tidy irq driver
      powerpc/mpc5200: Make internal 5200 PIC the default interrupt con=
troller
      powerpc/mpc5200: Bugfix on handling variable sized buffer descrip=
tors
      powerpc/mpc5200: Disable bestcomm prefetching when ATA DMA enable=
d

Paul Mackerras (1):
      powerpc: Fix KVM build on ppc440

Ren=E9 B=FCrgel (1):
      powerpc/mpc5200: Make PSC UART driver update serial errors counte=
rs

Sebastien Dugue (1):
      powerpc/pseries: Fix cpu hotplug

Tim Yamin (2):
      powerpc/mpc5200: Bestcomm fixes to ATA support
      powerpc/mpc5200: Add MDMA/UDMA support to MPC5200 ATA driver

Wolfram Sang (3):
      powerpc/mpc5200: Remove obsolete code from mpc5200 MDIO driver
      powerpc/mpc5200: add rts/cts handling in PSC UART driver
      powerpc/mpc5200: fix error paths in PSC UART probe function
