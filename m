Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsmqw1CfgzDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 02:11:23 +1000 (AEST)
Date: Wed, 13 Sep 2017 18:11:16 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <masriniv@in.ibm.com>, Gautham R
 Shenoy <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, Anton
 Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: POWER9 PMU stops after idle workaround
Message-ID: <20170913181116.7c202661@kitsune.suse.cz>
In-Reply-To: <3xNQyy1Ck3z9s7v@ozlabs.org>
References: <20170720015322.24307-1-npiggin@gmail.com>
 <3xNQyy1Ck3z9s7v@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  3 Aug 2017 20:19:38 +1000 (AEST)
Michael Ellerman <patch-notifications@ellerman.id.au> wrote:

> On Thu, 2017-07-20 at 01:53:22 UTC, Nicholas Piggin wrote:
> > POWER9 DD2 PMU can stop after a state-loss idle in some conditions.
> > 
> > A solution is to set then clear MMCRA[60] after wake from state-loss
> > idle.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> > Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> > Acked-by: Anton Blanchard <anton@samba.org>  
> 
> Applied to powerpc fixes, thanks.
> 
> https://git.kernel.org/powerpc/c/bdd21ddb919d28f9c62cdc6286cac9
> 
> cheers

Not there anymore. I see this only in the merge branch.

Thanks

Michal
