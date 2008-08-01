Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF6D9DEDAE
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 02:44:30 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/10] rtc: use CONFIG_PPC instead of CONFIG_PPC_MERGE
Date: Fri,  1 Aug 2008 11:44:15 -0500
Message-Id: <1217609060-6381-6-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1217609060-6381-5-git-send-email-galak@kernel.crashing.org>
References: <1217609060-6381-1-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-2-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-3-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-4-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-5-git-send-email-galak@kernel.crashing.org>
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that arch/ppc is dead CONFIG_PPC_MERGE is always defined for all
powerpc platforms and we want to get rid of it use CONFIG_PPC instead.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/rtc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 90ab738..564a3ed 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -577,7 +577,7 @@ config RTC_DRV_RS5C313
 
 config RTC_DRV_PPC
        tristate "PowerPC machine dependent RTC support"
-       depends on PPC_MERGE
+       depends on PPC
        help
 	 The PowerPC kernel has machine-specific functions for accessing
 	 the RTC. This exposes that functionality through the generic RTC
-- 
1.5.5.1
