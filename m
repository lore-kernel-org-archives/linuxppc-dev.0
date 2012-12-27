Return-Path: <thomas.waldecker@gmail.com>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 07BA22C009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 01:08:26 +1100 (EST)
Received: by mail-bk0-f48.google.com with SMTP id jc3so4260073bkc.21
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2012 06:08:22 -0800 (PST)
From: Thomas Waldecker <thomas.waldecker@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] PowerPC documentation: fixed path to the powerpc directory
Date: Thu, 27 Dec 2012 15:07:27 +0100
Message-Id: <1356617247-13523-1-git-send-email-thomas.waldecker@gmail.com>
Cc: Thomas Waldecker <thomas.waldecker@gmail.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ppc -> powerpc

Signed-off-by: Thomas Waldecker <thomas.waldecker@gmail.com>
---
 Documentation/powerpc/cpu_features.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/powerpc/cpu_features.txt b/Documentation/powerpc/cpu_features.txt
index ffa4183..ae09df8 100644
--- a/Documentation/powerpc/cpu_features.txt
+++ b/Documentation/powerpc/cpu_features.txt
@@ -11,10 +11,10 @@ split instruction and data caches, and if the CPU supports the DOZE and NAP
 sleep modes.
 
 Detection of the feature set is simple. A list of processors can be found in
-arch/ppc/kernel/cputable.c. The PVR register is masked and compared with each
-value in the list. If a match is found, the cpu_features of cur_cpu_spec is
-assigned to the feature bitmask for this processor and a __setup_cpu function
-is called.
+arch/powerpc/kernel/cputable.c. The PVR register is masked and compared with
+each value in the list. If a match is found, the cpu_features of cur_cpu_spec
+is assigned to the feature bitmask for this processor and a __setup_cpu
+function is called.
 
 C code may test 'cur_cpu_spec[smp_processor_id()]->cpu_features' for a
 particular feature bit. This is done in quite a few places, for example
@@ -51,6 +51,6 @@ should be used in the majority of cases.
 
 The END_FTR_SECTION macros are implemented by storing information about this
 code in the '__ftr_fixup' ELF section. When do_cpu_ftr_fixups
-(arch/ppc/kernel/misc.S) is invoked, it will iterate over the records in
+(arch/powerpc/kernel/misc.S) is invoked, it will iterate over the records in
 __ftr_fixup, and if the required feature is not present it will loop writing
 nop's from each BEGIN_FTR_SECTION to END_FTR_SECTION.
-- 
1.8.0.2
