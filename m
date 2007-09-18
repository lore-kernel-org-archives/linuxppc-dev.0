Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Sep 2007 11:44:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Whitespace cleanup
Message-ID: <20070918014404.GB30766@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This large patch removes all trailing whitespace from dtc (including
libfdt, the testsuite and documentation).  It also removes a handful
of redundant blank lines (at the end of functions, or when there are
two blank lines together for no particular reason).

As well as anything else, this means that quilt won't whinge when I go
to convert the whole of libfdt into a patch to apply to the kernel.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2007-09-18 11:05:03.000000000 +1000
+++ dtc/data.c	2007-09-18 11:05:55.000000000 +1000
@@ -1,7 +1,7 @@
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
  *
- * 
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation; either version 2 of the
@@ -11,11 +11,11 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
- *                                                                       
- *  You should have received a copy of the GNU General Public License    
- *  along with this program; if not, write to the Free Software          
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
- *                                                                   USA 
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
  */
 
 #include "dtc.h"
@@ -106,7 +106,7 @@
 	val = strtol(x, &endx, 8);
 	if ((endx - x) == 0)
 		fprintf(stderr, "Empty \\nnn escape\n");
-		
+
 	(*i) += endx - x;
 	return val;
 }
@@ -125,7 +125,7 @@
 	val = strtol(x, &endx, 16);
 	if ((endx - x) == 0)
 		fprintf(stderr, "Empty \\x escape\n");
-		
+
 	(*i) += endx - x;
 	return val;
 }
Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2007-09-18 11:06:06.000000000 +1000
+++ dtc/treesource.c	2007-09-18 11:06:25.000000000 +1000
@@ -1,7 +1,7 @@
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
  *
- * 
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation; either version 2 of the
@@ -11,11 +11,11 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
- *                                                                       
- *  You should have received a copy of the GNU General Public License    
- *  along with this program; if not, write to the Free Software          
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
- *                                                                   USA 
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
  */
 
 #include "dtc.h"
@@ -77,7 +77,6 @@
 		return PROP_CELLS;
 	else
 		return PROP_BYTES;
-		
 }
 
 
Index: dtc/tests/root_node.c
===================================================================
--- dtc.orig/tests/root_node.c	2007-09-18 11:06:53.000000000 +1000
+++ dtc/tests/root_node.c	2007-09-18 11:06:56.000000000 +1000
@@ -36,7 +36,7 @@
 
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
-	
+
 	nh = fdt_offset_ptr_typed(fdt, 0, nh);
 
 	if (! nh)
Index: dtc/tests/testutils.c
===================================================================
--- dtc.orig/tests/testutils.c	2007-09-18 11:06:40.000000000 +1000
+++ dtc/tests/testutils.c	2007-09-18 11:06:44.000000000 +1000
@@ -104,7 +104,6 @@
 		     name, proplen, len);
 	if (memcmp(val, prop->data, len) != 0)
 		FAIL("Data mismatch on property \"%s\"", name);
-	
 }
 
 const void *check_getprop(void *fdt, int nodeoffset, const char *name,
Index: dtc/tests/nop_property.c
===================================================================
--- dtc.orig/tests/nop_property.c	2007-09-18 11:07:23.000000000 +1000
+++ dtc/tests/nop_property.c	2007-09-18 11:07:26.000000000 +1000
@@ -53,7 +53,7 @@
 		FAIL("prop-int still present after nopping");
 	if (lenerr != -FDT_ERR_NOTFOUND)
 		FAIL("Unexpected error on second getprop: %s", fdt_strerror(err));
-	
+
 	strp = check_getprop(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1,
 			     TEST_STRING_1);
 	verbose_printf("string value was \"%s\"\n", strp);
Index: dtc/tests/notfound.c
===================================================================
--- dtc.orig/tests/notfound.c	2007-09-18 11:07:10.000000000 +1000
+++ dtc/tests/notfound.c	2007-09-18 11:07:13.000000000 +1000
@@ -68,6 +68,6 @@
 
 	offset = fdt_path_offset(fdt, "/nonexistant-subnode");
 	check_error("fdt_path_offset(\"/nonexistant-subnode\")", offset);
-	
+
 	PASS();
 }
