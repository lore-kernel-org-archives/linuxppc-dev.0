Return-Path: <wei.zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3E9E4DDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 13:31:47 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org
Subject: [PATCH 2/5] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Tue, 22 May 2007 11:38:27 +0800
Message-Id: <1179805110272-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11798051101543-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add uli1575 pci-bridge sector. It fixes the issue of ULI1575 not found on rev.2 board.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts      |    6 ++++++
 arch/powerpc/boot/dts/mpc8641_hpcn_srio.dts |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 260b264..04626b1 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -297,6 +297,12 @@
 				interrupts = <49 2>;
 				interrupt-parent = <&mpic>;
 			};
+			uli1575: uli1575@100 {
+				reg = <0 0 0 0 0>;
+				pci_bridge@200 {
+					reg = <0 0 0 0 0>;
+				};
+			};
 
 		};
 
-- 
1.5.1
