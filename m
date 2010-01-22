Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id A5249B7CD8
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Jan 2010 07:25:14 +1100 (EST)
Date: Fri, 22 Jan 2010 21:18:22 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCH/RFC 2/2] 5200: improve i2c bus error recovery
To: Linux PPC Development <linuxppc-dev@ozlabs.org>, Devicetree Discussions
	<devicetree-discuss@lists.ozlabs.org>, "Ben Dooks (embedded platforms)"
	<ben-linux@fluff.org>
Message-Id: <1264191502.2224.2@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make the I2C adapter timeout configurable through a Device Tree property
which gives the timeout in microseconds.

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

---

--- linux-2.6.32-orig/Documentation/powerpc/dts-bindings/fsl/i2c.txt	2009-1=
2-03 04:51:21.000000000 +0100
+++ linux-2.6.32/Documentation/powerpc/dts-bindings/fsl/i2c.txt	2010-01-22 =
16:04:56.000000000 +0100
@@ -21,6 +21,7 @@
  - fsl,preserve-clocking : boolean; if defined, the clock settings
    from the bootloader are preserved (not touched).
  - clock-frequency : desired I2C bus clock frequency in Hz.
+ - timeout : I2C timeout in microseconds.
=20
 Examples :
=20
