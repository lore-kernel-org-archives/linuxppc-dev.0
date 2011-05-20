Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 405B6B75F9
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 16:09:47 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p4K69hB6001173
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 01:09:44 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/14] powerpc/qe: Limit QE support to ppc32
Date: Fri, 20 May 2011 01:09:31 -0500
Message-Id: <1305871771-16334-14-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1305871771-16334-13-git-send-email-galak@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-3-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-6-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-7-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-8-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-9-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-10-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-11-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-12-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-13-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only 32-bit SoCs have a QUICC Engine so limit the config option to PPC32.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index f970ca2..546ceea 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -266,7 +266,7 @@ config TAU_AVERAGE
 
 config QUICC_ENGINE
 	bool "Freescale QUICC Engine (QE) Support"
-	depends on FSL_SOC
+	depends on FSL_SOC && PPC32
 	select PPC_LIB_RHEAP
 	select CRC32
 	help
-- 
1.7.3.4
