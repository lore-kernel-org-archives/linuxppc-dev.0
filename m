Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXPXp3lSyzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 14:42:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: PowerPC build fail
In-Reply-To: <20170227200453.GB3215@eros>
References: <20170222012252.GD6131@eros>
 <87r32jrka2.fsf@concordia.ellerman.id.au> <20170227200453.GB3215@eros>
Date: Tue, 28 Feb 2017 14:42:30 +1100
Message-ID: <8737ezq8ux.fsf@concordia.ellerman.id.au>
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

"Tobin C. Harding" <me@tobin.cc> writes:

> On Mon, Feb 27, 2017 at 09:38:13PM +1100, Michael Ellerman wrote:
>> Hi Tobin,
>>=20
>> "Tobin C. Harding" <me@tobin.cc> writes:
>> > The current (2bfe01e) torvalds git tree fails to build on powerpc64. B=
uild machine
>> > is virtualized.
>> >
>> > - Build error
>> > arch/powerpc/kernel/time.c: In function =E2=80=98running_clock=E2=80=
=99:
>> > arch/powerpc/kernel/time.c:712:25: error: implicit declaration of func=
tion =E2=80=98cputime_to_nsecs=E2=80=99
>> >    return local_clock() - cputime_to_nsecs(kcpustat_this_cpu->cpustat[=
CPUTIME_STEAL]);
>> >                           ^
>> ...
>> >
>> > If you think this can be fixed with the *little* kernel dev knowledge
>> > I have please point me at a starting place and I will dig into it.
>>=20
>> Thanks for trying to fix it.
>>=20
>> You got unlucky and pulled Linus' tree just after a cleanup series was
>> merged, but before all the bugs had been shaken out.
>
> Au contraire, I felt lucky to have bumped into a bug. I would like to
> find more :)

Hah, well, we have *plenty* :)

I keep a rough list of TODO/FIXME type things on github:

  https://github.com/linuxppc/linux/issues/


If there's anything there that you want to have a go at please feel
free. If you have questions you can either comment on the issues or mail
me and/or this list.

cheers
