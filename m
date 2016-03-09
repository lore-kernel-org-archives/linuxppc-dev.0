Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0077.outbound.protection.outlook.com [157.56.111.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6A9D1A009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 13:52:13 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <robh+dt@kernel.org>
CC: <oss@buserror.net>, <leoyang.li@nxp.com>, <xiaobo.xie@nxp.com>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v5 4/7] bindings: move cpm_qe binding from powerpc/fsl to
 soc/fsl
Date: Wed, 9 Mar 2016 09:21:31 +0800
Message-ID: <1457486494-11377-4-git-send-email-qiang.zhao@nxp.com>
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

cpm_qe is supported on both powerpc and arm.
and the QE code has been moved from arch/powerpc into
drivers/soc/fsl, so move cpm_qe binding from powerpc/fsl
to soc/fsl

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
Acked-by: Rob Herring<robh@kernel.org>
---
Changes for v3
	- NA
Changes for v4
	- NA
Changes for v5
	- NA

 Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm.txt     | 0
 Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/brg.txt | 0
 Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/i2c.txt | 0
 Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/pic.txt | 0
 Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/usb.txt | 0
 Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/gpio.txt    | 0
 Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/network.txt | 0
 Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe.txt      | 0
 .../devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/firmware.txt       | 0
 .../devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/par_io.txt         | 0
 .../devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/pincfg.txt         | 0
 Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/ucc.txt  | 0
 Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/usb.txt  | 0
 Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/serial.txt  | 0
 .../devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/uqe_serial.txt        | 0
 15 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/brg.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/i2c.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/pic.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/usb.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/gpio.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/network.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/firmware.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/par_io.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/pincfg.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/ucc.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/usb.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/serial.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/uqe_serial.txt (100%)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/cpm.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/cpm.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm/brg.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/cpm/brg.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm/brg.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/cpm/brg.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm/i2c.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/cpm/i2c.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm/i2c.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/cpm/i2c.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm/pic.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/cpm/pic.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm/pic.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/cpm/pic.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm/usb.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/cpm/usb.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm/usb.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/cpm/usb.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/gpio.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/gpio.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/gpio.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/gpio.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/firmware.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/firmware.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/firmware.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/firmware.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/par_io.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/par_io.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/par_io.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/par_io.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/pincfg.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/pincfg.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/pincfg.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/pincfg.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/ucc.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/ucc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/ucc.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/ucc.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/usb.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/usb.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/usb.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/usb.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/serial.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/serial.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/serial.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/serial.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/uqe_serial.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
rename to Documentation/devicetree/bindings/soc/fsl/cpm_qe/uqe_serial.txt
-- 
2.1.0.27.g96db324
