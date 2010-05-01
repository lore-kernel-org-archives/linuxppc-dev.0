Return-Path: <orenl@cs.columbia.edu>
Received: from tarap.cc.columbia.edu (tarap.cc.columbia.edu [128.59.29.7])
	by ozlabs.org (Postfix) with ESMTP id 9AE87B7D57
	for <linuxppc-dev@ozlabs.org>; Sun,  2 May 2010 00:38:26 +1000 (EST)
From: Oren Laadan <orenl@cs.columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v21 084/100] powerpc: reserve checkpoint arch identifiers
Date: Sat,  1 May 2010 10:16:06 -0400
Message-Id: <1272723382-19470-85-git-send-email-orenl@cs.columbia.edu>
In-Reply-To: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
References: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	Matt Helsley <matthltc@us.ibm.com>, Serge Hallyn <serue@us.ibm.com>,
	Pavel Emelyanov <xemul@openvz.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nathan Lynch <ntl@pobox.com>

Changelog [v19-rc1]:
  - [Matt Helsley] Add cpp definitions for enums

Cc: linuxppc-dev@ozlabs.org
Signed-off-by: Nathan Lynch <ntl@pobox.com>
Acked-by: Serge E. Hallyn <serue@us.ibm.com>
Tested-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/linux/checkpoint_hdr.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/checkpoint_hdr.h b/include/linux/checkpoint_hdr.h
index f2779d1..90cbc15 100644
--- a/include/linux/checkpoint_hdr.h
+++ b/include/linux/checkpoint_hdr.h
@@ -193,6 +193,10 @@ enum {
 #define CKPT_ARCH_X86_64 CKPT_ARCH_X86_64
 	CKPT_ARCH_S390X,
 #define CKPT_ARCH_S390X CKPT_ARCH_S390X
+	CKPT_ARCH_PPC32,
+#define CKPT_ARCH_PPC32 CKPT_ARCH_PPC32
+	CKPT_ARCH_PPC64,
+#define CKPT_ARCH_PPC64 CKPT_ARCH_PPC64
 };
 
 /* shared objrects (objref) */
-- 
1.6.3.3
