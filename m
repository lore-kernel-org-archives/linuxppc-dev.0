Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og109.obsmtp.com (exprod5og109.obsmtp.com [64.18.0.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89C5CDDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 02:24:35 +1000 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc/86xx: Add device_type entry to soc for ppc9a
To: galak@kernel.crashing.org
Date: Mon, 27 Apr 2009 17:24:28 +0100
Message-ID: <20090427162428.8133.23523.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 'device_type = "soc";' line *is* needed in the DTS for get_immrbase()
to return the correct address.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_ppc9a.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_ppc9a.dts b/arch/powerpc/boot/dts/gef_ppc9a.dts
index d47ad07..53a7a62 100644
--- a/arch/powerpc/boot/dts/gef_ppc9a.dts
+++ b/arch/powerpc/boot/dts/gef_ppc9a.dts
@@ -161,6 +161,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
+		device_type = "soc";
 		compatible = "fsl,mpc8641-soc", "simple-bus";
 		ranges = <0x0 0xfef00000 0x00100000>;
 		reg = <0xfef00000 0x100000>;	// CCSRBAR 1M
