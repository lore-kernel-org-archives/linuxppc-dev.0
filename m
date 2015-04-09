Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B553E1A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 08:37:15 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 9 Apr 2015 16:37:13 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2898D1FF0025
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 16:28:22 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t39MbBlc53018670
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Apr 2015 15:37:11 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t39MbAh2015491
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Apr 2015 16:37:10 -0600
Date: Thu, 9 Apr 2015 15:37:09 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: Topology updates and NUMA-level sched domains
Message-ID: <20150409223709.GF53918@linux.vnet.ibm.com>
References: <20150406214558.GA38501@linux.vnet.ibm.com>
 <20150407102147.GJ23123@twins.programming.kicks-ass.net>
 <20150407171410.GA62529@linux.vnet.ibm.com>
 <20150407194129.GT23123@twins.programming.kicks-ass.net>
 <552503A1.3050502@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <552503A1.3050502@inria.fr>
Cc: Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
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

On 08.04.2015 [12:32:01 +0200], Brice Goglin wrote:
> Le 07/04/2015 21:41, Peter Zijlstra a écrit :
> > No, that's very much not the same. Even if it were dealing with hotplug
> > it would still assume the cpu to return to the same node.
> >
> > But mostly people do not even bother to handle hotplug.
> >
> 
> You said userspace assumes the cpu<->node relation is a boot-time fixed
> one, and hotplug breaks this. How do you expect userspace to handle
> hotplug? Is there a convenient way to be notified when a CPU (or memory)
> is unplugged?

There is some mention of "User Space Notification" in cpu-hotplug.txt,
but no idea if it's current.

-Nish
