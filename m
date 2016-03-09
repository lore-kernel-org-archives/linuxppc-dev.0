Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0085.outbound.protection.outlook.com [157.56.110.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B8621A009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 12:30:48 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <robh+dt@kernel.org>
CC: <oss@buserror.net>, <leoyang.li@nxp.com>, <xiaobo.xie@nxp.com>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v5 3/7] QE: Add uqe_serial document to bindings
Date: Wed, 9 Mar 2016 09:21:30 +0800
Message-ID: <1457486494-11377-3-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1457486494-11377-1-git-send-email-qiang.zhao@nxp.com>
References: <1457486494-11377-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add uqe_serial document to
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2
	- modify tx/rx-clock-name specification
Changes for v3
	- NA 
Changes for v4
	- drop device_type
	- modify to SoC specific compatible 
Changes for v5
	- add fsl to compatible as prefix 

 .../bindings/powerpc/fsl/cpm_qe/uqe_serial.txt         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
new file mode 100644
index 0000000..5dc3089
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
@@ -0,0 +1,18 @@
+* Serial
+
+Currently defined compatibles:
+- fsl,t1040-ucc-uart
+
+Properties for fsl,t1040-ucc-uart:
+port-number : port number of UCC-UART
+tx/rx-clock-name : should be "brg1"-"brg16" for internal clock source,
+		   should be "clk1"-"clk28" for external clock source.
+
+Example:
+
+	ucc_serial: ucc@2200 {
+		compatible = "fsl,t1040-ucc-uart";
+		port-number = <0>;
+		rx-clock-name = "brg2";
+		tx-clock-name = "brg2";
+	};
-- 
2.1.0.27.g96db324
