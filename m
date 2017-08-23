Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnL6X48zDrJ8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 38/46] powerpc/configs/6xx: Drop removed CONFIG_BLK_DEV_HD
Date: Wed, 23 Aug 2017 15:37:58 +1000
Message-Id: <1503466686-10932-39-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
References: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 8e14be53f470 ("remove the obsolete hd driver") the
CONFIG_BLK_DEV_HD symbol was removed, so drop it from the defconfig.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index bef9a2247702..ddb100f4e034 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -368,7 +368,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_VIRTIO_BLK=m
-CONFIG_BLK_DEV_HD=y
 CONFIG_ENCLOSURE_SERVICES=m
 CONFIG_SENSORS_TSL2550=m
 CONFIG_EEPROM_AT24=m
-- 
2.7.4
