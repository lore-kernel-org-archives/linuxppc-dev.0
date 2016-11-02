Return-Path: <madalin.bucur@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0071.outbound.protection.outlook.com [104.47.32.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8KCz66Q7zDvPv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 07:18:07 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <oss@buserror.net>, <ppc@mindchasers.com>,
 <joe@perches.com>, <pebolle@tiscali.nl>, <joakim.tjernlund@transmode.se>
Subject: [PATCH net-next v6 08/10] arch/powerpc: Enable FSL_PAMU
Date: Wed, 2 Nov 2016 22:17:32 +0200
Message-ID: <1478117854-8952-9-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1478117854-8952-1-git-send-email-madalin.bucur@nxp.com>
References: <1478117854-8952-1-git-send-email-madalin.bucur@nxp.com>
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
