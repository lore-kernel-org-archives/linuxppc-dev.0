Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5DD81A001C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 17:54:47 +1000 (EST)
Message-ID: <53B65DC4.5070001@suse.de>
Date: Fri, 04 Jul 2014 09:54:44 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
Subject: Re: [PATCH 5/6 v2] KVM: PPC: Book3E: Add ONE_REG AltiVec support
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-6-git-send-email-mihai.caraman@freescale.com>
 <53B54DB2.1000805@suse.de>
 <92e31868b99a421ab578640527b41ccf@BY2PR03MB508.namprd03.prod.outlook.com>
In-Reply-To: <92e31868b99a421ab578640527b41ccf@BY2PR03MB508.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.14 18:11, mihai.caraman@freescale.com wrote:
>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Thursday, July 03, 2014 3:34 PM
>> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
>> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [PATCH 5/6 v2] KVM: PPC: Book3E: Add ONE_REG AltiVec support
>>
>>
>> On 30.06.14 17:34, Mihai Caraman wrote:
>>> Add ONE_REG support for AltiVec on Book3E.
>>>
>>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>> Any chance we can handle these in generic code?
> I expected this request :) Can we let this for a second phase to have
> e6500 enabled first?

I don't see the value of duplicating code in e500 specific code only to 
remove and combine it in common code in a follow-up patch after that.

> Can you share with us a Book3S setup so I can validate the requested
> changes? I already fell anxious touching strange hardware specific
> Book3S code without running it.

Until a few weeks ago I had an externally reachable G5 machine that we 
could've used for this. Unfortunately I had to replace the box with 
another one that's not quite as stable. I'll try and see if I can fix or 
replace it soon.


Alex
