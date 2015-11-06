Return-Path: <mudongliangabcd@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 537621A0D49
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Nov 2015 01:45:56 +1100 (AEDT)
Received: by pasz6 with SMTP id z6so129065855pas.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2015 06:45:53 -0800 (PST)
Message-ID: <563CBD1B.1060407@gmail.com>
Date: Fri, 06 Nov 2015 22:45:47 +0800
From: mudongliang <mudongliangabcd@gmail.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 mudongliangabcd@gmail.com, will.deacon@arm.com, takahiro.akashi@linaro.org
CC: linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-api@vger.kernel.org
Subject: [PATCH] uapi elf: delete unused macros
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 13f516acc709d88d3162e92bc891c8e39cc9fc1a Mon Sep 17 00:00:00 2001
From: mudongliang <mudongliangabcd@gmail.com>
Date: Fri, 6 Nov 2015 14:35:19 +0800
Subject: [PATCH] unify the comment form and delete unused macros

Signed-off-by: mudongliang <mudongliangabcd@gmail.com>
---
 arch/powerpc/boot/elf.h  | 6 ++----
 include/uapi/linux/elf.h | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/elf.h b/arch/powerpc/boot/elf.h
index 1941bc5..e6e00ed 100644
--- a/arch/powerpc/boot/elf.h
+++ b/arch/powerpc/boot/elf.h
@@ -133,15 +133,13 @@ typedef struct elf64_phdr {
 #define	ELFCLASSNONE	0	/* EI_CLASS */
 #define	ELFCLASS32	1
 #define	ELFCLASS64	2
-#define	ELFCLASSNUM	3
 
-#define ELFDATANONE	0	/* e_ident[EI_DATA] */
+#define ELFDATANONE	0	/* EI_DATA */
 #define ELFDATA2LSB	1
 #define ELFDATA2MSB	2
 
-#define EV_NONE		0	/* e_version, EI_VERSION */
+#define EV_NONE		0	/* EI_VERSION */
 #define EV_CURRENT	1
-#define EV_NUM		2
 
 #define ELFOSABI_NONE	0
 #define ELFOSABI_LINUX	3
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 71e1d0e..ff81b20 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -342,15 +342,13 @@ typedef struct elf64_shdr {
 #define	ELFCLASSNONE	0		/* EI_CLASS */
 #define	ELFCLASS32	1
 #define	ELFCLASS64	2
-#define	ELFCLASSNUM	3
 
-#define ELFDATANONE	0		/* e_ident[EI_DATA] */
+#define ELFDATANONE	0		/* EI_DATA */
 #define ELFDATA2LSB	1
 #define ELFDATA2MSB	2
 
-#define EV_NONE		0		/* e_version, EI_VERSION */
+#define EV_NONE		0		/* EI_VERSION */
 #define EV_CURRENT	1
-#define EV_NUM		2
 
 #define ELFOSABI_NONE	0
 #define ELFOSABI_LINUX	3
-- 
2.1.4


-- 
My best regards to you.

     No System Is Safe!
     mudongliang
