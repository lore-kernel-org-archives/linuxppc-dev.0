Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40flDX6N31zF1RC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 00:21:48 +1000 (AEST)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Gilbert <benjamin.gilbert@coreos.com>,
 "Robin H. Johnson" <robbat2@gentoo.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] powerpc: wii_defconfig: Enable Wii SDHCI driver
Date: Mon,  7 May 2018 16:20:18 +0200
Message-Id: <20180507142019.32669-4-j.neuschaefer@gmx.net>
In-Reply-To: <20180507142019.32669-1-j.neuschaefer@gmx.net>
References: <20180507142019.32669-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows access to the SD card and the BCM4318 Wifi module.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

Note that until some fixes in the interrupt controller drivers used on
the Wii, the SDHCI controllers will not be usable.

v2:
- Patch added to the series
---
 arch/powerpc/configs/wii_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index c5933a38e5ad..a674dd420f0f 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -93,6 +93,8 @@ CONFIG_HID_APPLE=m
 CONFIG_HID_WACOM=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_HLWD=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
2.17.0
