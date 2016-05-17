Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0058.outbound.protection.outlook.com [157.56.111.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r82JL5QDxzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:05:22 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <oss@buserror.net>
CC: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <xiaobo.xie@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v6 3/7] QE: Add uqe_serial document to bindings
Date: Tue, 17 May 2016 10:38:59 +0800
Message-ID: <1463452743-21462-3-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1463452743-21462-1-git-send-email-qiang.zhao@nxp.com>
References: <1463452743-21462-1-git-send-email-qiang.zhao@nxp.com>
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
Changes for v6
	- modify property to "fsl,<chip>-ucc-uart"

 .../bindings/powerpc/fsl/cpm_qe/uqe_serial.txt          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
new file mode 100644
index 0000000..8823c86
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
@@ -0,0 +1,17 @@
+* Serial
+
+Required Properties:
+compatible : must be "fsl,<chip>-ucc-uart". For t1040, must be
+"fsl,t1040-ucc-uart".
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
