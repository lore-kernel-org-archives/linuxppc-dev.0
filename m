Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2025FC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:56:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3892086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3892086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h6XX2CfvzDqk8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:56:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5mM6lDpzDr27
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:21:23 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MI5YH-1gz3CJ1jIl-00FCrc; Fri, 18 Jan 2019 17:19:52 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 27/29] y2038: remove struct definition redirects
Date: Fri, 18 Jan 2019 17:18:33 +0100
Message-Id: <20190118161835.2259170-28-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EG3noAGakGQOsRQ5AkLHyXRUkGijSSB6s3eFNDqHNQyvbIBTL7m
 JfLmqyrr1yUW0y7/bJUOCIGESoJzPxNKSv3gPY+AYO56cuN9R1BQnLcflkpPuxKXL/exW87
 uKbBZp6bBdkWIfOuXikfahoV+9f40jWboNWbx4oPta+8B4VOEdb4lD8U/m3ozWkbmbkaYJD
 UyoygynpmqesVKKGGQlVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:56kzD9MVFwU=:6aDO/AkjMabav72O9jx7MK
 U0LyhYNJzvpGD6Kghl69p0RWKxOMgrSkvV8EsPKrcxQ3+KJ2oJTwVPE0uSH86On0XDWbROhFv
 YhOw/nnbEzWG2NsY7XTgHO+lE8ZHXZT28koU2DqR/yLDCt5BQAFCfijBLGaRcmWGrRQgb4cmm
 dbtAZ/dQX29Srh/qT+agh8bbkVJMvXb37egxxoGChknwb6mFjq3oIoWHpHmqn9xMqgEF4r8JQ
 3pUmmq38fkuvj4sqsKjjVD4WSILFbKNH6m48uCtHB8vLz6mpVq5rK8qpfcqcxms5+p0h0lNPy
 XA7PrG7lo4/dYnlcIE4wwPdTOT8I+sLf2/EC5HkBt7Vux/p9xv/zPMbLsa6/nbnl5wYhaR9Y+
 1KIFbXamK2OQhAUN3EhhN/86TrYPRsp9j9n2hEBwPYlOaYxEfAMtYwOXuyYAo8TPrBdSULabC
 XiAo4SntznMkCYQzGRQ9MBR+HkO4IhtaxS/Fl3bwC9olG9NI4kIO5EENU8i4bq1gu6YMFBsid
 BtfCJIGerqELfzRaPOTOteF7CTnRSISVjvaOsbMLRF9GzbdyvwzX1T3d0LL6Cc46sACk5ZzO4
 yi4MhrI0pn5C/3yeGDaHcdeMFzSgQKjodnOqhbo3ZoHxoiMRJPf8SnP6BWP67xl0tROE17JqV
 E+j1tkEOre45LgmlR2duWG3BntyhzzCBrAzMhj1xKS/swWU7ig5kgNOOz6hmRoSNqpw+XSVOt
 hOxOmDl1R8vqVXVFucLVmXnU7RaJ0l1PnpBizw==
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 firoz.khan@linaro.org, mattst88@gmail.com, fenghua.yu@intel.com,
 Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-fsdevel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tony.luck@intel.com, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We now use 64-bit time_t on all architectures, so the __kernel_timex,
__kernel_timeval and __kernel_timespec redirects can be removed
after having served their purpose.

This makes it all much less confusing, as the __kernel_* types
now always refer to the same layout based on 64-bit time_t across
all 32-bit and 64-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/time64.h     | 8 --------
 include/linux/timex.h      | 7 -------
 include/uapi/linux/time.h  | 4 ----
 include/uapi/linux/timex.h | 2 --
 4 files changed, 21 deletions(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index 05634afba0db..f38d382ffec1 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -7,14 +7,6 @@
 typedef __s64 time64_t;
 typedef __u64 timeu64_t;
 
-/* CONFIG_64BIT_TIME enables new 64 bit time_t syscalls in the compat path
- * and 32-bit emulation.
- */
-#ifndef CONFIG_64BIT_TIME
-#define __kernel_timespec timespec
-#define __kernel_itimerspec itimerspec
-#endif
-
 #include <uapi/linux/time.h>
 
 struct timespec64 {
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 4aff9f0d1367..ce0859763670 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -53,13 +53,6 @@
 #ifndef _LINUX_TIMEX_H
 #define _LINUX_TIMEX_H
 
-/* CONFIG_64BIT_TIME enables new 64 bit time_t syscalls in the compat path
- * and 32-bit emulation.
- */
-#ifndef CONFIG_64BIT_TIME
-#define __kernel_timex timex
-#endif
-
 #include <uapi/linux/timex.h>
 
 #define ADJ_ADJTIME		0x8000	/* switch between adjtime/adjtimex modes */
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 6b56a2208be7..b03f8717c312 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -42,19 +42,15 @@ struct itimerval {
 	struct timeval it_value;	/* current value */
 };
 
-#ifndef __kernel_timespec
 struct __kernel_timespec {
 	__kernel_time64_t       tv_sec;                 /* seconds */
 	long long               tv_nsec;                /* nanoseconds */
 };
-#endif
 
-#ifndef __kernel_itimerspec
 struct __kernel_itimerspec {
 	struct __kernel_timespec it_interval;    /* timer period */
 	struct __kernel_timespec it_value;       /* timer expiration */
 };
-#endif
 
 /*
  * legacy timeval structure, only embedded in structures that
diff --git a/include/uapi/linux/timex.h b/include/uapi/linux/timex.h
index a1c6b73016a5..9f517f9010bb 100644
--- a/include/uapi/linux/timex.h
+++ b/include/uapi/linux/timex.h
@@ -97,7 +97,6 @@ struct __kernel_timex_timeval {
 	long long		tv_usec;
 };
 
-#ifndef __kernel_timex
 struct __kernel_timex {
 	unsigned int modes;	/* mode selector */
 	int :32;            /* pad */
@@ -131,7 +130,6 @@ struct __kernel_timex {
 	int  :32; int  :32; int  :32; int  :32;
 	int  :32; int  :32; int  :32;
 };
-#endif
 
 /*
  * Mode codes (timex.mode)
-- 
2.20.0

