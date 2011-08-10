Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DAA36B6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 04:26:36 +1000 (EST)
Received: by vxh2 with SMTP id 2so1148209vxh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 11:26:33 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 10 Aug 2011 14:26:33 -0400
Message-ID: <CA+5PVA6mHk+vGsY0OibzJs27rpaKjGgaCEJVpJe4fKqrtBEmSA@mail.gmail.com>
Subject: Please pull 'next' branch of 4xx tree
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Finally somewhat caught up.  Now that -rc1 is out, here are some
patches for the next merge window.

josh

The following changes since commit 53d1e658df6e26d62500410719aaee2b82067c03:

  Merge branch 'devicetree/merge' of
git://git.secretlab.ca/git/linux-2.6 (2011-08-04 06:37:07 -1000)

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Ayman El-Khashab (1):
      powerpc/4xx: enable and fix pcie gen1/gen2 on the 460sx

Josh Boyer (1):
      powerpc/40x: Remove obsolete HCU4 board

Mike Williams (1):
      powerpc/4xx: edac: Add comma to fix build error

Stefan Roese (1):
      powerpc/44x: Add NOR flash device to Yosemite dts

Suzuki Poulose (1):
      powerpc/44x: Kexec support for PPC440X chipsets

 arch/powerpc/Kconfig                    |    2 +-
 arch/powerpc/boot/dts/hcu4.dts          |  168 ------------------------------
 arch/powerpc/boot/dts/yosemite.dts      |   36 +++++++
 arch/powerpc/configs/40x/hcu4_defconfig |   80 --------------
 arch/powerpc/configs/ppc40x_defconfig   |    1 -
 arch/powerpc/include/asm/kexec.h        |    2 +-
 arch/powerpc/kernel/misc_32.S           |  171 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/40x/Kconfig      |    8 --
 arch/powerpc/platforms/40x/Makefile     |    1 -
 arch/powerpc/platforms/40x/hcu4.c       |   61 -----------
 arch/powerpc/sysdev/ppc4xx_pci.c        |   89 +++++++++++++---
 arch/powerpc/sysdev/ppc4xx_pci.h        |   12 ++
 drivers/edac/ppc4xx_edac.c              |    2 +-
 13 files changed, 294 insertions(+), 339 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/hcu4.dts
 delete mode 100644 arch/powerpc/configs/40x/hcu4_defconfig
 delete mode 100644 arch/powerpc/platforms/40x/hcu4.c
