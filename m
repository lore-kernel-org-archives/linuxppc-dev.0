Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0124.outbound.protection.outlook.com [65.55.169.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D6191A17B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 10:36:50 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Schmitt Richard-B43082 <richard.schmitt@freescale.com>, Pan Lijun-B44306
 <Lijun.Pan@freescale.com>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH 0/2] powerpc/85xx: Kconfig fragments
Date: Thu, 30 Jul 2015 19:36:32 -0500
Message-ID: <1438302994-19080-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches sit on top of the following patches:
http://patchwork.ozlabs.org/patch/499211/
http://patchwork.ozlabs.org/patch/499200/
http://patchwork.ozlabs.org/patch/468592/

Scott Wood (2):
  powerpc/85xx: Make defconfigs consistent
  powerpc/85xx: Use kconfig fragments

 arch/powerpc/Makefile                        |  20 +++
 arch/powerpc/configs/85xx-32bit.config       |   5 +
 arch/powerpc/configs/85xx-64bit.config       |   4 +
 arch/powerpc/configs/85xx-hw.config          | 140 +++++++++++++++
 arch/powerpc/configs/85xx-smp.config         |   2 +
 arch/powerpc/configs/altivec.config          |   1 +
 arch/powerpc/configs/corenet32_smp_defconfig | 195 ---------------------
 arch/powerpc/configs/corenet64_smp_defconfig | 178 -------------------
 arch/powerpc/configs/corenet_basic_defconfig |   1 +
 arch/powerpc/configs/fsl-emb-nonhw.config    | 126 ++++++++++++++
 arch/powerpc/configs/mpc85xx_basic_defconfig |  23 +++
 arch/powerpc/configs/mpc85xx_defconfig       | 252 ---------------------------
 arch/powerpc/configs/mpc85xx_smp_defconfig   | 244 --------------------------
 13 files changed, 322 insertions(+), 869 deletions(-)
 create mode 100644 arch/powerpc/configs/85xx-32bit.config
 create mode 100644 arch/powerpc/configs/85xx-64bit.config
 create mode 100644 arch/powerpc/configs/85xx-hw.config
 create mode 100644 arch/powerpc/configs/85xx-smp.config
 create mode 100644 arch/powerpc/configs/altivec.config
 delete mode 100644 arch/powerpc/configs/corenet32_smp_defconfig
 delete mode 100644 arch/powerpc/configs/corenet64_smp_defconfig
 create mode 100644 arch/powerpc/configs/corenet_basic_defconfig
 create mode 100644 arch/powerpc/configs/fsl-emb-nonhw.config
 create mode 100644 arch/powerpc/configs/mpc85xx_basic_defconfig
 delete mode 100644 arch/powerpc/configs/mpc85xx_defconfig
 delete mode 100644 arch/powerpc/configs/mpc85xx_smp_defconfig

-- 
2.1.4
