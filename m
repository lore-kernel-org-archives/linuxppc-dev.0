Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og108.obsmtp.com (exprod5og108.obsmtp.com [64.18.0.186])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF56ADE0EA
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 19:41:09 +1000 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc/86xx: Add I2C device mappings in DTS for SBC610
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Date: Tue, 19 May 2009 10:40:57 +0100
Message-ID: <20090519094057.11438.12921.stgit@ES-J7S4D2J>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mappings for temperature sensors (adt7461 and lm92) are missing from the
SBC610's DTS file.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc610.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index 6898d7e..85d1416 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -153,6 +153,16 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
+			hwmon@48 {
+				compatible = "national,lm92";
+				reg = <0x48>;
+			};
+
+			hwmon@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
 			rtc@51 {
 				compatible = "epson,rx8581";
 				reg = <0x00000051>;
