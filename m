Return-Path: <gvb.uboot@gmail.com>
Received: from QMTA04.emeryville.ca.mail.comcast.net
	(qmta04.emeryville.ca.mail.comcast.net [76.96.30.40])
	by ozlabs.org (Postfix) with ESMTP id 746D3DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 22:17:02 +1000 (EST)
Date: Sat, 4 Oct 2008 08:11:27 -0400
From: Jerry Van Baren <gvb.uboot@gmail.com>
To: linuxppc-dev@ozlabs.org, jdl@jdl.com, david@gibson.dropbear.id.au
Subject: [PATCH] libfdt: Fix error in documentation for fdt_get_alias_namelen()
Message-ID: <20081004121127.GA32255@cideas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080820065514.GA18996@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oops, screwed up the function name in the documenting comment for this
function.  Trivial correction in this patch.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Gerald Van Baren <vanbaren@cideas.com>
---

David's cut-n-paste fix git-ized and applied to the dtc repo.

Best regards,
gvb

 libfdt/libfdt.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libfdt/libfdt.h b/libfdt/libfdt.h
index a11bbf3..4a95e11 100644
--- a/libfdt/libfdt.h
+++ b/libfdt/libfdt.h
@@ -459,7 +459,7 @@ static inline void *fdt_getprop_w(void *fdt, int nodeoffset,
 uint32_t fdt_get_phandle(const void *fdt, int nodeoffset);
 
 /**
- * fdt_get_namelen - get alias based on substring
+ * fdt_get_alias_namelen - get alias based on substring
  * @fdt: pointer to the device tree blob
  * @name: name of the alias th look up
  * @namelen: number of characters of name to consider
-- 
1.5.6.5
