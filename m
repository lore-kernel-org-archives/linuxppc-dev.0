Return-Path: <rashmica.g@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hc4K70k4zF2DT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 16:06:25 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id j8-v6so2662317pff.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 23:06:25 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, mikey@neuling.org,
 benh@kernel.crashing.org, paulus@samba.org, bsingharora@gmail.com
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: [PATCH 2/2] Update documentation on ppc-memtrace
Date: Fri,  3 Aug 2018 16:06:01 +1000
Message-Id: <20180803060601.724-2-rashmica.g@gmail.com>
In-Reply-To: <20180803060601.724-1-rashmica.g@gmail.com>
References: <20180803060601.724-1-rashmica.g@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
 Documentation/ABI/testing/ppc-memtrace | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/ppc-memtrace b/Documentation/ABI/testing/ppc-memtrace
index 2e8b93741270..9606aed33137 100644
--- a/Documentation/ABI/testing/ppc-memtrace
+++ b/Documentation/ABI/testing/ppc-memtrace
@@ -13,10 +13,11 @@ Contact:	linuxppc-dev@lists.ozlabs.org
 Description:	Write an integer containing the size in bytes of the memory
 		you want removed from each NUMA node to this file - it must be
 		aligned to the memblock size. This amount of RAM will be removed
-		from the kernel mappings and the following debugfs files will be
-		created. This can only be successfully done once per boot. Once
-		memory is successfully removed from each node, the following
-		files are created.
+		from each NUMA node in the kernel mappings and the following
+		debugfs files will be created. Once memory is successfully
+		removed from each node, the following files are created. To
+		re-add memory to the kernel, echo 0 into this file (it will be
+		automatically onlined).
 
 What:		/sys/kernel/debug/powerpc/memtrace/<node-id>
 Date:		Aug 2017
-- 
2.14.4