Index: dtc/tests/setprop.c
===================================================================
--- dtc.orig/tests/setprop.c	2007-09-18 11:08:17.000000000 +1000
+++ dtc/tests/setprop.c	2007-09-18 11:08:20.000000000 +1000
@@ -62,7 +62,7 @@
 
 	strp = check_getprop_string(fdt, 0, "prop-int", NEW_STRING);
 	verbose_printf("New value is \"%s\"\n", strp);
-	
+
 	strp = check_getprop(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1,
 			     TEST_STRING_1);
 
Index: dtc/tests/setprop_inplace.c
===================================================================
--- dtc.orig/tests/setprop_inplace.c	2007-09-18 11:07:38.000000000 +1000
+++ dtc/tests/setprop_inplace.c	2007-09-18 11:07:45.000000000 +1000
@@ -51,7 +51,7 @@
 		     ~TEST_VALUE_1, fdt_strerror(err));
 	intp = check_getprop_typed(fdt, 0, "prop-int", ~TEST_VALUE_1);
 	verbose_printf("New int value is 0x%08x\n", *intp);
-	
+
 	strp = check_getprop(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1,
 			     TEST_STRING_1);
 
@@ -66,7 +66,7 @@
 		     xstr, fdt_strerror(err));
 
 	strp = check_getprop(fdt, 0, "prop-str", xlen+1, xstr);
-	verbose_printf("New string value is \"%s\"\n", strp);	
+	verbose_printf("New string value is \"%s\"\n", strp);
 
 	PASS();
 }
Index: dtc/tests/trees.S
===================================================================
--- dtc.orig/tests/trees.S	2007-09-18 11:07:51.000000000 +1000
+++ dtc/tests/trees.S	2007-09-18 11:08:08.000000000 +1000
@@ -65,7 +65,7 @@
 #define STRING(tree, name, str) \
 tree##_##name:	\
 	.string	str
-	
+
 	.data
 
 	TREE_HDR(test_tree1)
@@ -77,7 +77,7 @@
 	BEGIN_NODE("")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_1)
 	PROP_STR(test_tree1, prop_str, TEST_STRING_1)
-	
+
 	BEGIN_NODE("subnode1")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_1)
 
@@ -110,7 +110,7 @@
 	BEGIN_NODE("")
 	PROPHDR(truncated_property, prop_truncated, 4)
 	/* Oops, no actual property data here */
-	
+
 truncated_property_strings:
 	STRING(truncated_property, prop_truncated, "truncated")
 truncated_property_end:
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-09-18 11:08:45.000000000 +1000
+++ dtc/flattree.c	2007-09-18 11:09:53.000000000 +1000
@@ -1,7 +1,7 @@
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
  *
- * 
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation; either version 2 of the
@@ -11,11 +11,11 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
- *                                                                       
- *  You should have received a copy of the GNU General Public License    
- *  along with this program; if not, write to the Free Software          
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
- *                                                                   USA 
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
  */
 
 #include "dtc.h"
@@ -111,7 +111,7 @@
 	.data = bin_emit_data,
 	.beginnode = bin_emit_beginnode,
 	.endnode = bin_emit_endnode,
-	.property = bin_emit_property,	
+	.property = bin_emit_property,
 };
 
 static void emit_label(FILE *f, char *prefix, char *label)
@@ -144,7 +144,7 @@
 		c = str[len];
 		str[len] = '\0';
 	}
-		
+
 	fprintf(f, "\t.string\t\"%s\"\n", str);
 
 	if (len != 0) {
@@ -178,7 +178,7 @@
 	}
 
 	if ((d.len - off) >= sizeof(u16)) {
-		fprintf(f, "\t.short\t0x%hx\n", 
+		fprintf(f, "\t.short\t0x%hx\n",
 			be16_to_cpu(*((u16 *)(d.val+off))));
 		off += sizeof(u16);
 	}
@@ -231,7 +231,7 @@
 	.data = asm_emit_data,
 	.beginnode = asm_emit_beginnode,
 	.endnode = asm_emit_endnode,
-	.property = asm_emit_property,	
+	.property = asm_emit_property,
 };
 
 static int stringtable_insert(struct data *d, char *str)
@@ -717,7 +717,7 @@
 
 	if (! strneq(ppath, cpath, plen))
 		return NULL;
-	
+
 	return strdup(lslash+1);
 }
 
@@ -766,7 +766,7 @@
 		node->name = flat_read_string(dtbuf);
 		node->fullpath = join_path(parent_path, node->name);
 	}
