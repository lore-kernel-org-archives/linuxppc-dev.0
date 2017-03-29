Return-Path: <roy.pledge@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0043.outbound.protection.outlook.com [104.47.42.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtgVx0gmyzDqKY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 08:14:16 +1100 (AEDT)
From: Roy Pledge <roy.pledge@nxp.com>
To: <robin.murphy@arm.com>, <oss@buserror.net>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>
CC: <madalin.bucur@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [RFC PATCH 5/5] powerpc: Add HAVE_GENERIC_DMA_COHERENT options to
 Kconfig
Date: Wed, 29 Mar 2017 17:13:57 -0400
Message-ID: <1490822037-6752-6-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
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

Enable HAVE_GENERIC_DMA_COHERENT to enable use of shared-dma-pool
reserved memory mappings

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 186e060..0e80e8b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -136,6 +136,7 @@ config PPC
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
+	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_GENERIC_GUP
 	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
 	select HAVE_IDE
-- 
2.9.3
