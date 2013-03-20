Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA5B62C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 21:22:32 +1100 (EST)
Received: from mail2-co1 (localhost [127.0.0.1])	by mail2-co1-R.bigfish.com
 (Postfix) with ESMTP id 250FFA4014D	for <linuxppc-dev@lists.ozlabs.org>; Wed,
 20 Mar 2013 10:22:27 +0000 (UTC)
Received: from CO1EHSMHS032.bigfish.com (unknown [10.243.78.253])	by
 mail2-co1.bigfish.com (Postfix) with ESMTP id 860C9AC0046	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 10:22:24 +0000 (UTC)
From: Shaveta Leekha <shaveta@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/5] powerpc/fsl-booke: Add B4(B4860QDS and B4420QDS) board
 support
Date: Wed, 20 Mar 2013 15:52:15 +0530
Message-ID: <1363774939-29909-1-git-send-email-shaveta@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaveta Leekha <shaveta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

B4860 and B4420 are personalities of same silicon which share same QDS board.
B4420 is a reduced personality of b4860. To manage the common board and similar
silicon features, device tree refactoring is being done through this patch set.

* common board features have been added in b4qds.dts
* common silicon related features have been added in b4si-pre.dtsi and b4si-post.dtsi
* the various silicon and board differences are in respective files of personalities

Shaveta Leekha (5):
  powerpc/85xx: add SEC-5.3 device tree
  powerpc/fsl-booke: Add initial silicon device tree files      for
    B4860 and B4420
  powerpc/fsl-booke: Add initial B4860QDS and B4420QDS board device
    tree
  powerpc/fsl-booke: Add B4_QDS board support
  powerpc/85xx: Update corenet64_smp_defconfig for B4_QDS

 arch/powerpc/boot/dts/b4420qds.dts            |   50 ++++++
 arch/powerpc/boot/dts/b4860qds.dts            |   61 +++++++
 arch/powerpc/boot/dts/b4qds.dts               |  171 +++++++++++++++++++
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi   |   94 +++++++++++
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi    |   49 ++++++
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi   |  135 +++++++++++++++
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi    |   59 +++++++
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi      |  216 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/b4si-pre.dtsi       |   65 ++++++++
 arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi |  118 ++++++++++++++
 arch/powerpc/configs/corenet64_smp_defconfig  |    1 +
 arch/powerpc/platforms/85xx/Kconfig           |   17 ++
 arch/powerpc/platforms/85xx/Makefile          |    1 +
 arch/powerpc/platforms/85xx/b4_qds.c          |  102 ++++++++++++
 14 files changed, 1139 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/b4420qds.dts
 create mode 100644 arch/powerpc/boot/dts/b4860qds.dts
 create mode 100644 arch/powerpc/boot/dts/b4qds.dts
 create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi
 create mode 100644 arch/powerpc/platforms/85xx/b4_qds.c

-- 
1.7.6.GIT
