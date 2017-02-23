Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTrQM1MCMzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 10:43:07 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTrQK6cshz9s78
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 10:43:05 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dri-devel@lists.freedesktop.org
Cc: "Y . C . Chen" <yc_chen@aspeedtech.com>, airlied@redhat.com,
 eich@suse.come, linuxppc-dev@ozlabs.org
Subject: [PATCH 04/12] drm/ast: Remove spurrious include
Date: Fri, 24 Feb 2017 09:53:49 +1100
Message-Id: <20170223225357.9572-4-benh@kernel.crashing.org>
In-Reply-To: <20170223225357.9572-1-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/gpu/drm/ast/ast_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index 36932a3..718c15b 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -32,8 +32,6 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 
-#include "ast_dram_tables.h"
-
 void ast_set_index_reg_mask(struct ast_private *ast,
 			    uint32_t base, uint8_t index,
 			    uint8_t mask, uint8_t val)
-- 
2.9.3