-	
+
 	node->basenamelen = check_node_name(node->name);
 	if (node->basenamelen < 0) {
 		fprintf(stderr, "Warning \"%s\" has incorrect format\n", node->name);
@@ -926,7 +926,7 @@
 		if (off_dt+size_dt > totalsize)
 			die("Structure block extends past total size\n");
 	}
-			
+
 	if (version < 16) {
 		flags |= FTF_FULLPATH | FTF_NAMEPROPS | FTF_VARALIGN;
 	} else {
Index: dtc/ftdump.c
===================================================================
--- dtc.orig/ftdump.c	2007-09-18 11:08:36.000000000 +1000
+++ dtc/ftdump.c	2007-09-18 11:08:39.000000000 +1000
@@ -81,7 +81,7 @@
 static void dump_blob(void *blob)
 {
 	struct boot_param_header *bph = blob;
-	struct reserve_entry *p_rsvmap = 
+	struct reserve_entry *p_rsvmap =
 		(struct reserve_entry *)(blob
 					 + be32_to_cpu(bph->off_mem_rsvmap));
 	char *p_struct = blob + be32_to_cpu(bph->off_dt_struct);
Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-09-18 11:09:44.000000000 +1000
+++ dtc/Makefile	2007-09-18 11:09:47.000000000 +1000
@@ -13,7 +13,7 @@
 SUBLEVEL = 0
 EXTRAVERSION =
 LOCAL_VERSION =
-CONFIG_LOCALVERSION = 
+CONFIG_LOCALVERSION =
 
 DTC_VERSION = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 VERSION_FILE = version_gen.h
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2007-09-18 11:10:00.000000000 +1000
+++ dtc/dtc.c	2007-09-18 11:11:00.000000000 +1000
@@ -1,7 +1,7 @@
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
  *
- * 
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation; either version 2 of the
@@ -11,11 +11,11 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
- *                                                                       
- *  You should have received a copy of the GNU General Public License    
- *  along with this program; if not, write to the Free Software          
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
- *                                                                   USA 
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
  */
 
 #include "dtc.h"
@@ -218,6 +218,6 @@
 	} else {
 		die("Unknown output format \"%s\"\n", outform);
 	}
-		
+
 	exit(0);
 }
Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2007-09-18 11:10:28.000000000 +1000
+++ dtc/dtc-lexer.l	2007-09-18 11:10:42.000000000 +1000
@@ -1,7 +1,7 @@
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
  *
- * 
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation; either version 2 of the
@@ -11,11 +11,11 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
- *                                                                       
- *  You should have received a copy of the GNU General Public License    
- *  along with this program; if not, write to the Free Software          
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
- *                                                                   USA 
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
  */
 
 %option noyywrap nounput yylineno
Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2007-09-18 11:11:36.000000000 +1000
+++ dtc/dtc-parser.y	2007-09-18 11:11:47.000000000 +1000
@@ -1,7 +1,7 @@
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
  *
- * 
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation; either version 2 of the
@@ -11,11 +11,11 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
- *                                                                       
- *  You should have received a copy of the GNU General Public License    
- *  along with this program; if not, write to the Free Software          
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
- *                                                                   USA 
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
  */
 
 %glr-parser
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-09-18 11:11:11.000000000 +1000
+++ dtc/dtc.h	2007-09-18 11:11:25.000000000 +1000
@@ -4,7 +4,7 @@
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
  *
- * 
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation; either version 2 of the
@@ -14,11 +14,11 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
- *                                                                       
- *  You should have received a copy of the GNU General Public License    
- *  along with this program; if not, write to the Free Software          
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
- *                                                                   USA 
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
  */
 
 #include <stdio.h>
Index: dtc/Documentation/dtc-paper.tex
===================================================================
--- dtc.orig/Documentation/dtc-paper.tex	2007-09-18 11:12:23.000000000 +1000
+++ dtc/Documentation/dtc-paper.tex	2007-09-18 11:12:27.000000000 +1000
@@ -193,7 +193,7 @@
     \vdots & \multicolumn{1}{c|}{\vdots} & \\\cline{2-2}
     & \texttt{\dtendnode} \\\cline{2-2}
     & \texttt{\dtend} \\\cline{2-2}
