Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mSNN5KTTzDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 22:33:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 rashmica <rashmicy@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/test_hexdump: fix failure on big endian cpu
In-Reply-To: <17a90b003bcc2f1dda2b92b65f16c212ffddc571.camel@linux.intel.com>
References: <f3112437f62c2f48300535510918e8be1dceacfb.1533610877.git.christophe.leroy@c-s.fr>
 <87mutxb9qy.fsf@concordia.ellerman.id.au>
 <7857c69a-a209-541b-b2e1-9fe2e288ca65@gmail.com>
 <87ftzo9i77.fsf@concordia.ellerman.id.au>
 <17a90b003bcc2f1dda2b92b65f16c212ffddc571.camel@linux.intel.com>
Date: Thu, 09 Aug 2018 22:33:38 +1000
Message-ID: <8736vnafdp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> On Thu, 2018-08-09 at 16:18 +1000, Michael Ellerman wrote:
>> rashmica <rashmicy@gmail.com> writes:
>> > On 08/08/18 17:25, Michael Ellerman wrote:
>> > > Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> > > > 
>> > mpe I sent a patch doing that awhile ago and you obviously didn't
>> > like
>> > it because you never merged it :P
>
> Hmm... I (as an author of the test case) never saw that patch.

I probably told Rashmica to send it to the linuxppc list and then I was
meant to follow up who should merge it. So my fault.

>> Sorry, I wasn't sure who should merge it, and never followed up.
>
> lib/* most of the time under Andrew's responsibility, though since it's
> orphaned in MAINTAINERS, anyone can push, though, I think, it's good to
> notify Andrew.

Yeah. I was going to apply it with your Ack because it seems pretty
uncontroversial, and there's nothing else in linux-next touching that
file so it should be conflict-free.

I guess I'll wait and see if Andrew would prefer to take it.

cheers
