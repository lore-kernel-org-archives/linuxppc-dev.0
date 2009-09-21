Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [59.145.155.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00646B7CE1
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 15:21:55 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp04.in.ibm.com (8.14.3/8.13.1) with ESMTP id n8L5LpbB008909
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 10:51:51 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8L5LpMN2789564
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 10:51:51 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8L5LoIQ006183
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 10:51:50 +0530
Message-ID: <4AB70D6D.6060702@in.ibm.com>
Date: Mon, 21 Sep 2009 10:51:49 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: 2.6.31-git10 : perf counters build failure on powerpc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Latest 31 git(2.6.31-git10 : ebc79c4f8da0f92efa968e0328f32334a2ce80cf)
fails to build on powerpc with following error

arch/powerpc/kernel/perf_counter.c: In function 'record_and_restart':
arch/powerpc/kernel/perf_counter.c:1165: error: unknown field 'regs' specified in initializer
cc1: warnings being treated as errors
arch/powerpc/kernel/perf_counter.c:1165: error: initialization makes integer from pointer without a cast
arch/powerpc/kernel/perf_counter.c:1173: error: too few arguments to function 'perf_counter_overflow'
make[1]: *** [arch/powerpc/kernel/perf_counter.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
