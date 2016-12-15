Return-Path: <valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfZ526KsKzDsxq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 00:28:06 +1100 (AEDT)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: oss@buserror.net, linuxppc-dev@lists.ozlabs.org
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: [PATCH 0/3] powerpc: update for the Keymile QorIQ boards
Date: Thu, 15 Dec 2016 14:22:25 +0100
Message-Id: <1481808148-16840-1-git-send-email-valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series contains some updates for the Keymile QorIQ boards.
There is a small fix for the kmcoge4 board DTS, the removal of the
kmp204x_defconfig file which is unmaintained (corenet32_smp_defconfig
can be used instead) and the addition of the kmcent2 board.

Valentin Longchamp (3):
  powerpc/corenet: explicitly disable the SDHC controller on kmcoge4
  powerpc/85xx: remove the kmp204x_defconfig
  powerpc/corenet: add support for the kmcent2 board

 arch/powerpc/boot/dts/fsl/kmcent2.dts         | 303 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/kmcoge4.dts         |   4 +
 arch/powerpc/configs/85xx/kmp204x_defconfig   | 220 -------------------
 arch/powerpc/platforms/85xx/corenet_generic.c |   1 +
 4 files changed, 308 insertions(+), 220 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/kmcent2.dts
 delete mode 100644 arch/powerpc/configs/85xx/kmp204x_defconfig

-- 
1.8.3.1
