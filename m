Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E4ED1A1D9F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:26:59 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 26 Aug 2015 13:56:56 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 962AA394005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:50 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7Q8QhSN52232424
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:44 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7Q8QfGF025342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:42 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 08/10] kasan: Update feature support file
Date: Wed, 26 Aug 2015 13:56:16 +0530
Message-Id: <1440577578-15813-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have two features KASAN and KASAN_INLINE, add new feature
support file for the same.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 .../debug/KASAN/KASAN_INLINE/arch-support.txt      | 40 ++++++++++++++++++++++
 .../KASAN/{ => KASAN_OUTLINE}/arch-support.txt     |  0
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/features/debug/KASAN/KASAN_INLINE/arch-support.txt
 rename Documentation/features/debug/KASAN/{ => KASAN_OUTLINE}/arch-support.txt (100%)

diff --git a/Documentation/features/debug/KASAN/KASAN_INLINE/arch-support.txt b/Documentation/features/debug/KASAN/KASAN_INLINE/arch-support.txt
new file mode 100644
index 000000000000..834818fba910
--- /dev/null
+++ b/Documentation/features/debug/KASAN/KASAN_INLINE/arch-support.txt
@@ -0,0 +1,40 @@
+#
+# Feature name:          KASAN
+#         Kconfig:       HAVE_ARCH_KASAN_INLINE
+#         description:   arch supports the KASAN runtime memory checker
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: | TODO |
+    |         arm: | TODO |
+    |       arm64: | TODO |
+    |       avr32: | TODO |
+    |    blackfin: | TODO |
+    |         c6x: | TODO |
+    |        cris: | TODO |
+    |         frv: | TODO |
+    |       h8300: | TODO |
+    |     hexagon: | TODO |
+    |        ia64: | TODO |
+    |        m32r: | TODO |
+    |        m68k: | TODO |
+    |       metag: | TODO |
+    |  microblaze: | TODO |
+    |        mips: | TODO |
+    |     mn10300: | TODO |
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: | TODO |
+    |     powerpc: | TODO |
+    |        s390: | TODO |
+    |       score: | TODO |
+    |          sh: | TODO |
+    |       sparc: | TODO |
+    |        tile: | TODO |
+    |          um: | TODO |
+    |   unicore32: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: | TODO |
+    -----------------------
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/KASAN_OUTLINE/arch-support.txt
similarity index 100%
rename from Documentation/features/debug/KASAN/arch-support.txt
rename to Documentation/features/debug/KASAN/KASAN_OUTLINE/arch-support.txt
-- 
2.5.0
