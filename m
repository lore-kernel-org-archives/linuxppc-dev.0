Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C915DE206
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 08:27:26 +1100 (EST)
Message-Id: <200803282121.m2SLLM93010742@imap1.linux-foundation.org>
Subject: [patch 24/24] rapidio: fix docbook references
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Fri, 28 Mar 2008 14:21:22 -0700
Cc: randy.dunlap@oracle.com, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix rapidio docbook (file was removed) and fix header file kernel-doc.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Zhang Wei <wei.zhang@freescale.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/DocBook/rapidio.tmpl |    1 -
 include/linux/rio.h                |    4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff -puN Documentation/DocBook/rapidio.tmpl~rapidio-fix-docbook-references Documentation/DocBook/rapidio.tmpl
--- a/Documentation/DocBook/rapidio.tmpl~rapidio-fix-docbook-references
+++ a/Documentation/DocBook/rapidio.tmpl
@@ -133,7 +133,6 @@
 !Idrivers/rapidio/rio-sysfs.c
      </sect1>
      <sect1 id="PPC32_support"><title>PPC32 support</title>
-!Iarch/powerpc/kernel/rio.c
 !Earch/powerpc/sysdev/fsl_rio.c
 !Iarch/powerpc/sysdev/fsl_rio.c
      </sect1>
diff -puN include/linux/rio.h~rapidio-fix-docbook-references include/linux/rio.h
--- a/include/linux/rio.h~rapidio-fix-docbook-references
+++ a/include/linux/rio.h
@@ -327,7 +327,7 @@ struct rio_route_ops {
 };
 
 /**
- * Struct for RIO memory definition.
+ * struct rio_mem - struct for RIO memory definition.
  * @node: Node in list of memories
  * @virt: The virtual address for mapped memory accessing.
  * @owner: The owner id of this memory.
@@ -346,7 +346,7 @@ struct rio_mem {
 };
 
 /**
- * Struct for RIO memory definition.
+ * struct rio_mem_ops - Struct for RIO memory operations definition.
  * @map_inb: The function for mapping inbound memory window.
  * @map_outb: The function for mapping outbound memory window.
  * @unmap_inb: The function for unmapping inbound memory window.
_
