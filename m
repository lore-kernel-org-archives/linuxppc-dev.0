Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4046CDDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 02:40:45 +1100 (EST)
Date: Wed, 28 Nov 2007 09:39:08 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH][DTC] Fix whitespace in libfdt/fdt.h
Message-ID: <Pine.LNX.4.64.0711280938440.3013@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Take from u-boot whitespace fixup of the file

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 libfdt/fdt.h |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/libfdt/fdt.h b/libfdt/fdt.h
index e00559a..48ccfd9 100644
--- a/libfdt/fdt.h
+++ b/libfdt/fdt.h
@@ -4,22 +4,22 @@
 #ifndef __ASSEMBLY__

 struct fdt_header {
-	uint32_t magic;                  /* magic word FDT_MAGIC */
-	uint32_t totalsize;              /* total size of DT block */
-	uint32_t off_dt_struct;          /* offset to structure */
-	uint32_t off_dt_strings;         /* offset to strings */
-	uint32_t off_mem_rsvmap;         /* offset to memory reserve map */
-	uint32_t version;                /* format version */
-	uint32_t last_comp_version;      /* last compatible version */
-
-        /* version 2 fields below */
-	uint32_t boot_cpuid_phys;        /* Which physical CPU id we're
+	uint32_t magic;			 /* magic word FDT_MAGIC */
+	uint32_t totalsize;		 /* total size of DT block */
+	uint32_t off_dt_struct;		 /* offset to structure */
+	uint32_t off_dt_strings;	 /* offset to strings */
+	uint32_t off_mem_rsvmap;	 /* offset to memory reserve map */
+	uint32_t version;		 /* format version */
+	uint32_t last_comp_version;	 /* last compatible version */
+
+	/* version 2 fields below */
+	uint32_t boot_cpuid_phys;	 /* Which physical CPU id we're
 					    booting on */
 	/* version 3 fields below */
-        uint32_t size_dt_strings;        /* size of the strings block */
+	uint32_t size_dt_strings;	 /* size of the strings block */

 	/* version 17 fields below */
-	uint32_t size_dt_struct;         /* size of the structure block */
+	uint32_t size_dt_struct;	 /* size of the structure block */
 };

 struct fdt_reserve_entry {
@@ -41,12 +41,12 @@ struct fdt_property {

 #endif /* !__ASSEMBLY */

-#define FDT_MAGIC	0xd00dfeed      /* 4: version, 4: total size */
+#define FDT_MAGIC	0xd00dfeed	/* 4: version, 4: total size */
 #define FDT_TAGSIZE	sizeof(uint32_t)

-#define FDT_BEGIN_NODE	0x1             /* Start node: full name */
-#define FDT_END_NODE	0x2             /* End node */
-#define FDT_PROP	0x3             /* Property: name off,
+#define FDT_BEGIN_NODE	0x1		/* Start node: full name */
+#define FDT_END_NODE	0x2		/* End node */
+#define FDT_PROP	0x3		/* Property: name off,
 					   size, content */
 #define FDT_NOP		0x4		/* nop */
 #define FDT_END		0x9
-- 
1.5.3.4
