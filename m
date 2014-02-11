Return-Path: <prvs=011988102b=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0660C2C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 22:50:25 +1100 (EST)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] Support of the kmcoge4 board
Date: Tue, 11 Feb 2014 12:50:05 +0100
Message-Id: <1392119407-29490-1-git-send-email-valentin.longchamp@keymile.com>
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for Keymile's COGE4 board, called kmcoge4. This
board is the reference design for further designs at Keymile around the
P2040/P2041 SoCs from Freescale. This reference design is internally
called kmp204x.

Changes in v2:
- add a patch so that the Zarlink vendor prefix is defined
- add some nodes on the localbus CS when possible
- only use the corenet_generic machine and add kmcoge4 to the supported
  boards instead of defining a new kmp204x machine
- set better and more precise device nodes for the spi devices
- remove the partion layout for the spi_flash@0

Valentin Longchamp (2):
  devicetree: bindings: add Zarlink to the vendor prefixes
  powerpc/mpc85xx: add support for Keymile's kmcoge4 board

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/powerpc/boot/dts/kmcoge4.dts                  | 161 +++++++++++++++
 arch/powerpc/configs/85xx/kmp204x_defconfig        | 227 +++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig                |   2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c      |   3 +-
 5 files changed, 392 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/kmcoge4.dts
 create mode 100644 arch/powerpc/configs/85xx/kmp204x_defconfig

-- 
1.8.0.1
