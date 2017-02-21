Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSGpB3lnzzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 21:24:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: abdul <abdhalee@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, fweisbec@gmail.com
Subject: Re: [PowerPC] 4.10.0 fails to build on BE config
In-Reply-To: <c7b9f444-f7db-c098-0da9-72daeb844546@linux.vnet.ibm.com>
References: <c7b9f444-f7db-c098-0da9-72daeb844546@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 21:24:43 +1100
Message-ID: <87h93nn8no.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

abdul <abdhalee@linux.vnet.ibm.com> writes:

> Hi,
>
> Today's mainline build, breaks on Power6 and Power7 (all BE config) with=
=20
> these build errors
>
> arch/powerpc/kernel/time.c: In function =E2=80=98running_clock=E2=80=99:
> arch/powerpc/kernel/time.c:712:2: error: implicit declaration of=20
> function =E2=80=98cputime_to_nsecs=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
> return local_clock() -=20
> cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);
> ^
> cc1: some warnings being treated as errors
> make[1]: *** [arch/powerpc/kernel/time.o] Error 1

What exact config is that?

And what compiler are you using?

I build ~250 configs with two different compilers multiple times a day,
so I'm curious how we failed to notice this.

cheers
