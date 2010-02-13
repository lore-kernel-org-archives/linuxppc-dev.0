Return-Path: <grant.likely@secretlab.ca>
Received: from mail-px0-f187.google.com (mail-px0-f187.google.com
	[209.85.216.187]) by ozlabs.org (Postfix) with ESMTP id 6FDD2B8186
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Feb 2010 03:03:01 +1100 (EST)
Received: by mail-px0-f187.google.com with SMTP id 17so834000pxi.11
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Feb 2010 08:03:01 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 6/9] of: remove unused extern reference to devtree_lock
To: monstr@monstr.eu, sfr@canb.auug.org.au, benh@kernel.crashing.org,
	jeremy.kerr@canonical.com, davem@davemloft.net,
	microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Date: Sat, 13 Feb 2010 09:02:58 -0700
Message-ID: <20100213160258.4767.22371.stgit@angua>
In-Reply-To: <20100213154838.4767.83881.stgit@angua>
References: <20100213154838.4767.83881.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Neither the powerpc nor the microblaze code use devtree_lock anymore.
Remove the extern reference.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |    2 --
 arch/powerpc/kernel/prom.c         |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index ddc5c57..8b1ebd3 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -30,8 +30,6 @@ extern struct device_node *of_chosen;
 
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
-extern rwlock_t devtree_lock;	/* temporary while merging */
-
 /* Other Prototypes */
 extern int early_uartlite_console(void);
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 5bbbdb2..4869c93 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -67,8 +67,6 @@ int __initdata iommu_force_on;
 unsigned long tce_alloc_start, tce_alloc_end;
 #endif
 
-extern rwlock_t devtree_lock;	/* temporary while merging */
-
 /* export that to outside world */
 struct device_node *of_chosen;
 
