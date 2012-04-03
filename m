Return-Path: <mla@apm.com>
Received: from exprod5og106.obsmtp.com (exprod5og106.obsmtp.com [64.18.0.182])
 by ozlabs.org (Postfix) with SMTP id 9A480B6FF0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2012 13:21:18 +1000 (EST)
Received: by dady13 with SMTP id y13so4131043dad.27
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Apr 2012 20:21:15 -0700 (PDT)
From: Mai La <mla@apm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Tirumala R Marri <tmarri@apm.com>,
 Grant Likely <grant.likely@secretlab.ca>,
 Michael Neuling <mikey@neuling.org>,
 Kumar Gala <galak@kernel.crashing.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v1] powerpc/44x: Support CPM for Maui APM821xxx SoC and
 Bluestone board
Date: Tue,  3 Apr 2012 10:20:53 +0700
Message-Id: <1333423253-12170-1-git-send-email-mla@apm.com>
Cc: Mai La <mla@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In this patch:
- Add CPM node for Maui APM821xxx SoC and Bluestone board in DTS

Signed-off-by: Mai La <mla@apm.com>

---
v1: 
Per Grant Likely's comment:
* Fix typo

---
 arch/powerpc/boot/dts/bluestone.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bluestone.dts
index 2a56a0d..15a9516 100644
--- a/arch/powerpc/boot/dts/bluestone.dts
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -117,6 +117,15 @@
 		dcr-reg = <0x00c 0x002>;
 	};
 
+	CPM0: cpm {
+		compatible = "ibm,cpm-apm821xx", "ibm,cpm";
+		cell-index = <0>;
+		dcr-reg = <0x160 0x003>;
+		er-offset = <0>;
+		idle-doze = <0x02000000>;
+		standby = <0x302570F0>;
+	};
+
 	plb {
 		compatible = "ibm,plb4";
 		#address-cells = <2>;
-- 
1.7.3.4
