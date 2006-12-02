Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 73AC967BB3
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 19:45:56 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev@ozlabs.org
Subject: [LIBFDT] Fixup byteswapping code
Date: Sat,  2 Dec 2006 01:45:40 -0700
Message-Id: <11650491414017-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 libfdt.h |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/libfdt.h b/libfdt.h
index 3872eea..8216655 100644
--- a/libfdt.h
+++ b/libfdt.h
@@ -45,16 +45,16 @@ #define FDT_ERR_EXISTS		15
 
 #define FDT_ERR_MAX		14
 
-#define fdt_magic(fdt)			(fdt32_to_cpu(fdt)->magic)
-#define fdt_totalsize(fdt)		(fdt32_to_cpu(fdt)->totalsize)
-#define fdt_off_dt_struct(fdt)		(fdt32_to_cpu(fdt)->off_dt_struct)
-#define fdt_off_dt_strings(fdt)		(fdt32_to_cpu(fdt)->off_dt_strings)
-#define fdt_off_mem_rsvmap(fdt)		(fdt32_to_cpu(fdt)->off_mem_rsvmap)
-#define fdt_version(fdt)		(fdt32_to_cpu(fdt)->version)
-#define fdt_last_comp_version(fdt)	(fdt32_to_cpu(fdt)->last_comp_version)
-#define fdt_boot_cpuid_phys(fdt)	(fdt32_to_cpu(fdt)->boot_cpuid_phys)
-#define fdt_size_dt_strings(fdt)	(fdt32_to_cpu(fdt)->size_dt_strings)
-#define fdt_size_dt_struct(fdt)		(fdt32_to_cpu(fdt)->size_dt_struct)
+#define fdt_magic(fdt)			(fdt32_to_cpu(fdt->magic))
+#define fdt_totalsize(fdt)		(fdt32_to_cpu(fdt->totalsize))
+#define fdt_off_dt_struct(fdt)		(fdt32_to_cpu(fdt->off_dt_struct))
+#define fdt_off_dt_strings(fdt)		(fdt32_to_cpu(fdt->off_dt_strings))
+#define fdt_off_mem_rsvmap(fdt)		(fdt32_to_cpu(fdt->off_mem_rsvmap))
+#define fdt_version(fdt)		(fdt32_to_cpu(fdt->version))
+#define fdt_last_comp_version(fdt)	(fdt32_to_cpu(fdt->last_comp_version))
+#define fdt_boot_cpuid_phys(fdt)	(fdt32_to_cpu(fdt->boot_cpuid_phys))
+#define fdt_size_dt_strings(fdt)	(fdt32_to_cpu(fdt->size_dt_strings))
+#define fdt_size_dt_struct(fdt)		(fdt32_to_cpu(fdt->size_dt_struct))
 
 void *fdt_offset_ptr(const struct fdt_header *fdt, int offset, int checklen);
 
-- 
1.4.3.rc2.g0503
