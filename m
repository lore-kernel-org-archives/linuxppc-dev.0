Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9BC362C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 21:20:29 +1100 (EST)
Date: Tue, 25 Feb 2014 11:20:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 02/11] perf core: export swevent hrtimer helpers
Message-ID: <20140225102008.GI9987@twins.programming.kicks-ass.net>
References: <1392415338-16288-3-git-send-email-cody@linux.vnet.ibm.com>
 <20140225033326.7BB942C0228@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140225033326.7BB942C0228@ozlabs.org>
Cc: Cody P Schafer <cody@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 25, 2014 at 02:33:26PM +1100, Michael Ellerman wrote:
> On Fri, 2014-14-02 at 22:02:06 UTC, Cody P Schafer wrote:
> > Export the swevent hrtimer helpers currently only used in events/core.c
> > to allow the addition of architecture specific sw-like pmus.
> 
> Peter, Ingo, can we get your ACK on this please?

How are they used? I saw some usage in patch 9 or so; but its not
explained anywhere. All patches have non-existent Changelogs and the few
comments that are there are pretty hardware specific.

So please do tell; what do you need this for?