-    \multicolumn{1}{r}{\vdots} & \multicolumn{1}{c}{\vdots} & \\\cline{2-2}    
+    \multicolumn{1}{r}{\vdots} & \multicolumn{1}{c}{\vdots} & \\\cline{2-2}
     \multicolumn{1}{r}{\emph{totalsize}} \\
   \end{tabular}
   \caption{Device tree blob layout}
Index: dtc/Documentation/manual.txt
===================================================================
--- dtc.orig/Documentation/manual.txt	2007-09-18 11:12:07.000000000 +1000
+++ dtc/Documentation/manual.txt	2007-09-18 11:12:11.000000000 +1000
@@ -140,7 +140,7 @@
 
     memreserve:   label 'memreserve' ADDR ADDR ';'
 		| label 'memreserve' ADDR '-' ADDR ';'
-                
+
     devicetree:   '/' nodedef
 
     nodedef:      '{' list_of_property list_of_subnode '}' ';'
Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2007-09-18 11:13:12.000000000 +1000
+++ dtc/livetree.c	2007-09-18 11:14:00.000000000 +1000
@@ -1,7 +1,7 @@
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
  *
- * 
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation; either version 2 of the
@@ -11,11 +11,11 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
- *                                                                       
- *  You should have received a copy of the GNU General Public License    
- *  along with this program; if not, write to the Free Software          
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
- *                                                                   USA 
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
  */
 
 #include "dtc.h"
@@ -41,9 +41,9 @@
 struct property *chain_property(struct property *first, struct property *list)
 {
 	assert(first->next == NULL);
-	
+
 	first->next = list;
-	return first;      
+	return first;
 }
 
 struct node *build_node(struct property *proplist, struct node *children)
@@ -232,7 +232,7 @@
 
 static struct node *get_node_by_phandle(struct node *tree, cell_t phandle)
 {
-	struct node *child, *node;	
+	struct node *child, *node;
 
 	assert((phandle != 0) && (phandle != -1));
 
@@ -333,13 +333,12 @@
 					prop->name, node->fullpath);
 			}
 		}
-			
 
 		/* check name length */
 		if (strlen(prop->name) > MAX_PROPNAME_LEN)
 			WARNMSG("Property name %s is too long in %s\n",
 				prop->name, node->fullpath);
-			
+
 		/* check this property */
 		for (i = 0; i < ARRAY_SIZE(prop_checker_table); i++) {
 			if (streq(prop->name, prop_checker_table[i].propname))
@@ -426,7 +425,7 @@
 				(node)->fullpath, (propname), \
 				prop->val.val, (value)); \
 	} while (0)
-		 
+
 #define CHECK_HAVE_ONECELL(node, propname) \
 	do { \
 		CHECK_HAVE((node), (propname)); \
@@ -553,7 +552,7 @@
 			WARNMSG("physical boot CPU not set.  Use -b option to set\n");
 	}
 
-	return ok;	
+	return ok;
 }
 
 static int check_memory(struct node *root)
@@ -578,7 +577,7 @@
 		return 0;
 	}
 
-	return ok;	
+	return ok;
 }
 
 static int check_chosen(struct node *root)
Index: dtc/fstree.c
===================================================================
--- dtc.orig/fstree.c	2007-09-18 11:14:39.000000000 +1000
+++ dtc/fstree.c	2007-09-18 11:15:02.000000000 +1000
@@ -1,7 +1,7 @@
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
  *
- * 
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation; either version 2 of the
@@ -11,11 +11,11 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
- *                                                                       
- *  You should have received a copy of the GNU General Public License    
- *  along with this program; if not, write to the Free Software          
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
- *                                                                   USA 
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
  */
 
 #include "dtc.h"
@@ -44,7 +44,7 @@
 			continue;
 
 		tmpnam = join_path(dirname, de->d_name);
-		
+
 		if (lstat(tmpnam, &st) < 0)
 			die("stat(%s): %s\n", tmpnam, strerror(errno));
 
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-09-18 11:14:24.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-09-18 11:14:32.000000000 +1000
@@ -166,7 +166,7 @@
 		p = q;
 	}
 
-	return offset;	
+	return offset;
 }
 
 const char *fdt_get_name(const void *fdt, int nodeoffset, int *len)
@@ -244,7 +244,7 @@
 
 				if (lenp)
 					*lenp = len;
-				
+
 				return prop;
 			}
 			break;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
