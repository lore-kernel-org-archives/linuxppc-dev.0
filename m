Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTg91yvFzDqmN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:51:01 +1000 (AEST)
Message-ID: <1466470260.3089.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/align: Use #ifdef __BIG_ENDIAN__ #else for
 REG_BYTE
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Cc: linuxppc-dev@ozlabs.org, Daniel Axtens <dja@axtens.net>
Date: Tue, 21 Jun 2016 10:51:00 +1000
In-Reply-To: <7459954.Ax6T6W22CJ@wuerfel>
References: <1466080421-25188-1-git-send-email-mpe@ellerman.id.au>
 <6933845.bk2S1M4pvP@wuerfel> <8760t8mqrc.fsf@possimpible.ozlabs.ibm.com>
 <7459954.Ax6T6W22CJ@wuerfel>
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

On Fri, 2016-06-17 at 12:46 +0200, Arnd Bergmann wrote:
> On Friday, June 17, 2016 1:35:35 PM CEST Daniel Axtens wrote:
> > > It would be better to fix the sparse compilation so the same endianess
> > > is set that you get when calling gcc.
> > 
> > I will definitely work on a patch to sparse! I'd still like this or
> > something like it to go in though, so we can keep working on reducing
> > the sparse warning count while the sparse patch is in the works.
> 
> I think you just need to fix the Makefile so it sets the right
> arguments when calling sparse.
> 
> Something like the (untested) patch below, similar to how we
> already handle the word size and how some other architectures
> handle setting __BIG_ENDIAN__.

Yep that's clearly better. I didn't know we had separate CHECKER_FLAGS.

Daniel can you test that?

Arnd we'll add Suggested-by: you, or send a SOB if you like?

cheers
