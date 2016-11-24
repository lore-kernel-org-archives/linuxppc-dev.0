Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPNjW36ykzDw3Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 13:40:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the powerpc tree with the
 powerpc-fixes tree
In-Reply-To: <20161124103606.0333e388@canb.auug.org.au>
References: <20161124103606.0333e388@canb.auug.org.au>
Date: Thu, 24 Nov 2016 13:40:28 +1100
Message-ID: <87fumhtxb7.fsf@concordia.ellerman.id.au>
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
>   arch/powerpc/include/asm/asm-prototypes.h
>
> between commit:
>
>   9e5f68842276 ("powerpc: Fix missing CRCs, add more asm-prototypes.h declarations")
>
> from the powerpc-fixes tree and commit:
>
>   82de5797a260 ("powerpc: Remove extraneous header from asm-prototypes.h")
>
> from the powerpc tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks. I'm planning to merge fixes into next RSN ... as soon as people
stop finding bugs.

cheers
