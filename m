Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qljC2srKzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 16:14:23 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	mikey@neuling.org
Subject: [PATCH] selftests/powerpc: Add missing .gitignores
Date: Tue, 22 May 2018 16:13:59 +1000
Message-Id: <20180522061359.4954-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 tools/testing/selftests/powerpc/alignment/.gitignore | 1 +
 tools/testing/selftests/powerpc/tm/.gitignore        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/powerpc/alignment/.gitignore b/tools/testing/selftests/powerpc/alignment/.gitignore
index 1d980e3d70..9d383073b7 100644
--- a/tools/testing/selftests/powerpc/alignment/.gitignore
+++ b/tools/testing/selftests/powerpc/alignment/.gitignore
@@ -3,3 +3,4 @@ copy_first_unaligned
 paste_unaligned
 paste_last_unaligned
 copy_paste_unaligned_common
+alignment_handler
diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index bb90d4b795..c3ee8393da 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -14,3 +14,4 @@ tm-signal-context-chk-vsx
 tm-vmx-unavail
 tm-unavailable
 tm-trap
+tm-sigreturn
-- 
2.17.0
