Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA73B1A0C7E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 10:24:30 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 hbabu@us.ibm.com, nacc@linux.vnet.ibm.com
Subject: [PATCH 2/7] powerpc: Enable on demand governor on ppc64_defconfig
Date: Tue, 20 Jan 2015 10:24:20 +1100
Message-Id: <1421709865-6368-2-git-send-email-anton@samba.org>
In-Reply-To: <1421709865-6368-1-git-send-email-anton@samba.org>
References: <1421709865-6368-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This was enabled on the pseries defconfigs recently, but missed
the ppc64 one.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/ppc64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index f1c4342..d657ad3 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -41,6 +41,7 @@ CONFIG_PPC_CELL_QPACE=y
 CONFIG_RTAS_FLASH=m
 CONFIG_IBMEBUS=y
 CONFIG_CPU_FREQ_PMAC64=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_HZ_100=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PPC_TRANSACTIONAL_MEM=y
-- 
2.1.0
