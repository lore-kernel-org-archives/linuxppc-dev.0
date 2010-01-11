Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og101.obsmtp.com (exprod5og101.obsmtp.com [64.18.0.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9025BB7F48
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 23:25:46 +1100 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 2/8] powerpc/86xx: Fix GE SBC310 XMC site support
To: galak@kernel.crashing.org
Date: Mon, 11 Jan 2010 12:23:18 +0000
Message-ID: <20100111122318.8306.15704.stgit@ES-J7S4D2J.amer.consind.ge.com>
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

From: Malcolm Crossley <malcolm.crossley2@gefanuc.com>

Correction to interrupt map mask for GE SBC310 XMC site and addition of
alias.

Signed-off-by: Malcolm Crossley <malcolm.crossley2@gefanuc.com>
Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc310.dts |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/gef_sbc310.dts
index 8ea8d4a..8e4efff 100644
--- a/arch/powerpc/boot/dts/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/gef_sbc310.dts
@@ -32,6 +32,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		pci1 = &pci1;
 	};
 
 	cpus {
@@ -374,7 +375,7 @@
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <0x18 0x2>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
 		interrupt-map = <
 			0x0000 0x0 0x0 0x1 &mpic 0x0 0x2
 			0x0000 0x0 0x0 0x2 &mpic 0x1 0x2


--
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 927559189
