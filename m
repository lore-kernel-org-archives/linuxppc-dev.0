Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVX7R31f7zDqmC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 15:31:47 +1000 (AEST)
Message-ID: <1466055106.5400.7.camel@ellerman.id.au>
Subject: Re: [PATCH][V2] Add support for power9 in ibm_architecture_vec
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>
Date: Thu, 16 Jun 2016 15:31:46 +1000
In-Reply-To: <c624cbd5-0017-5408-a146-949f3950ba69@gmail.com>
References: <900d62c2-8bdf-839a-49fa-99aff00a4d87@gmail.com>
 <87k2hqaegk.fsf@skywalker.in.ibm.com>
 <CAKTCnzmLQoBLTyE+bDqwbCTJ+zDLih1Xzm17Qf3M=8v2MBAptQ@mail.gmail.com>
 <87h9cua1fl.fsf@skywalker.in.ibm.com>
 <8d2526bd-1f31-bcfc-d188-5b15cb0624e8@gmail.com>
 <c624cbd5-0017-5408-a146-949f3950ba69@gmail.com>
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

> Subject: [PATCH][V2] Add support for power9 in ibm_architecture_vec

Can you use "[PATCH v2]", my scripts don't grok your format.

On Thu, 2016-06-16 at 14:54 +1000, Balbir Singh wrote:
> 
> On 16/06/16 10:09, Balbir Singh wrote:

> > Yes, my bad.. I'll respin. I thought I had it, but I clearly did not
> > 

Please don't send patches in replies like this, I have to manually clean the
above up before committing.
 
> V2: Update the vector length for OV1 after adding 3.0 support

This should go below the "---" line so that it's stripped from the history.

> The PVR list has been updated and IBM_ARCH_VEC_NRCORES_OFFSET.
> This provides the cpu version supported to the hypervisor

Can you give me more explanation of the practical effects of the patch. eg. This
allows guests kernels to signal to the hypervisor that they support ISA 3.0
features.

cheers
