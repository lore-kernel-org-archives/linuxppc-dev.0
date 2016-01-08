Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0056.outbound.protection.outlook.com [157.56.111.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF24E1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 14:58:15 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
CC: <Priyanka.Jain@freescale.com>, <oss@buserror.net>, Zhao Qiang
 <qiang.zhao@nxp.com>
Subject: [PATCH 3/6] QE: Add uqe_serial document to bindings
Date: Fri, 8 Jan 2016 10:18:11 +0800
Message-ID: <1452219494-31947-3-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1452219494-31947-1-git-send-email-qiang.zhao@nxp.com>
References: <1452219494-31947-1-git-send-email-qiang.zhao@nxp.com>
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
 .../bindings/powerpc/fsl/cpm_qe/uqe_serial.txt       | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
new file mode 100644
index 0000000..e677599
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
@@ -0,0 +1,20 @@
+* Serial
+
+Currently defined compatibles:
+- ucc_uart
+
+Properties for ucc_uart:
+device_type : which type the device is
+port-number : port number of UCC-UART
+rx-clock-name : which clock QE use for RX
+tx-clock-name : which clock QE use for TX
+
+Example:
+
+	serial: ucc@2200 {
+		device_type = "serial";
+		compatible = "ucc_uart";
+		port-number = <1>;
+		rx-clock-name = "brg2";
+		tx-clock-name = "brg2";
+	};
-- 
2.1.0.27.g96db324
