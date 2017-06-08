Return-Path: <krzk@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk9VH4nNTzDqN6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 02:14:31 +1000 (AEST)
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 21/35] powerpc: defconfig: Cleanup from old Kconfig options
Date: Thu,  8 Jun 2017 18:10:32 +0200
Message-Id: <20170608161049.12421-21-krzk@kernel.org>
In-Reply-To: <20170608160836.12196-1-krzk@kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove old, dead Kconfig option USB_LED. It is gone since
commit a335aaf3125c ("usb: misc: remove outdated USB LED driver").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/powerpc/configs/c2k_defconfig    | 1 -
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index 7c9d95370150..10f5ffd08956 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -298,7 +298,6 @@ CONFIG_USB_EMI62=m
 CONFIG_USB_RIO500=m
 CONFIG_USB_LEGOTOWER=m
 CONFIG_USB_LCD=m
-CONFIG_USB_LED=m
 CONFIG_USB_TEST=m
 CONFIG_USB_ATM=m
 CONFIG_USB_SPEEDTOUCH=m
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 18d0d60dadbf..f170744738cf 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -967,7 +967,6 @@ CONFIG_USB_ADUTUX=m
 CONFIG_USB_SEVSEG=m
 CONFIG_USB_LEGOTOWER=m
 CONFIG_USB_LCD=m
-CONFIG_USB_LED=m
 CONFIG_USB_IDMOUSE=m
 CONFIG_USB_FTDI_ELAN=m
 CONFIG_USB_APPLEDISPLAY=m
-- 
2.9.3
