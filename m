Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id A080CDDEDF
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 01:50:26 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so245097waf.9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 08:50:25 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/virtex: Add uImage to the default images list
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Date: Tue, 28 Apr 2009 09:50:23 -0600
Message-ID: <20090428155023.19405.44274.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

It is common to use U-Boot on Xilinx Virtex platforms.  This patch
ensures that CONFIG_DEFAULT_UIMAGE is selected for virtex

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/40x/Kconfig |    1 +
 arch/powerpc/platforms/44x/Kconfig |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 14e027f..f39c953 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -153,6 +153,7 @@ config 405GPR
 
 config XILINX_VIRTEX
 	bool
+	select DEFAULT_UIMAGE
 
 config XILINX_VIRTEX_II_PRO
 	bool
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index bf5c7ff..0d83a6a 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -246,6 +246,7 @@ config IBM440EP_ERR42
 # Xilinx specific config options.
 config XILINX_VIRTEX
 	bool
+	select DEFAULT_UIMAGE
 
 # Xilinx Virtex 5 FXT FPGA architecture, selected by a Xilinx board above
 config XILINX_VIRTEX_5_FXT
