Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQ07N2ZR4zF0Xc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 16:17:51 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 5/6] powerpc: wii.dts: Add ngpios property
Date: Mon, 22 Jan 2018 06:04:10 +0100
Message-Id: <20180122050411.32460-6-j.neuschaefer@gmx.net>
In-Reply-To: <20180122050411.32460-1-j.neuschaefer@gmx.net>
References: <20180122050411.32460-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Hollywood GPIO controller supports 32 GPIOs, but on the Wii, only 24
are used.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2:
- no change
---
 arch/powerpc/boot/dts/wii.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index 40b324b6391e..7235e375919c 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -176,6 +176,7 @@
 			compatible = "nintendo,hollywood-gpio";
 			reg = <0x0d8000c0 0x40>;
 			gpio-controller;
+			ngpios = <24>;
 
 			/*
 			 * This is commented out while a standard binding
-- 
2.15.1
