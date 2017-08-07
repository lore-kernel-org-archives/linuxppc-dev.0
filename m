Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQrGw33GyzDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 18:26:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 1/2] powernv/powerpc:Save/Restore additional SPRs for
 stop4 cpuidle
In-Reply-To: <20170807052331.GA30140@in.ibm.com>
References: <cover.1500631040.git.ego@linux.vnet.ibm.com>
 <57ed82bcd92cd4d0af7ae5113710d597a331c433.1500631040.git.ego@linux.vnet.ibm.com>
 <87r2wvsgj1.fsf@concordia.ellerman.id.au> <20170807052331.GA30140@in.ibm.com>
Date: Mon, 07 Aug 2017 18:26:44 +1000
Message-ID: <87bmnrpyuz.fsf@concordia.ellerman.id.au>
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

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> On Tue, Aug 01, 2017 at 08:56:18PM +1000, Michael Ellerman wrote:
>> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>> >
>> > Subject: [v3 PATCH 1/2] powernv/powerpc:Save/Restore additional SPRs for stop4 cpuidle
>> 
>> I know it's not a big deal, but can we agree on the subject format?
>> 
>>   powerpc/powernv: Save/Restore additional SPRs for stop4 cpuidle
>
> Sure. I will repost with the updated subject.

Sorry I had merged them, and fixed the subject up myself. But I didn't
make that very clear in my mail.

So I've merged v3.

cheers
