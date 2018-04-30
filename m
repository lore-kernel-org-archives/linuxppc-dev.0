Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZQrS6rZPzF2Pp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 23:49:28 +1000 (AEST)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Robin H. Johnson" <robbat2@gentoo.org>,
 Benjamin Gilbert <benjamin.gilbert@coreos.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc: wii_defconfig: Disable Ethernet driver support
 code
Date: Mon, 30 Apr 2018 15:42:46 +0200
Message-Id: <20180430134252.17345-1-j.neuschaefer@gmx.net>
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

The Wii doesn't have built-in Ethernet and USB Ethernet adapters are in
a different menu. Disable CONFIG_ETHERNET to save some space in support
code for Ethernet drivers.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-367 (-367)
Function                                     old     new   delta
kernel_config_data                         13691   13324    -367
Total: Before=8341718, After=8341351, chg -0.00%

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/configs/wii_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 0b0f78823a1b..3167b9d7f3e5 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -49,6 +49,7 @@ CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
+# CONFIG_ETHERNET is not set
 CONFIG_B43=y
 CONFIG_B43_SDIO=y
 # CONFIG_B43_PHY_LP is not set
-- 
2.17.0
