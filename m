Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYVvz2dcrzDrHC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 14:48:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org
Subject: Re: [RFC v7 24/25] powerpc: Deliver SEGV signal on pkey violation
In-Reply-To: <20170817171408.GF5505@ram.oc3035372033.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-25-git-send-email-linuxram@us.ibm.com>
 <87378zkuil.fsf@linux.vnet.ibm.com> <87a836csdl.fsf@concordia.ellerman.id.au>
 <20170817171408.GF5505@ram.oc3035372033.ibm.com>
Date: Fri, 18 Aug 2017 14:48:31 +1000
Message-ID: <878tihqy5c.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:
> On Fri, Aug 11, 2017 at 08:26:30PM +1000, Michael Ellerman wrote:
>> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>> 
>> > Ram Pai <linuxram@us.ibm.com> writes:
>> >
>> >> The value of the AMR register at the time of exception
>> >> is made available in gp_regs[PT_AMR] of the siginfo.
...
>> 
>> I don't understand why we are putting it in there at all?
>> 
>> Is there some special handling of the actual register on signals? I
>> haven't seen it. In which case the process can get the value of AMR by
>> reading the register. ??
>
> The value of AMR register at the time of the key-exception may not be
> the same when the signal handler is invoked. 

Why not?

cheers
