Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZhdT09zpzDqfS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 20:08:29 +1100 (AEDT)
Message-ID: <1459328908.23987.3.camel@ellerman.id.au>
Subject: Re: mailman From rewriting [was perf jit: genelf makes assumptions
 about endian]
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jeremy Kerr <jk@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 Mar 2016 20:08:28 +1100
In-Reply-To: <56FB6464.4010609@ozlabs.org>
References: <20160329175944.33a211cc@kryten> <56FA435A.5010804@ozlabs.org>
 <20160329210639.12136fd5@canb.auug.org.au> <56FB6464.4010609@ozlabs.org>
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

On Wed, 2016-03-30 at 13:30 +0800, Jeremy Kerr wrote:
> > > Do you know why mailman would be re-writing From: there? It's confusing
> > > patchwork, as multiple mails are now coming from that address.
> >
> > Yep, Anton posts from samba.org.  They publish a DMARC policy that
> > breaks mailing lists.
>
> (╯°□°)╯︵ ┻━━┻
>
> This also breaks git-am:
>
>   [jk@pudge linux]$ git am incoming.eml
>   Applying: perf jit: genelf makes assumptions about endian
>   [jk@pudge linux]$ git log --format='format:%an <%ae>' -1
>   Anton Blanchard via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

Actually one thing that makes this less of a problem, is that if you get the
mail directly then the From is fine.

ie. for this patch I was on Cc, so the list didn't send me a copy, I just got
it straight from Anton. So if I was wanting to git-am this mail I'd be fine.

Not saying that's a solution, but it's something.

cheers
