Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDS5y5kdhzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 15:42:30 +1100 (AEDT)
Message-ID: <1486010533.4850.26.camel@kernel.crashing.org>
Subject: Re: [RFC] implement QUEUED spinlocks on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric Dumazet <edumazet@google.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Kevin Hao <haokexin@gmail.com>,
 Torsten Duwe <duwe@suse.de>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Date: Thu, 02 Feb 2017 15:42:13 +1100
In-Reply-To: <CANn89iKVtGt=mL32BVryzSCHcuNR93jO+GzR+pgr-1NHast26g@mail.gmail.com>
References: <1485968734.6360.154.camel@edumazet-glaptop3.roam.corp.google.com>
 <1485981445.4850.8.camel@kernel.crashing.org>
 <87y3xpb5li.fsf@concordia.ellerman.id.au>
 <CANn89iKVtGt=mL32BVryzSCHcuNR93jO+GzR+pgr-1NHast26g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-01 at 20:40 -0800, Eric Dumazet wrote:
> A typical benchmark would be to use 200 concurrent netperf -t TCP_RR,
> through a single qdisc (protected by a spinlock)
> 
> Non ticket/queued spinlocks behave quite bad in this scenario.
> 
> I can try this next week if you want.

That would be great !

Cheers,
Ben.
