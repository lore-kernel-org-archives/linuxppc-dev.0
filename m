Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpp5c19yJzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 11:56:20 +1000 (AEST)
Message-ID: <1461030979.25103.4.camel@ellerman.id.au>
Subject: Re: linux-next: manual merge of the livepatching tree with the
 powerpc tree
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Axtens
 <dja@axtens.net>
Date: Tue, 19 Apr 2016 11:56:19 +1000
In-Reply-To: <20160418142749.3a5910c6@canb.auug.org.au>
References: <20160418142749.3a5910c6@canb.auug.org.au>
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

On Mon, 2016-04-18 at 14:27 +1000, Stephen Rothwell wrote:
> Hi Jiri,
> 
> Today's linux-next merge of the livepatching tree got a conflict in:
> 
>   arch/powerpc/kernel/process.c
> 
> between commit:
> 
>   7f92bc569455 ("powerpc: sparse: Include headers for __weak symbols")
> 
> from the powerpc tree and commit:
> 
>   5d31a96e6c01 ("powerpc/livepatch: Add livepatch stack to struct thread_info")
> 
> from the livepatching tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks.

This should go away tomorrow because then my next will have the topic branch
merged.

cheers
