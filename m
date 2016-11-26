Return-Path: <linus971@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tR30c5YJszDvkT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 06:29:20 +1100 (AEDT)
Received: by mail-io0-x242.google.com with SMTP id r94so15280704ioe.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 11:29:20 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <87inraslrk.fsf@concordia.ellerman.id.au>
References: <87inraslrk.fsf@concordia.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Nov 2016 11:29:17 -0800
Message-ID: <CA+55aFzH+RrkebTvWYtvXOqMmQfrSy=coxt0ms9RGzN3kzxf4g@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.9-6 tag
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nick Piggin <npiggin@gmail.com>, oohall@gmail.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 26, 2016 at 12:11 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> powerpc fixes for 4.9 #6
>
> Fixes marked for stable:
>  - Set missing wakeup bit in LPCR on POWER9 (Benjamin Herrenschmidt)
>  - Fix the early OPAL console wrappers (Oliver O'Halloran)
>  - Fixup kernel read only mapping (Aneesh Kumar K.V)
>
> Fixes for code merged this cycle:
>  - Fix missing CRCs, add more asm-prototypes.h declarations (Nicholas Piggin)

Pulled, but I wanted to talk about your merge "summary".

Your merge summaries seem to be entirely automatically generated,
which makes them less than great. I can see all that stuff in the git
tree already, just formatting it differently isn't all that useful.

For something like this late-rc pull when there are only a couple of
commits, the end result actually ends up looking almost like a summary
and all I did was remove the names that don't add to the description
(and are in the git commits).

For some of the bigger pull requests, the summary is almost anything
but, and the only real value-add is the grouping by subject area.

I really prefer a _summary_. Something that is human-legible. So that
when people read the merge commit log, they get an overview of what
changed, not a list of the details.

Again, when there are four commits, a "list of the details" pretty
much works. So the reason I react to _this_ pull request is mainly
that I have way more time to react to it during the late rc series
than I do earlier in the cycle..

                     Linus
