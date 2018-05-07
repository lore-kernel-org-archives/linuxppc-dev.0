Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40flCY0pDVzF1QZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 00:20:55 +1000 (AEST)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 0/4] powerpc: wii_defconfig updates
Date: Mon,  7 May 2018 16:20:15 +0200
Message-Id: <20180507142019.32669-1-j.neuschaefer@gmx.net>
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

v1: https://www.spinics.net/lists/kernel/msg2790389.html
    https://www.spinics.net/lists/kernel/msg2790385.html

In the previous version of patch 2, I forgot to set CONFIG_NEW_LEDS and
CONFIG_LEDS_TRIGGERS, so the more specific LED-related options weren't
actually enabled, due to Kconfig dependencies. This is now fixed.

I took the opportunity of a v2 to add two more patches that I wanted to
send anyway. The SDHCIs in the Wii are currently unusable due to bugs/
problems in the flipper-pic/hlwd-pic drivers, but I know how to fix
those, and will send patches.

Jonathan Neuschäfer (4):
  powerpc: wii_defconfig: Disable Ethernet driver support code
  powerpc: wii_defconfig: Enable GPIO-related options
  powerpc: wii_defconfig: Enable Wii SDHCI driver
  powerpc: wii_defconfig: Disable BCMA support

 arch/powerpc/configs/wii_defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.17.0
