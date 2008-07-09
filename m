Return-Path: <w.sang@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 297ECDDE08
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 19:22:52 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] libfdt: Improve documentation in libfdt.h
To: jdl@freescale.com
Date: Wed, 09 Jul 2008 11:22:44 +0200
Message-ID: <20080709092243.10615.84477.stgit@leda.ptxnet.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a few typos and mistakes.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

 libfdt/libfdt.h |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/libfdt/libfdt.h b/libfdt/libfdt.h
index 8645de0..dafb568 100644
--- a/libfdt/libfdt.h
+++ b/libfdt/libfdt.h
@@ -213,7 +213,7 @@ int fdt_move(const void *fdt, void *buf, int bufsize);
 /**********************************************************************/
 
 /**
- * fdt_string - retreive a string from the strings block of a device tree
+ * fdt_string - retrieve a string from the strings block of a device tree
  * @fdt: pointer to the device tree blob
  * @stroffset: offset of the string within the strings block (native endian)
  *
@@ -227,7 +227,7 @@ int fdt_move(const void *fdt, void *buf, int bufsize);
 const char *fdt_string(const void *fdt, int stroffset);
 
 /**
- * fdt_num_mem_rsv - retreive the number of memory reserve map entries
+ * fdt_num_mem_rsv - retrieve the number of memory reserve map entries
  * @fdt: pointer to the device tree blob
  *
  * Returns the number of entries in the device tree blob's memory
@@ -240,7 +240,7 @@ const char *fdt_string(const void *fdt, int stroffset);
 int fdt_num_mem_rsv(const void *fdt);
 
 /**
- * fdt_get_mem_rsv - retreive one memory reserve map entry
+ * fdt_get_mem_rsv - retrieve one memory reserve map entry
  * @fdt: pointer to the device tree blob
  * @address, @size: pointers to 64-bit variables
  *
@@ -320,7 +320,7 @@ int fdt_subnode_offset(const void *fdt, int parentoffset, const char *name);
 int fdt_path_offset(const void *fdt, const char *path);
 
 /**
- * fdt_get_name - retreive the name of a given node
+ * fdt_get_name - retrieve the name of a given node
  * @fdt: pointer to the device tree blob
  * @nodeoffset: structure block offset of the starting node
  * @lenp: pointer to an integer variable (will be overwritten) or NULL
@@ -352,7 +352,7 @@ const char *fdt_get_name(const void *fdt, int nodeoffset, int *lenp);
  * fdt_get_property() retrieves a pointer to the fdt_property
  * structure within the device tree blob corresponding to the property
  * named 'name' of the node at offset nodeoffset.  If lenp is
- * non-NULL, the length of the property value also returned, in the
+ * non-NULL, the length of the property value is also returned, in the
  * integer pointed to by lenp.
  *
  * returns:
@@ -389,7 +389,7 @@ static inline struct fdt_property *fdt_get_property_w(void *fdt, int nodeoffset,
  * fdt_getprop() retrieves a pointer to the value of the property
  * named 'name' of the node at offset nodeoffset (this will be a
  * pointer to within the device blob itself, not a copy of the value).
- * If lenp is non-NULL, the length of the property value also
+ * If lenp is non-NULL, the length of the property value is also
  * returned, in the integer pointed to by lenp.
  *
  * returns:
@@ -415,7 +415,7 @@ static inline void *fdt_getprop_w(void *fdt, int nodeoffset,
 }
 
 /**
- * fdt_get_phandle - retreive the phandle of a given node
+ * fdt_get_phandle - retrieve the phandle of a given node
  * @fdt: pointer to the device tree blob
  * @nodeoffset: structure block offset of the node
  *
@@ -423,7 +423,7 @@ static inline void *fdt_getprop_w(void *fdt, int nodeoffset,
  * structure block offset nodeoffset.
  *
  * returns:
- *	the phandle of the node at nodeoffset, on succes (!= 0, != -1)
+ *	the phandle of the node at nodeoffset, on success (!= 0, != -1)
  *	0, if the node has no phandle, or another error occurs
  */
 uint32_t fdt_get_phandle(const void *fdt, int nodeoffset);
@@ -522,7 +522,7 @@ int fdt_node_depth(const void *fdt, int nodeoffset);
  * structure from the start to nodeoffset, *twice*.
  *
  * returns:
- *	stucture block offset of the parent of the node at nodeoffset
+ *	structure block offset of the parent of the node at nodeoffset
  *		(>=0), on success
  * 	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
  *	-FDT_ERR_BADMAGIC,
@@ -579,7 +579,7 @@ int fdt_node_offset_by_prop_value(const void *fdt, int startoffset,
  * @fdt: pointer to the device tree blob
  * @phandle: phandle value
  *
- * fdt_node_offset_by_prop_value() returns the offset of the node
+ * fdt_node_offset_by_phandle() returns the offset of the node
  * which has the given phandle value.  If there is more than one node
  * in the tree with the given phandle (an invalid tree), results are
  * undefined.
@@ -806,13 +806,13 @@ int fdt_pack(void *fdt);
 /**
  * fdt_add_mem_rsv - add one memory reserve map entry
  * @fdt: pointer to the device tree blob
- * @addres, @size: 64-bit values (native endian)
+ * @address, @size: 64-bit values (native endian)
  *
  * Adds a reserve map entry to the given blob reserving a region at
  * address address of length size.
  *
  * This function will insert data into the reserve map and will
- * therfore change the indexes of some entries in the table.
+ * therefore change the indexes of some entries in the table.
  *
  * returns:
  *	0, on success
@@ -836,7 +836,7 @@ int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size);
  * the blob.
  *
  * This function will delete data from the reservation table and will
- * therfore change the indexes of some entries in the table.
+ * therefore change the indexes of some entries in the table.
  *
  * returns:
  *	0, on success
@@ -886,7 +886,7 @@ int fdt_set_name(void *fdt, int nodeoffset, const char *name);
  * @len: length of the property value
  *
  * fdt_setprop() sets the value of the named property in the given
- * node to the given value and length, creeating the property if it
+ * node to the given value and length, creating the property if it
  * does not already exist.
  *
  * This function may insert or delete data from the blob, and will
