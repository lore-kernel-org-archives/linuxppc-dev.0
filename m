Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwZlJ4tPLzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 21:45:31 +1000 (AEST)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Thu, 28 Apr 2016 17:15:27 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id BB6225E869A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 15:54:01 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3SAM1J024182904
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 15:52:01 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3SALshf013578
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 15:52:00 +0530
Message-ID: <5721E437.8050900@linux.vnet.ibm.com>
Date: Thu, 28 Apr 2016 18:21:43 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V4] powerpc: Implement {cmp}xchg for u8 and u16
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com> <5720837D.6050807@linux.vnet.ibm.com>
 <20160428075913.GT3430@twins.programming.kicks-ass.net>
In-Reply-To: <20160428075913.GT3430@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年04月28日 15:59, Peter Zijlstra wrote:
> On Wed, Apr 27, 2016 at 05:16:45PM +0800, Pan Xinhui wrote:
>> From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>>
>> Implement xchg{u8,u16}{local,relaxed}, and
>> cmpxchg{u8,u16}{,local,acquire,relaxed}.
>>
>> It works on all ppc.
>>
>> remove volatile of first parameter in __cmpxchg_local and __cmpxchg
>>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> 
> Generally has the right shape; and I trust others to double check the
> ppc-asm minutia.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> 
thanks!
