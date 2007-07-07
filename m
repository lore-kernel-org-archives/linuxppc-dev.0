Return-Path: <miltonm@sullivan.realtime.net>
Date: Sat, 7 Jul 2007 01:18:53 -0500 (CDT)
Subject: [PATCH 10/11] dtc: align header comments in asm output
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jon Loeliger <jdl@jdl.com>
Message-Id: <dtc-5-10.miltonm@bga.com>
In-Reply-To: <dtc-5-00.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Insert tabs to align the comments describing the fields of the
boot parameters header struct.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Previously some of the comments were seperated by one space and
others by one tab from the field.

Purely cosmetic, but then so are the comments.

Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-06-20 03:13:25.000000000 -0500
+++ dtc/flattree.c	2007-06-20 03:13:51.000000000 -0500
@@ -469,21 +469,21 @@ void dt_to_asm(FILE *f, struct boot_info
 
 	emit_label(f, symprefix, "blob_start");
 	emit_label(f, symprefix, "header");
-	fprintf(f, "\t.long\tOF_DT_HEADER /* magic */\n");
-	fprintf(f, "\t.long\t_%s_blob_abs_end - _%s_blob_start /* totalsize */\n",
+	fprintf(f, "\t.long\tOF_DT_HEADER\t\t\t\t/* magic */\n");
+	fprintf(f, "\t.long\t_%s_blob_abs_end - _%s_blob_start\t/* totalsize */\n",
 		symprefix, symprefix);
-	fprintf(f, "\t.long\t_%s_struct_start - _%s_blob_start /* off_dt_struct */\n",
+	fprintf(f, "\t.long\t_%s_struct_start - _%s_blob_start\t/* off_dt_struct */\n",
 		symprefix, symprefix);
-	fprintf(f, "\t.long\t_%s_strings_start - _%s_blob_start /* off_dt_strings */\n",
+	fprintf(f, "\t.long\t_%s_strings_start - _%s_blob_start\t/* off_dt_strings */\n",
 		symprefix, symprefix);
-	fprintf(f, "\t.long\t_%s_reserve_map - _%s_blob_start /* off_dt_strings */\n",
+	fprintf(f, "\t.long\t_%s_reserve_map - _%s_blob_start\t/* off_dt_strings */\n",
 		symprefix, symprefix);
-	fprintf(f, "\t.long\t%d /* version */\n", vi->version);
-	fprintf(f, "\t.long\t%d /* last_comp_version */\n",
+	fprintf(f, "\t.long\t%d\t\t\t\t\t/* version */\n", vi->version);
+	fprintf(f, "\t.long\t%d\t\t\t\t\t/* last_comp_version */\n",
 		vi->last_comp_version);
 
 	if (vi->flags & FTF_BOOTCPUID)
-		fprintf(f, "\t.long\t%i\t/*boot_cpuid_phys*/\n",
+		fprintf(f, "\t.long\t%i\t\t\t\t\t/* boot_cpuid_phys */\n",
 			boot_cpuid_phys);
 
 	if (vi->flags & FTF_STRTABSIZE)
