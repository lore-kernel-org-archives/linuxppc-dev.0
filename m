Return-Path: <hugh@veritas.com>
Received: from extu-mxob-2.symantec.com (extu-mxob-2.symantec.com
	[216.10.194.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "extu-mxob-2.symantec.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 29548DE1A7
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 19:07:49 +1000 (EST)
Date: Fri, 10 Apr 2009 09:58:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] powerpc: allow 256kB pages with SHMEM
In-Reply-To: <20090409163403.e82ec1c3.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0904100945270.2593@blonde.anvils>
References: <Pine.LNX.4.64.0904062151250.21044@blonde.anvils>
	<Pine.LNX.4.64.0904062156290.21044@blonde.anvils>
	<20090409163403.e82ec1c3.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: yanok@emcraft.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, prodyuth@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 9 Apr 2009, Andrew Morton wrote:
> On Mon, 6 Apr 2009 22:01:15 +0100 (BST)
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> > Now that shmem's divisions by zero and SHMEM_MAX_BYTES are fixed,
> > let powerpc 256kB pages coexist with CONFIG_SHMEM again.
> > 
> > Signed-off-by: Hugh Dickins <hugh@veritas.com>
> > ---
> > Added linuxppc-dev and some other Cc's for this 3/3: sorry
> > if you didn't see 1/3 and 2/3, they were just in mm/shmem.c.
> 
> Do we think these patches should be in 2.6.30?

I think so - 2.6.30 will have the rest of Yuri's 256kB page support.
But it would be nice to have an Ack from Yuri before sending these
on through.  2/3 is a bugfix justified even without 256kB pages -
I should have inverted the ordering.

Hugh
