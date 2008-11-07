Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-6.online-age.net (ext-cn0ut-6.online-age.net
	[63.210.253.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 53DE7DDE3A
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 00:43:23 +1100 (EST)
Received: from int-cn0ut-7.online-age.net (int-cn0ut-7.online-age.net
	[3.159.252.76])
	by ext-cn0ut-6.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id mA7DhHm8005707
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Nov 2008 08:43:17 -0500
Received: from alpmlip01.e2k.ad.ge.com (int-cn0ut-7.online-age.net
	[3.159.252.76])
	by int-cn0ut-7.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id mA7DhHg9001695
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Nov 2008 08:43:17 -0500
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc/86xx: Correct SOC bus-frequency in GE Fanuc SBC610 DTS
To: linuxppc-dev@ozlabs.org
Date: Fri, 07 Nov 2008 13:43:43 +0000
Message-ID: <20081107134343.7844.77855.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch corrects the bus-frequency value provided in the SBC610's dts.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc610.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index fd2b606..1f7833c 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -114,7 +114,7 @@
 		compatible = "simple-bus";
 		ranges = <0x0 0xfef00000 0x00100000>;
 		reg = <0xfef00000 0x100000>;	// CCSRBAR 1M
-		bus-frequency = <0>;
+		bus-frequency = <33333333>;
 
 		i2c1: i2c@3000 {
 			#address-cells = <1>;
