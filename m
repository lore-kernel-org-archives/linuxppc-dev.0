Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: Add support for the currituck 476 platform from IBM
Date: Wed, 30 Nov 2011 16:23:54 +1100
Message-Id: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patches 1 and 2
	Modify the 44x PCI code to work with currituck.
Patch 3
	Is an old patch by Christoph Egger that fell through the cracks somehow.
Patches 4 and 5
	Modify the bootwrapper to handle currituck
Patch 6 
	The platform itself.

 arch/powerpc/boot/Makefile                   |    5 +-
 arch/powerpc/boot/dcr.h                      |    6 +
 arch/powerpc/boot/div64.S                    |   52 ++++++
 arch/powerpc/boot/dts/currituck.dts          |  240 ++++++++++++++++++++++++++
 arch/powerpc/boot/treeboot-currituck.c       |  129 ++++++++++++++
 arch/powerpc/boot/wrapper                    |    3 +
 arch/powerpc/configs/44x/currituck_defconfig |  110 ++++++++++++
 arch/powerpc/include/asm/reg.h               |    1 +
 arch/powerpc/kernel/cputable.c               |   14 ++
 arch/powerpc/kernel/head_44x.S               |    2 +
 arch/powerpc/mm/44x_mmu.c                    |    4 -
 arch/powerpc/platforms/44x/Kconfig           |   10 +
 arch/powerpc/platforms/44x/Makefile          |    1 +
 arch/powerpc/platforms/44x/ppc47x.c          |  198 +++++++++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.c             |   69 +++++++-
 arch/powerpc/sysdev/ppc4xx_pci.h             |    7 +
 16 files changed, 842 insertions(+), 9 deletions(-)
