Return-Path: <camelia.groza@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Vwdp56zDzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 21:58:21 +1000 (AEST)
From: Camelia Groza <camelia.groza@nxp.com>
To: robh+dt@kernel.org,
	mark.rutland@arm.com,
	benh@kernel.crashing.org
Cc: paulus@samba.org, mpe@ellerman.id.au, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Camelia Groza <camelia.groza@nxp.com>
Subject: [PATCH 1/3] powerpc/configs/dpaa: enable the Cortina PHY driver
Date: Wed, 18 Jul 2018 14:46:49 +0300
Message-Id: <d372017b89bd1c5da5d9d3e7e6b3ddce69158181.1531903211.git.camelia.groza@nxp.com>
In-Reply-To: <cover.1531903211.git.camelia.groza@nxp.com>
References: <cover.1531903211.git.camelia.groza@nxp.com>
In-Reply-To: <cover.1531903211.git.camelia.groza@nxp.com>
References: <cover.1531903211.git.camelia.groza@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cortina PHYs are present on T4240RDB and T2080RDB. Enable the driver
by default.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
 arch/powerpc/configs/dpaa.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/dpaa.config b/arch/powerpc/configs/dpaa.config
index 2fe76f5..4ffacaf 100644
--- a/arch/powerpc/configs/dpaa.config
+++ b/arch/powerpc/configs/dpaa.config
@@ -2,3 +2,4 @@ CONFIG_FSL_DPAA=y
 CONFIG_FSL_PAMU=y
 CONFIG_FSL_FMAN=y
 CONFIG_FSL_DPAA_ETH=y
+CONFIG_CORTINA_PHY=y
-- 
1.9.1
