Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42B9GB4GJvzF1RG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 06:28:34 +1000 (AEST)
Received: by mail-oi0-f41.google.com with SMTP id m11-v6so10775152oic.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 13:28:34 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 2/3] scripts/dtc: Add yamltree.c to dtc sources
Date: Thu, 13 Sep 2018 15:28:27 -0500
Message-Id: <20180913202828.15372-2-robh@kernel.org>
In-Reply-To: <20180913202828.15372-1-robh@kernel.org>
References: <20180913202828.15372-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dtc has a new source file, yamltree.c, that needs to be copied when
syncing dtc sources.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/dtc/update-dtc-source.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
index 1a009fd195d0..7dd29a0362b8 100755
--- a/scripts/dtc/update-dtc-source.sh
+++ b/scripts/dtc/update-dtc-source.sh
@@ -32,7 +32,7 @@ DTC_UPSTREAM_PATH=`pwd`/../dtc
 DTC_LINUX_PATH=`pwd`/scripts/dtc
 
 DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
-		srcpos.h treesource.c util.c util.h version_gen.h Makefile.dtc \
+		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c Makefile.dtc \
 		dtc-lexer.l dtc-parser.y"
 LIBFDT_SOURCE="Makefile.libfdt fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
 		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
-- 
2.17.1
