Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS1zP6MhfzDvV3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 20:46:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Nick Piggin <npiggin@gmail.com>,
 oohall@gmail.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.9-6 tag
In-Reply-To: <CA+55aFzH+RrkebTvWYtvXOqMmQfrSy=coxt0ms9RGzN3kzxf4g@mail.gmail.com>
References: <87inraslrk.fsf@concordia.ellerman.id.au>
 <CA+55aFzH+RrkebTvWYtvXOqMmQfrSy=coxt0ms9RGzN3kzxf4g@mail.gmail.com>
Date: Mon, 28 Nov 2016 20:46:40 +1100
Message-ID: <87vav8q6m7.fsf@concordia.ellerman.id.au>
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

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Nov 26, 2016 at 12:11 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> powerpc fixes for 4.9 #6
>>
>> Fixes marked for stable:
>>  - Set missing wakeup bit in LPCR on POWER9 (Benjamin Herrenschmidt)
>>  - Fix the early OPAL console wrappers (Oliver O'Halloran)
>>  - Fixup kernel read only mapping (Aneesh Kumar K.V)
>>
>> Fixes for code merged this cycle:
>>  - Fix missing CRCs, add more asm-prototypes.h declarations (Nicholas Piggin)
>
> Pulled, but I wanted to talk about your merge "summary".
>
> Your merge summaries seem to be entirely automatically generated,
> which makes them less than great. I can see all that stuff in the git
> tree already, just formatting it differently isn't all that useful.

OK. The starting point is obviously an automatically generated list of
commits, but I have been editing that a fair bit to drop boring commits
and combine multiple commits into a single line, and then sort it by
topic area etc.

But obviously I'm not editing it enough, so I'll try to summarise it
much more heavily.

> For something like this late-rc pull when there are only a couple of
> commits, the end result actually ends up looking almost like a summary
> and all I did was remove the names that don't add to the description
> (and are in the git commits).

I actually do like to include the names, just to give people a bit of
acknowledgment in the pull request, but I can drop them if you prefer.
Or maybe I'll just include a credits section at the bottom of the tag
with everyone's name once, and you can drop that from the commit?

> For some of the bigger pull requests, the summary is almost anything
> but, and the only real value-add is the grouping by subject area.
>
> I really prefer a _summary_. Something that is human-legible. So that
> when people read the merge commit log, they get an overview of what
> changed, not a list of the details.

Right.

cheers
