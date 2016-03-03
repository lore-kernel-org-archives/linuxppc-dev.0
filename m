Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD2CF1A0B66
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:08:00 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D733140D86
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 10:08:00 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 4 Mar 2016 09:07:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0D3962CE8054
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 10:07:58 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u23N7nLq45351164
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2016 10:07:57 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u23N7PwL016325
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2016 10:07:25 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u23N7PZe015856
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2016 10:07:25 +1100
Received: from camb691.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 018E3A01CA
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 10:07:01 +1100 (AEDT)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] selftests/powerpc: benchmarks/context_switch.c improve
 usage message
Date: Fri,  4 Mar 2016 10:06:39 +1100
Message-Id: <1457046400-29276-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/benchmarks/context_switch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/context_switch.c b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
index 7b78594..e6af382 100644
--- a/tools/testing/selftests/powerpc/benchmarks/context_switch.c
+++ b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
@@ -369,11 +369,11 @@ static void usage(void)
 	fprintf(stderr, "\t\t--process\tUse processes (default threads)\n");
 	fprintf(stderr, "\t\t--timeout=X\tDuration in seconds to run (default 30)\n");
 	fprintf(stderr, "\t\t--vdso\t\ttouch VDSO\n");
-	fprintf(stderr, "\t\t--fp\t\ttouch FP\n");
+	fprintf(stderr, "\t\t--no-fp\t\tDon't touch FP\n");
 #ifdef __powerpc__
-	fprintf(stderr, "\t\t--altivec\ttouch altivec\n");
+	fprintf(stderr, "\t\t--no-altivec\tDon't touch altivec\n");
 #endif
-	fprintf(stderr, "\t\t--vector\ttouch vector\n");
+	fprintf(stderr, "\t\t--no-vector\tDon't touch vector\n");
 }
 
 int main(int argc, char *argv[])
-- 
2.7.2
