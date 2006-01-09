Return-Path: <grant.likely@secretlab.ca>
Received: from localhost.localdomain (S0106001346b91f0f.cg.shawcable.net
	[68.147.210.21]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 714CB689E3
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 19:33:07 +1100 (EST)
In-Reply-To: <11367955793438-git-send-email-grant.likely@secretlab.ca>
Date: Mon, 9 Jan 2006 01:33:01 -0700
Message-Id: <11367955811900-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: glikely@gmail.com, mporter@kernel.crashing.org,
	linuxppc-embedded@ozlabs.org, gnathita@gmail.com, dhlii@dlasys.net
From: grant.likely@secretlab.ca
Subject: [PATCH 08/10] ML300 & ML403 need embed_config.o linked in
Reply-To: grant.likely@secretlab.ca
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>

---

 arch/ppc/boot/simple/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

a39144d5708c207f58964000baf56fa9cfb18628
diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
index f3e9c53..7abd772 100644
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -188,6 +188,8 @@ OBJCOPY_ARGS			:= -O elf32-powerpc
 boot-y				:= head.o relocate.o $(extra.o-y) $(misc-y)
 boot-$(CONFIG_REDWOOD_5)	+= embed_config.o
 boot-$(CONFIG_REDWOOD_6)	+= embed_config.o
+boot-$(CONFIG_XILINX_ML300)	+= embed_config.o
+boot-$(CONFIG_XILINX_ML403)	+= embed_config.o
 boot-$(CONFIG_8xx)		+= embed_config.o
 boot-$(CONFIG_8260)		+= embed_config.o
 boot-$(CONFIG_BSEIP)		+= iic.o
-- 
1.0.6-g58e3
