Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F0AFB6F92
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 05:07:30 +1000 (EST)
Received: from mail39-va3 (localhost.localdomain [127.0.0.1])	by
	mail39-va3-R.bigfish.com (Postfix) with ESMTP id D98BF1138396	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 19:07:25 +0000 (UTC)
Received: from VA3EHSMHS011.bigfish.com (unknown [10.7.14.236])	by
	mail39-va3.bigfish.com (Postfix) with ESMTP id 3EDB66E027C	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 19:06:19 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: add hypervisor config entries to
	corenet_smp_defconfig
Date: Tue, 14 Jun 2011 14:06:15 -0500
Message-ID: <1308078375-27245-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_PPC_EPAPR_HV_BYTECHAN adds support for the Freescale hypervisor
byte channel tty driver.

CONFIG_VIRT_DRIVERS and CONFIG_FSL_HV_MANAGER add support for the Freescale
hypervisor management driver.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index de9bd16..75fd124 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -108,6 +108,7 @@ CONFIG_FSL_PQ_MDIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_LEGACY_PTYS is not set
+CONFIG_PPC_EPAPR_HV_BYTECHAN=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EXTENDED=y
@@ -149,6 +150,8 @@ CONFIG_STAGING=y
 CONFIG_HUGETLBFS=y
 CONFIG_HUGETLB_PAGE=y
 # CONFIG_STAGING_EXCLUDE_BUILD is not set
+CONFIG_VIRT_DRIVERS=y
+CONFIG_FSL_HV_MANAGER=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-- 
1.7.4.4
