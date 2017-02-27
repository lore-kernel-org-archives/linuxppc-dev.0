Return-Path: <me@tobin.cc>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXCNs30QvzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 07:04:59 +1100 (AEDT)
Date: Tue, 28 Feb 2017 07:04:53 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: PowerPC build fail
Message-ID: <20170227200453.GB3215@eros>
References: <20170222012252.GD6131@eros>
 <87r32jrka2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87r32jrka2.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, Feb 27, 2017 at 09:38:13PM +1100, Michael Ellerman wrote:
> Hi Tobin,
> 
> "Tobin C. Harding" <me@tobin.cc> writes:
> > The current (2bfe01e) torvalds git tree fails to build on powerpc64. Build machine
> > is virtualized.
> >
> > - Build error
> > arch/powerpc/kernel/time.c: In function ‘running_clock’:
> > arch/powerpc/kernel/time.c:712:25: error: implicit declaration of function ‘cputime_to_nsecs’
> >    return local_clock() - cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);
> >                           ^
> ...
> >
> > If you think this can be fixed with the *little* kernel dev knowledge
> > I have please point me at a starting place and I will dig into it.
> 
> Thanks for trying to fix it.
> 
> You got unlucky and pulled Linus' tree just after a cleanup series was
> merged, but before all the bugs had been shaken out.

Au contraire, I felt lucky to have bumped into a bug. I would like to
find more :)

Tobin
