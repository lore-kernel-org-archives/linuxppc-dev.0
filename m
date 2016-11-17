Return-Path: <fl@n621.de>
Received: from nyx.n621.de (nyx.n621.de [176.9.182.227])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKHL46JtszDvsn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 21:24:28 +1100 (AEDT)
From: Florian Larysch <fl@n621.de>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 Florian Larysch <fl@n621.de>
Subject: [PATCH v2 2/2] DT: i2c: W83793 is a trivial device
Date: Thu, 17 Nov 2016 11:23:24 +0100
Message-Id: <20161117102324.18319-3-fl@n621.de>
In-Reply-To: <20161117102324.18319-1-fl@n621.de>
References: <20161117102324.18319-1-fl@n621.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Florian Larysch <fl@n621.de>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index fbbad64..c65aff0 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -158,4 +158,5 @@ ti,tsc2003		I2C Touch-Screen Controller
 ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
 ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
 ti,tmp275		Digital Temperature Sensor
+winbond,w83793		Winbond/Nuvoton H/W Monitor
 winbond,wpct301		i2c trusted platform module (TPM)
-- 
2.10.2
