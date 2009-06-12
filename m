Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 55B2EB71C5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 15:51:19 +1000 (EST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5BCD5DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 15:51:17 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5C5pAYY020623
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 11:21:10 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5C5pAvD360468
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 11:21:10 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5C5pAYE028059
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 15:51:10 +1000
Message-ID: <4A31ECCD.7030805@in.ibm.com>
Date: Fri, 12 Jun 2009 11:21:09 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PowerPC] 2.6.30-git3 build break : perf counters
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2.6.30-git3 build with CONFIG_PERF_COUNTERS=y failed on a powerpc box.

 CC      arch/powerpc/kernel/power7-pmu.o
arch/powerpc/kernel/power7-pmu.c:297: error: PERF_COUNT_CPU_CYCLES undeclared here (not in a function)
arch/powerpc/kernel/power7-pmu.c:297: error: array index in initializer not of integer type
arch/powerpc/kernel/power7-pmu.c:297: error: (near initialization for power7_generic_events)
arch/powerpc/kernel/power7-pmu.c:298: error: PERF_COUNT_INSTRUCTIONS undeclared here (not in a function)
arch/powerpc/kernel/power7-pmu.c:298: error: array index in initializer not of integer type
......<SNIP>......

Porbably because of commit 526e9a09d2e2dcb6c75c68710465678bb647e5fe

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
