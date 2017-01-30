Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBbJM28hjzDq99
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 15:00:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-next: manual merge of the rcu tree with the powerpc-fixes
 tree
In-Reply-To: <20170130134645.5464272d@canb.auug.org.au>
References: <20170130134645.5464272d@canb.auug.org.au>
Date: Mon, 30 Jan 2017 15:00:02 +1100
Message-ID: <87y3xtw62l.fsf@concordia.ellerman.id.au>
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

> Hi Paul,
>
> Today's linux-next merge of the rcu tree got a conflict in:
>
>   arch/powerpc/Kconfig
>
> between commit:
>
>   f2574030b0e3 ("powerpc: Revert the initial stack protector support")
>
> from the powerpc-fixes tree and commit:
>
>   c7327406b3c3 ("rcu: Make arch select smp_mb__after_unlock_lock() strength")
>
> from the rcu tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks.

One of these years I'm totally going to sort the selects under config
PPC :/

cheers
