Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQw6s0H5HzDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 21:20:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@ozlabs.org
Subject: Re: 4.13-rc3: Unrecoverable exception 4100
In-Reply-To: <mvma83boe46.fsf@linux-m68k.org>
References: <87vam3lhtn.fsf__12885.8019285419$1501844971$gmane$org@linux-m68k.org>
 <87fud7ktqf.fsf__17563.3519575515$1501875675$gmane$org@linux-m68k.org>
 <877eyjkt0u.fsf@linux-m68k.org> <20170805233917.72e49d2f@roar.ozlabs.ibm.com>
 <877eyfpupf.fsf@concordia.ellerman.id.au> <mvma83boe46.fsf@linux-m68k.org>
Date: Mon, 07 Aug 2017 21:20:03 +1000
Message-ID: <87y3qvoc9o.fsf@concordia.ellerman.id.au>
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

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Aug 07 2017, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Ah of course. Not sure why I haven't seen it in any of my testing :/
>
> It took me a whole gcc bootstrap to trigger it.

OK. I tried a few kernel builds, but I guess a GCC bootstrap takes a
while longer ;)

The other thing is most of our systems now have 1T segments, which means
you're less likely to take an SLB miss in the first place. Though we do
have disable_1t_segments for turning them off, precisely to test this
kind of code.

cheers
