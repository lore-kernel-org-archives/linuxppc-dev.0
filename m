Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hDyl3NhjzF2RB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 10:45:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the powerpc tree with the
 powerpc-fixes tree
In-Reply-To: <20180510101703.57ffb774@canb.auug.org.au>
References: <20180510101703.57ffb774@canb.auug.org.au>
Date: Thu, 10 May 2018 10:45:02 +1000
Message-ID: <87d0y4z6cx.fsf@concordia.ellerman.id.au>
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

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the powerpc tree got a conflict in:
>
>   arch/powerpc/include/asm/ftrace.h
>
> between commit:
>
>   edf6a2dfe388 ("powerpc/trace/syscalls: Update syscall name matching logic to account for ppc_ prefix")
>
> from the powerpc-fixes tree and commit:
>
>   c3e59d778403 ("powerpc64/ftrace: Rearrange #ifdef sections in ftrace.h")
>
> from the powerpc tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> Michael, I think the version in your merge branch is not quite right ...

Yep.

Don't do merges after midnight kids.

I've pushed a fixed version, which I think matches yours.

I'll resolve it in my next when I merge my fixes & next later in the
cycle.

cheers
