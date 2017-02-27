Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWypv11ytzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 21:38:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Tobin C. Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: PowerPC build fail
In-Reply-To: <20170222012252.GD6131@eros>
References: <20170222012252.GD6131@eros>
Date: Mon, 27 Feb 2017 21:38:13 +1100
Message-ID: <87r32jrka2.fsf@concordia.ellerman.id.au>
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

Hi Tobin,

"Tobin C. Harding" <me@tobin.cc> writes:
> The current (2bfe01e) torvalds git tree fails to build on powerpc64. Buil=
d machine
> is virtualized.
>
> - Build error
> arch/powerpc/kernel/time.c: In function =E2=80=98running_clock=E2=80=99:
> arch/powerpc/kernel/time.c:712:25: error: implicit declaration of functio=
n =E2=80=98cputime_to_nsecs=E2=80=99
>    return local_clock() - cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPU=
TIME_STEAL]);
>                           ^
...
>
> If you think this can be fixed with the *little* kernel dev knowledge
> I have please point me at a starting place and I will dig into it.

Thanks for trying to fix it.

You got unlucky and pulled Linus' tree just after a cleanup series was
merged, but before all the bugs had been shaken out.

cheers
