Return-Path: <Brice.Goglin@inria.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6220D1A051A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 20:42:48 +1000 (AEST)
Message-ID: <552503A1.3050502@inria.fr>
Date: Wed, 08 Apr 2015 12:32:01 +0200
From: Brice Goglin <Brice.Goglin@inria.fr>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Topology updates and NUMA-level sched domains
References: <20150406214558.GA38501@linux.vnet.ibm.com>
 <20150407102147.GJ23123@twins.programming.kicks-ass.net>
 <20150407171410.GA62529@linux.vnet.ibm.com>
 <20150407194129.GT23123@twins.programming.kicks-ass.net>
In-Reply-To: <20150407194129.GT23123@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Cc: Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
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

Le 07/04/2015 21:41, Peter Zijlstra a écrit :
> No, that's very much not the same. Even if it were dealing with hotplug
> it would still assume the cpu to return to the same node.
>
> But mostly people do not even bother to handle hotplug.
>

You said userspace assumes the cpu<->node relation is a boot-time fixed
one, and hotplug breaks this. How do you expect userspace to handle
hotplug? Is there a convenient way to be notified when a CPU (or memory)
is unplugged?

thanks
Brice
