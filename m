Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id F04C1DED9D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 01:42:05 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1678anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:42:05 -0700 (PDT)
Message-Id: <6746a2a9b2c279d5f195d90b060d4c91edd7a128.1219160188.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Tue, 19 Aug 2008 11:27:05 -0400
Subject: [PATCH 9/9] powerpc/44x: Add explicit Yosemite support
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the Yosemite board to the explicitly supported list for ppc44x_simple
boards and remove the compatible entry for bamboo from the DTS file.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/yosemite.dts         |    2 +-
 arch/powerpc/platforms/44x/ppc44x_simple.c |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/yosemite.dts b/arch/powerpc/boot/dts/yosemite.dts
index e39422a..1fa3cb4 100644
--- a/arch/powerpc/boot/dts/yosemite.dts
+++ b/arch/powerpc/boot/dts/yosemite.dts
@@ -15,7 +15,7 @@
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "amcc,yosemite";
-	compatible = "amcc,yosemite","amcc,bamboo";
+	compatible = "amcc,yosemite";
 	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c b/arch/powerpc/platforms/44x/ppc44x_simple.c
index 4e78e04..43b8db9 100644
--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -49,6 +49,7 @@ static char *board[] __initdata = {
 	"amcc,rainier",
 	"amcc,sequoia",
 	"amcc,taishan",
+	"amcc,yosemite",
 	NULL
 };
 
-- 
1.5.5.1
