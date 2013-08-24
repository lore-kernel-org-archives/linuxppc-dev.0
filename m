Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 66E392C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 11:08:27 +1000 (EST)
Date: Fri, 23 Aug 2013 20:07:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git next
Message-ID: <20130824010733.GA6116@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following changes since commit afbcdd97bf117bc2d01b865a32f78f662437a4d8:

  powerpc/wsp: Fix early debug build (2013-08-16 10:59:27 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to 622e03eb3498c32ee29de5c1d6d381f443e58fad:

  powerpc/85xx: Add C293PCIE board support (2013-08-23 19:43:24 -0500)

----------------------------------------------------------------
Chunhe Lan (1):
      powerpc/85xx: Add P1023RDB board support

Haijun.Zhang (1):
      powerpc/85xx: Add support for 85xx cpu type detection

Mingkai Hu (3):
      powerpc/85xx: Add SEC6.0 device tree
      powerpc/85xx: Add silicon device tree for C293
      powerpc/85xx: Add C293PCIE board support

Scott Wood (5):
      powerpc/fsl-booke: Work around erratum A-006958
      powerpc: Convert some mftb/mftbu into mfspr
      powerpc/85xx: Remove -Wa,-me500
      powerpc/booke64: Use appropriate -mcpu
      powerpc/e500: Set -mcpu flag for 32-bit e500

Wang Dongsheng (1):
      powerpc: add Book E support to 64-bit hibernation

 .../devicetree/bindings/crypto/fsl-sec6.txt        | 157 ++++++++++++++
 arch/powerpc/Makefile                              |  18 +-
 arch/powerpc/boot/dts/c293pcie.dts                 | 223 ++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/c293si-post.dtsi         | 193 +++++++++++++++++
 arch/powerpc/boot/dts/fsl/c293si-pre.dtsi          |  63 ++++++
 arch/powerpc/boot/dts/fsl/qoriq-sec6.0-0.dtsi      |  56 +++++
 arch/powerpc/boot/dts/p1023rdb.dts                 | 234 +++++++++++++++++++++
 arch/powerpc/boot/ppc_asm.h                        |   3 +
 arch/powerpc/boot/util.S                           |  10 +-
 .../85xx/{p1023rds_defconfig => p1023_defconfig}   |  24 ++-
 arch/powerpc/configs/mpc85xx_defconfig             |   1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig         |   1 +
 arch/powerpc/include/asm/cputable.h                |   9 +-
 arch/powerpc/include/asm/mpc85xx.h                 |  92 ++++++++
 arch/powerpc/include/asm/ppc_asm.h                 |   6 +-
 arch/powerpc/include/asm/reg.h                     |  17 +-
 arch/powerpc/include/asm/timex.h                   |   4 +-
 arch/powerpc/kernel/swsusp_asm64.S                 |  45 +++-
 arch/powerpc/kernel/vdso32/gettimeofday.S          |   6 +-
 arch/powerpc/platforms/85xx/Kconfig                |  10 +-
 arch/powerpc/platforms/85xx/Makefile               |   1 +
 arch/powerpc/platforms/85xx/c293pcie.c             |  75 +++++++
 arch/powerpc/platforms/85xx/p1023_rds.c            |  24 ++-
 arch/powerpc/platforms/85xx/smp.c                  |  25 +++
 arch/powerpc/platforms/Kconfig.cputype             |  13 ++
 25 files changed, 1280 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec6.txt
 create mode 100644 arch/powerpc/boot/dts/c293pcie.dts
 create mode 100644 arch/powerpc/boot/dts/fsl/c293si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/c293si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec6.0-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1023rdb.dts
 rename arch/powerpc/configs/85xx/{p1023rds_defconfig => p1023_defconfig} (88%)
 create mode 100644 arch/powerpc/include/asm/mpc85xx.h
 create mode 100644 arch/powerpc/platforms/85xx/c293pcie.c
