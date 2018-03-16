Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jH95Q4QzDqxx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:03:01 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id a20so2234880wmd.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:03:01 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 13/19] ppc64: change %llx into %lx
Date: Fri, 16 Mar 2018 12:02:18 +0100
Message-Id: <20180316110224.12260-14-malat@debian.org>
In-Reply-To: <20180316110224.12260-1-malat@debian.org>
References: <20180316110224.12260-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  CC      arch/powerpc/xmon/xmon.o
../arch/powerpc/xmon/xmon.c: In function ‘dump_one_paca’:
../arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘long unsigned int’ [-Werror=format=]
  printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
         ^
../arch/powerpc/xmon/xmon.c:2417:2: note: in expansion of macro ‘DUMP’
  DUMP(p, accounting.utime, "llx");
  ^~~~
../arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘long unsigned int’ [-Werror=format=]
  printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
         ^
../arch/powerpc/xmon/xmon.c:2418:2: note: in expansion of macro ‘DUMP’
  DUMP(p, accounting.stime, "llx");
  ^~~~
../arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘long unsigned int’ [-Werror=format=]
  printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
         ^
../arch/powerpc/xmon/xmon.c:2419:2: note: in expansion of macro ‘DUMP’
  DUMP(p, accounting.utime_scaled, "llx");
  ^~~~
../arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘long unsigned int’ [-Werror=format=]
  printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
         ^
../arch/powerpc/xmon/xmon.c:2420:2: note: in expansion of macro ‘DUMP’
  DUMP(p, accounting.starttime, "llx");
  ^~~~
../arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘long unsigned int’ [-Werror=format=]
  printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
         ^
../arch/powerpc/xmon/xmon.c:2421:2: note: in expansion of macro ‘DUMP’
  DUMP(p, accounting.starttime_user, "llx");
  ^~~~
../arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘long unsigned int’ [-Werror=format=]
  printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
         ^
../arch/powerpc/xmon/xmon.c:2422:2: note: in expansion of macro ‘DUMP’
  DUMP(p, accounting.startspurr, "llx");
  ^~~~
../arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘long unsigned int’ [-Werror=format=]
  printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
         ^
../arch/powerpc/xmon/xmon.c:2423:2: note: in expansion of macro ‘DUMP’
  DUMP(p, accounting.utime_sspurr, "llx");
  ^~~~
../arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘long unsigned int’ [-Werror=format=]
  printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
         ^
../arch/powerpc/xmon/xmon.c:2424:2: note: in expansion of macro ‘DUMP’
  DUMP(p, accounting.steal_time, "llx");
  ^~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 96247ac91a86..61f5e09367d0 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2411,14 +2411,14 @@ static void dump_one_paca(int cpu)
 	DUMP(p, subcore_sibling_mask, "x");
 #endif
 
-	DUMP(p, accounting.utime, "llx");
-	DUMP(p, accounting.stime, "llx");
-	DUMP(p, accounting.utime_scaled, "llx");
-	DUMP(p, accounting.starttime, "llx");
-	DUMP(p, accounting.starttime_user, "llx");
-	DUMP(p, accounting.startspurr, "llx");
-	DUMP(p, accounting.utime_sspurr, "llx");
-	DUMP(p, accounting.steal_time, "llx");
+	DUMP(p, accounting.utime, "lx");
+	DUMP(p, accounting.stime, "lx");
+	DUMP(p, accounting.utime_scaled, "lx");
+	DUMP(p, accounting.starttime, "lx");
+	DUMP(p, accounting.starttime_user, "lx");
+	DUMP(p, accounting.startspurr, "lx");
+	DUMP(p, accounting.utime_sspurr, "lx");
+	DUMP(p, accounting.steal_time, "lx");
 #undef DUMP
 
 	catch_memory_errors = 0;
-- 
2.11.0
