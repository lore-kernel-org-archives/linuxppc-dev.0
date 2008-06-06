Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id BABC4DE1F4
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 21:54:30 +1000 (EST)
Date: Fri, 6 Jun 2008 14:53:47 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: 4xx support in arch/ppc is going away Real Soon Now
Message-ID: <20080606115347.GC472@cs181133002.pp.htv.fi>
References: <20080605095253.7df9dbe0@zod.rchland.ibm.com>
	<fa686aa40806050811t4ab2fbfk9eed34d0972376c4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa40806050811t4ab2fbfk9eed34d0972376c4@mail.gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2008 at 09:11:48AM -0600, Grant Likely wrote:
> On Thu, Jun 5, 2008 at 8:52 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > This commit (patch omitted due to size) is sitting in my local tree:
> >
> > commit 0d7efc1e80fc262bcc507a605482c5681e3f082a
> > Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > Date:   Thu Jun 5 09:46:17 2008 -0500
> >
> >    ppc/4xx: Remove 4xx support from arch/ppc
> >
> >    Remove support for PPC 403, 405, and 440 processors from arch/ppc.  The
> >    arch/powerpc equivalents should be used.  Boards that are not ported yet
> >    will need to be ported to arch/powerpc to have continued support.
> 
> This looks like unneeded churn.
> 
> Paulus, Can we just kill all of arch/ppc for .27 right now?

Is anyone already working on doing this and the cleanups that will then 
be possible?

Otherwise I'll be glad to contribute to it.   :)

BTW:
I remember Paul wanted to get PReP under arch/powerpc/ working -
should this be done before the big ppc removal?

> g.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
