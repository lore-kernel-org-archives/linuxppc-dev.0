Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rRKRt1YZ7zDqHF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 10:19:54 +1000 (AEST)
Message-ID: <1465604387.7734.1.camel@ellerman.id.au>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.7-3 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>,
 gwshan@linux.vnet.ibm.com, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Olof Johansson
 <olof@lixom.net>, Paul Mackerras <paulus@ozlabs.org>, raj.khem@gmail.com,
 ruscur@russell.cc, thuth@redhat.com, Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 11 Jun 2016 10:19:47 +1000
In-Reply-To: <CA+55aFy3=ErnkbPmv7Ti1X=SA2i2a7xUv=opiQKW==ZMjSoK2A@mail.gmail.com>
References: <1465559513.32231.2.camel@ellerman.id.au>
 <CA+55aFyn9_q08QCPohiSL5snQjinaqm9rZRvHz2OVd0zzjWaXg@mail.gmail.com>
 <CA+55aFy3=ErnkbPmv7Ti1X=SA2i2a7xUv=opiQKW==ZMjSoK2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-06-10 at 12:26 -0700, Linus Torvalds wrote:
> On Fri, Jun 10, 2016 at 8:48 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Fri, Jun 10, 2016 at 4:51 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > 
> > > powerpc fixes for 4.7 #2
> > 
> > This is actually #3 - and some of the things you describe came in
> > already through #2.
> > 
> > Do you mind double-checking your descriptions?
> 
> I double-checked it. Your diffstat and shortlog were out of date (and
> your #2 in the tag message was wong), but your individual descriptions
> matched the actual new commits.

Sorry, clearly 21:51 on a Friday is not a good time for me to be sending pull
requests :/

The tag was correct, just the diffstat & shortlog were wrong (again).

The #2 in the tag is "correct", but clearly confusing. The powerpc-4.7-1 tag is
"updates", and -2 is "fixes", and so -3 is "fixes #2". But I'll try and come up
with a different numbering that is less off-by-one.

I checked your merge and it looks right. Thanks.

cheers
