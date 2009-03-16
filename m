Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id CCE34DDF83
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 20:03:54 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 4C7D41C01F4C
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 09:56:28 +0100 (CET)
Received: from lancy.denx.de (p4FE63FB4.dip.t-dialin.net [79.230.63.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 4BE48901D9
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 09:56:27 +0100 (CET)
Message-ID: <49BE143A.6020109@grandegger.com>
Date: Mon, 16 Mar 2009 09:56:26 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] PowerPC: MPC85xx: TQM85xx: correct address of LM75 I2C
	device nodes
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 0f73a449a649acfca91404a98a35353a618b9555 added I2C device nodes
for the LM75 thermal sensor on the TQM85xx modules, unfortunately with
the wrong I2C address. The LM75s are located at address 0x48.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/tqm8540.dts          |    4 ++--
 arch/powerpc/boot/dts/tqm8541.dts          |    4 ++--
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |    4 ++--
 arch/powerpc/boot/dts/tqm8548.dts          |    4 ++--
 arch/powerpc/boot/dts/tqm8555.dts          |    4 ++--
 arch/powerpc/boot/dts/tqm8560.dts          |    4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index 39e55ab..da137d8 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -84,9 +84,9 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
-			dtt@50 {
+			dtt@48 {
 				compatible = "national,lm75";
-				reg = <0x50>;
+				reg = <0x48>;
 			};
 
 			rtc@68 {
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index 58ae8bc..b25fc4c 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -83,9 +83,9 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
-			dtt@50 {
+			dtt@48 {
 				compatible = "national,lm75";
-				reg = <0x50>;
+				reg = <0x48>;
 			};
 
 			rtc@68 {
diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index bff380a..dd43dbe 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -85,9 +85,9 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
-			dtt@50 {
+			dtt@48 {
 				compatible = "national,lm75";
-				reg = <0x50>;
+				reg = <0x48>;
 			};
 
 			rtc@68 {
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index 112ac90..b949a8c 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -85,9 +85,9 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
-			dtt@50 {
+			dtt@48 {
 				compatible = "national,lm75";
-				reg = <0x50>;
+				reg = <0x48>;
 			};
 
 			rtc@68 {
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index 4b7da89..fd3777e 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -83,9 +83,9 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
-			dtt@50 {
+			dtt@48 {
 				compatible = "national,lm75";
-				reg = <0x50>;
+				reg = <0x48>;
 			};
 
 			rtc@68 {
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index 3fa552f..89a7beb 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -85,9 +85,9 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
-			dtt@50 {
+			dtt@48 {
 				compatible = "national,lm75";
-				reg = <0x50>;
+				reg = <0x48>;
 			};
 
 			rtc@68 {
-- 
1.6.0.6
