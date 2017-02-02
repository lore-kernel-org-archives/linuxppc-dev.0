Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDRGh44VgzDqGJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 15:05:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Eric Dumazet <eric.dumazet@gmail.com>, Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Kevin Hao <haokexin@gmail.com>,
 Torsten Duwe <duwe@suse.de>, Eric Dumazet <edumazet@google.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [RFC] implement QUEUED spinlocks on powerpc
In-Reply-To: <1485981445.4850.8.camel@kernel.crashing.org>
References: <1485968734.6360.154.camel@edumazet-glaptop3.roam.corp.google.com>
 <1485981445.4850.8.camel@kernel.crashing.org>
Date: Thu, 02 Feb 2017 15:04:57 +1100
Message-ID: <87y3xpb5li.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2017-02-01 at 09:05 -0800, Eric Dumazet wrote:
>> Hi all
>> 
>> Is anybody working on adding QUEUED spinlocks to powerpc 64bit ?
>> 
>> I've seen past attempts with ticket spinlocks
>> ( https://patchwork.ozlabs.org/patch/449381/ and other related links
>> )
>> 
>> But it looks ticket spinlocks are a thing of the past.
>
> Yes, we have a tentative implementation of qspinlock and pv variants:
>
> https://patchwork.ozlabs.org/patch/703139/
> https://patchwork.ozlabs.org/patch/703140/
> https://patchwork.ozlabs.org/patch/703141/
> https://patchwork.ozlabs.org/patch/703142/
> https://patchwork.ozlabs.org/patch/703143/
> https://patchwork.ozlabs.org/patch/703144/
>
> Michael, what's the status with getting that merged ?

Needs a good review, and the benchmark results were not all that
compelling - though perhaps they were just the wrong benchmarks.

cheers
