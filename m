Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwXw14Nq4zDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 20:22:57 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Thu, 28 Apr 2016 20:22:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 741322CE805F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 20:22:38 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3SAMRRH44826790
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 20:22:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3SAM0go026801
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 20:22:01 +1000
Message-ID: <5721E427.3000109@linux.vnet.ibm.com>
Date: Thu, 28 Apr 2016 18:21:27 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Boqun Feng <boqun.feng@gmail.com>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V4] powerpc: Implement {cmp}xchg for u8 and u16
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com> <5720837D.6050807@linux.vnet.ibm.com>
 <20160427135817.GJ3369@insomnia> <20160427145034.GL3369@insomnia>
 <20160427145937.GM3369@insomnia>
In-Reply-To: <20160427145937.GM3369@insomnia>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年04月27日 22:59, Boqun Feng wrote:
> On Wed, Apr 27, 2016 at 10:50:34PM +0800, Boqun Feng wrote:
>>
>> Sorry, my bad, we can't implement cmpxchg like this.. please ignore
>> this, I should really go to bed soon...
>>
>> But still, we can save the "tmp" for xchg() I think.
>>
> 
> No.. we can't. Sorry for all the noise.
> 
> This patch looks good to me.
> 
> FWIW, you can add
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> 
thanks!

> Regards,
> Boqun
> 
