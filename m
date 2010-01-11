Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48D1DB8098
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 23:26:19 +1100 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 7/8] powerpc/86xx: Enable VME driver on the GE PPC9A
To: galak@kernel.crashing.org
Date: Mon, 11 Jan 2010 12:23:50 +0000
Message-ID: <20100111122350.8306.41770.stgit@ES-J7S4D2J.amer.consind.ge.com>
In-Reply-To: <20100111121622.8306.87501.stgit@ES-J7S4D2J.amer.consind.ge.com>
References: <20100111121622.8306.87501.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable the VME driver (which is currently in staging) on the PPC9A

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/configs/86xx/gef_ppc9a_defconfig |   47 ++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
index 6cd2cd6..1a37b69 100644
--- a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
+++ b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
@@ -1499,7 +1499,52 @@ CONFIG_RTC_DRV_RX8581=y
 #
 # TI VLYNQ
 #
-# CONFIG_STAGING is not set
+CONFIG_STAGING=y
+# CONFIG_STAGING_EXCLUDE_BUILD is not set
+# CONFIG_ET131X is not set
+# CONFIG_ME4000 is not set
+# CONFIG_MEILHAUS is not set
+# CONFIG_USB_IP_COMMON is not set
+# CONFIG_ECHO is not set
+# CONFIG_COMEDI is not set
+# CONFIG_ASUS_OLED is not set
+# CONFIG_ALTERA_PCIE_CHDMA is not set
+# CONFIG_INPUT_MIMIO is not set
+# CONFIG_TRANZPORT is not set
+
+#
+# Android
+#
+# CONFIG_ANDROID is not set
+# CONFIG_DST is not set
+# CONFIG_POHMELFS is not set
+# CONFIG_B3DFG is not set
+# CONFIG_IDE_PHISON is not set
+# CONFIG_PLAN9AUTH is not set
+# CONFIG_HECI is not set
+# CONFIG_USB_CPC is not set
+
+#
+# Qualcomm MSM Camera And Video
+#
+
+#
+# Camera Sensor Selection
+#
+# CONFIG_HYPERV_STORAGE is not set
+# CONFIG_HYPERV_BLOCK is not set
+# CONFIG_HYPERV_NET is not set
+CONFIG_VME_BUS=y
+
+#
+# VME Bridge Drivers
+#
+CONFIG_VME_TSI148=y
+
+#
+# VME Device Drivers
+#
+# CONFIG_VME_USER is not set
 
 #
 # File systems


--
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 927559189
