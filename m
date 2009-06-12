Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0873EB71C6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 18:16:16 +1000 (EST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2D93DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 18:16:15 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5C8EC9l023865
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 18:14:12 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5C8GF7m762024
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 18:16:15 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5C8GE7o020178
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 18:16:15 +1000
Message-ID: <4A320ECC.6000107@in.ibm.com>
Date: Fri, 12 Jun 2009 13:46:12 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: Re: [PowerPC] 2.6.30-git3 build break : perf counters
References: <4A31ECCD.7030805@in.ibm.com> <1244788494.5554.1.camel@ht.satnam>
In-Reply-To: <1244788494.5554.1.camel@ht.satnam>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Paul Mackerras <paulus@samba.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jaswinder Singh Rajput wrote:
> Please check this patch :
>
> [PATCH] powerpc: perf_counter fix performance counter event types
>
> Fix compilation warnings :
>  CC      arch/powerpc/kernel/power7-pmu.o
> arch/powerpc/kernel/power7-pmu.c:297: error: PERF_COUNT_CPU_CYCLES undeclared here (not in a function)
> arch/powerpc/kernel/power7-pmu.c:297: error: array index in initializer not of integer type
> arch/powerpc/kernel/power7-pmu.c:297: error: (near initialization for power7_generic_events)
> arch/powerpc/kernel/power7-pmu.c:298: error: PERF_COUNT_INSTRUCTIONS undeclared here (not in a function)
> arch/powerpc/kernel/power7-pmu.c:298: error: array index in initializer not of integer type
> ......<SNIP>......
>
> Reported-by: Sachin Sant <sachinp@in.ibm.com>
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> ---
>   
Yes this fixed the build error.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
