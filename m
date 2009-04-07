Return-Path: <hugh@veritas.com>
Received: from extu-mxob-1.symantec.com (extu-mxob-1.symantec.com
	[216.10.194.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "extu-mxob-1.symantec.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E9ADEDDF1C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 16:11:52 +1000 (EST)
Date: Tue, 7 Apr 2009 07:10:50 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/3] powerpc: allow 256kB pages with SHMEM
In-Reply-To: <18906.51307.281300.189948@drongo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0904070704110.28004@blonde.anvils>
References: <Pine.LNX.4.64.0904062151250.21044@blonde.anvils>
	<Pine.LNX.4.64.0904062156290.21044@blonde.anvils>
	<18906.51307.281300.189948@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: yanok@emcraft.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, prodyuth@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 7 Apr 2009, Paul Mackerras wrote:
> Hugh Dickins writes:
> 
> > Now that shmem's divisions by zero and SHMEM_MAX_BYTES are fixed,
> > let powerpc 256kB pages coexist with CONFIG_SHMEM again.
> > 
> > Signed-off-by: Hugh Dickins <hugh@veritas.com>
> > ---
> > Added linuxppc-dev and some other Cc's for this 3/3: sorry
> > if you didn't see 1/3 and 2/3, they were just in mm/shmem.c.
> 
> Looks OK - what path are you using to get the series upstream?
> (I.e. should I be putting 3/3 in the powerpc tree or are you going to
> push it along with the others?)

If it's OK with you (and you're saying it is), I think the best
would be for it to sit alongside 1/3 and 2/3 in Andrew's tree,
hopefully get an Ack from Yuri (I don't have any powerpc 256kB
pages myself to test it fully), and then go on into 2.6.30.

Hugh
