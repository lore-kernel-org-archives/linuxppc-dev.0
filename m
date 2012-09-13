Return-Path: <emillbrandt@norco.coldhaus.com>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "norco.coldhaus.com",
 Issuer "StartCom Class 1 Primary Intermediate Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF9E12C0092
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 07:43:30 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 1/7] powerpc/52xx: define FSL_SOC
Date: Thu, 13 Sep 2012 17:43:10 -0400
Message-Id: <1347572596-37540-2-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc52xx socs need to have FSL_SOC defined to build their drivers (i2c-mpc, ASoC)

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 90f4496..fb35944 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -1,6 +1,7 @@
 config PPC_MPC52xx
 	bool "52xx-based boards"
 	depends on 6xx
+	select FSL_SOC
 	select PPC_CLOCK
 	select PPC_PCI_CHOICE
 
-- 
1.7.2.5
