Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40flDN6mz4zF1SC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 00:21:40 +1000 (AEST)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Robin H. Johnson" <robbat2@gentoo.org>,
 Benjamin Gilbert <benjamin.gilbert@coreos.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] powerpc: wii_defconfig: Disable BCMA support
Date: Mon,  7 May 2018 16:20:19 +0200
Message-Id: <20180507142019.32669-5-j.neuschaefer@gmx.net>
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

The B43 driver only needs CONFIG_SSB to support the WLAN card found in
the Wii. Configure it accordingly, and disable BCMA bus support to save
a bit of space.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2:
- Patch added to the series
---
 arch/powerpc/configs/wii_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index a674dd420f0f..10940533da71 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -51,6 +51,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 # CONFIG_ETHERNET is not set
 CONFIG_B43=y
+CONFIG_B43_BUSES_SSB=y
 CONFIG_B43_SDIO=y
 # CONFIG_B43_PHY_LP is not set
 CONFIG_B43_DEBUG=y
-- 
2.17.0
