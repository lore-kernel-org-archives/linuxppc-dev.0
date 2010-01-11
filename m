Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og108.obsmtp.com (exprod5og108.obsmtp.com [64.18.0.186])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1307BB8759
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 23:26:10 +1100 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 6/8] powerpc/86xx: Add MSI section to GE PPC9A DTS
To: galak@kernel.crashing.org
Date: Mon, 11 Jan 2010 12:23:44 +0000
Message-ID: <20100111122344.8306.40544.stgit@ES-J7S4D2J.amer.consind.ge.com>
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

Add the MSI section to the DTS file for the GE PPC9A.
    
    Signed-off-by: Malcolm Crossley <malcolm.crossley2@gefanuc.com>
    Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_ppc9a.dts |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_ppc9a.dts b/arch/powerpc/boot/dts/gef_ppc9a.dts
index c86114e..977f260 100644
--- a/arch/powerpc/boot/dts/gef_ppc9a.dts
+++ b/arch/powerpc/boot/dts/gef_ppc9a.dts
@@ -341,6 +341,22 @@
 			device_type = "open-pic";
 		};
 
+		msi@41600 {
+			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
 		global-utilities@e0000 {
 			compatible = "fsl,mpc8641-guts";
 			reg = <0xe0000 0x1000>;


--
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 927559189
