Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0073.outbound.protection.outlook.com [104.47.38.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ18M0lPQzDt1r
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 19:41:38 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <oss@buserror.net>, <ppc@mindchasers.com>,
 <joe@perches.com>, <pebolle@tiscali.nl>, <joakim.tjernlund@infinera.com>
Subject: [PATCH net-next v8 7/9] arch/powerpc: Enable FSL_PAMU
Date: Tue, 15 Nov 2016 10:41:07 +0200
Message-ID: <1479199269-9748-8-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1479199269-9748-1-git-send-email-madalin.bucur@nxp.com>
References: <1479199269-9748-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
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

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 arch/powerpc/configs/dpaa.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/dpaa.config b/arch/powerpc/configs/dpaa.config
index efa99c0..f124ee1 100644
--- a/arch/powerpc/configs/dpaa.config
+++ b/arch/powerpc/configs/dpaa.config
@@ -1 +1,2 @@
 CONFIG_FSL_DPAA=y
+CONFIG_FSL_PAMU=y
-- 
2.1.0
