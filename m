Return-Path: <srs0=zbx3=dq=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1d6C2xxszF06p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 12:51:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3z1d6C25qWz8t5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 12:51:15 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3z1d6B4CB1z9s7g
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2017 12:51:14 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id vBK1p0We027828
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2017 19:51:06 -0600
Message-ID: <1513734660.2743.14.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Add aacraid and nvme to powernv_defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Wed, 20 Dec 2017 12:51:00 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These adapters can be found in a number of our systems, so let's
enable the corresponding drivers by default.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
--- a/arch/powerpc/configs/powernv_defconfig	2017-12-19 18:37:24.803470591 -0600
+++ b/arch/powerpc/configs/powernv_defconfig	2017-12-19 19:47:57.931952417 -0600
@@ -97,6 +97,7 @@
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_VIRTIO_BLK=m
+CONFIG_BLK_DEV_NVME=y
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECD=y
 CONFIG_BLK_DEV_GENERIC=y
@@ -113,6 +114,7 @@
 CONFIG_SCSI_CXGB4_ISCSI=m
 CONFIG_SCSI_BNX2_ISCSI=m
 CONFIG_BE2ISCSI=m
+CONFIG_SCSI_AACRAID=y
 CONFIG_SCSI_MPT2SAS=m
 CONFIG_SCSI_SYM53C8XX_2=m
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
