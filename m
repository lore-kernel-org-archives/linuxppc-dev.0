Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6FD78B71D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:51:36 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/13] powerpc: Enable hugetlb by default for corenet64
 platforms
Date: Mon, 10 Oct 2011 15:50:48 -0500
Message-Id: <13182798912541-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <13182798902823-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
 <1318279870278-git-send-email-beckyb@kernel.crashing.org>
 <13182798731357-git-send-email-beckyb@kernel.crashing.org>
 <13182798761457-git-send-email-beckyb@kernel.crashing.org>
 <13182798791090-git-send-email-beckyb@kernel.crashing.org>
 <1318279883564-git-send-email-beckyb@kernel.crashing.org>
 <1318279885811-git-send-email-beckyb@kernel.crashing.org>
 <13182798883685-git-send-email-beckyb@kernel.crashing.org>
 <13182798892145-git-send-email-beckyb@kernel.crashing.org>
 <13182798902823-git-send-email-beckyb@kernel.crashing.org>
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/configs/corenet64_smp_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 782822c..53741f4 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -81,6 +81,7 @@ CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
+CONFIG_HUGETLBFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
-- 
1.5.6.5
