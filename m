Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og107.obsmtp.com (exprod5og107.obsmtp.com [64.18.0.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4419BDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 02:58:00 +1100 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc/86xx: Correct local bus registers in GE Fanuc SBC610
	dts file
To: linuxppc-dev@ozlabs.org
Date: Fri, 27 Feb 2009 15:53:10 +0000
Message-ID: <20090227155310.7771.96519.stgit@ubuntu8041.localdomain>
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

The registers for the local bus are incorrectly set to 0xf8005000 rather
than there actual location of 0xfef05000.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc610.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index c3978b5..34570bd 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -71,7 +71,7 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc8641-localbus", "simple-bus";
-		reg = <0xf8005000 0x1000>;
+		reg = <0xfef05000 0x1000>;
 		interrupts = <19 2>;
 		interrupt-parent = <&mpic>;
 
