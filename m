Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A7D01A0143
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2015 05:51:50 +1000 (AEST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 10 Apr 2015 15:51:48 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E2AC9C90042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 15:42:53 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3AJpaCd21954600
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 19:51:44 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3AJpBFa028385
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 15:51:12 -0400
Date: Fri, 10 Apr 2015 12:50:46 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Topology updates and NUMA-level sched domains
Message-ID: <20150410195046.GB31621@linux.vnet.ibm.com>
References: <20150406214558.GA38501@linux.vnet.ibm.com>
 <20150407102147.GJ23123@twins.programming.kicks-ass.net>
 <20150407171410.GA62529@linux.vnet.ibm.com>
 <20150407194129.GT23123@twins.programming.kicks-ass.net>
 <20150409222956.GE53918@linux.vnet.ibm.com>
 <20150410083153.GQ27490@worktop.programming.kicks-ass.net>
 <20150410090810.GW24151@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150410090810.GW24151@twins.programming.kicks-ass.net>
Cc: Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10.04.2015 [11:08:10 +0200], Peter Zijlstra wrote:
> On Fri, Apr 10, 2015 at 10:31:53AM +0200, Peter Zijlstra wrote:
> > Please, step back, look at what you're doing and ask yourself, will any
> > sane person want to use this? Can they use this?
> > 
> > If so, start by describing the desired user semantics of this work.
> > Don't start by cobbling kernel bits togerther until it stops crashing.
> 
> Also, please talk to your s390 folks. They've long since realized that
> this doesn't work. They've just added big honking caches (their BOOK
> stuff) and pretend the system is UMA.

Interesting, I will take a look.

-Nish
