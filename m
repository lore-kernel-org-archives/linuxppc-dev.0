Return-Path: <krzk@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z5cNY6GdRzDqXw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Dec 2017 00:32:29 +1100 (AEDT)
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [RESEND PATCH] powerpc: defconfig: Cleanup from old Kconfig options
Date: Tue, 26 Dec 2017 14:32:21 +0100
Message-Id: <1514295143-28642-1-git-send-email-krzk@kernel.org>
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
 arch/powerpc/configs/c2k_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index f1552af9eecc..dbd7b12a23fc 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -297,7 +297,6 @@ CONFIG_USB_EMI62=m
 CONFIG_USB_RIO500=m
 CONFIG_USB_LEGOTOWER=m
 CONFIG_USB_LCD=m
-CONFIG_USB_LED=m
 CONFIG_USB_TEST=m
 CONFIG_USB_ATM=m
 CONFIG_USB_SPEEDTOUCH=m
-- 
2.7.4
