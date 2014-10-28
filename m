Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33F621A00B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 05:02:30 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 28 Oct 2014 12:02:27 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1FD8BC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 13:51:08 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9SI2OKf50725032
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 18:02:24 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9SI2OOE031087
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 14:02:24 -0400
Date: Tue, 28 Oct 2014 10:33:19 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/2] powerpc/numa: ensure per-cpu NUMA mappings are correct on
 topology update
Message-ID: <20141028173318.GA4211@linux.vnet.ibm.com>
References: <20141018005040.GB3969@linux.vnet.ibm.com>
 <20141021043627.99A4F14008C@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141021043627.99A4F14008C@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Michael Wang <wangyun@linux.vnet.ibm.com>, Li Zhong <zhong@linux.vnet.ibm.com>,
 jstancek@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 21.10.2014 [15:36:27 +1100], Michael Ellerman wrote:
> On Sat, 2014-18-10 at 00:50:40 UTC, Nishanth Aravamudan wrote:
> > We received a report of warning in kernel/sched/core.c where the sched
> > group was NULL on an LPAR after a topology update. This seems to occur
> > because after the topology update has moved the CPUs, cpu_to_node is
> > returning the old value still, which ends up breaking the consistency of
> > the NUMA topology in the per-cpu maps. Ensure that we update the per-cpu
> > fields when we re-map CPUs.
> 
> This looks like a bug fix, I assume you want it to go in for 3.18 ?

Yes, please!

Thanks,
Nish
