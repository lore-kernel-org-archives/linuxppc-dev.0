Return-Path: <millerjo@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06B9D1A0636
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 05:03:01 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <millerjo@us.ibm.com>;
 Wed, 20 May 2015 13:02:59 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B21F53E40047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 13:02:56 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4KJ2uSZ37224504
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 12:02:56 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4KJ2u7Z005631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 13:02:56 -0600
Date: Wed, 20 May 2015 14:02:55 -0500
From: Jack Miller <millerjo@us.ibm.com>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Fix idle state allocation corruption
Message-ID: <20150520190255.GA29121@toadite.austin.ibm.com>
References: <1432141984-5804-1-git-send-email-millerjo@us.ibm.com>
 <555CC44A.5070508@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <555CC44A.5070508@linux.vnet.ibm.com>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 jk@ozlabs.org, jstancek@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 20, 2015 at 10:58:42PM +0530, Shreyas B Prabhu wrote:
> 
> 
> On Wednesday 20 May 2015 10:43 PM, Jack Miller wrote:
> > pnv_alloc_idle_core_states is iterating over PACAs based on the
> > configured maximum number of CPUs (NR_CPUS), but PACAs are only
> > initialized up to nr_cpu_ids, so rein in loops to keep from overwriting
> > adjacent memory.
> > 
> 
> Hi Jack,
> 
> Jan Stancek has a patch fixing this (d52356e7f powerpc: fix memory
> corruption by pnv_alloc_idle_core_states).

Must've missed it, just ran into the issue and didn't see a fix upstream.
Just found it in the April list archive.

Thanks,

- Jack
