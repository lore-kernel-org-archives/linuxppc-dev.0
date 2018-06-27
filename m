Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FntX00Q6zF1Cl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 13:08:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Finn Thain <fthain@telegraphics.com.au>, geert@linux-m68k.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] macintosh: Resolve various PMU driver problems
In-Reply-To: <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
Date: Wed, 27 Jun 2018 13:08:50 +1000
Message-ID: <874lhp6i4d.fsf@concordia.ellerman.id.au>
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

Hi Finn, Geert,

Finn Thain <fthain@telegraphics.com.au> writes:
> On Wed, 13 Jun 2018, I wrote:
>
>> Finn Thain (12):
>>   macintosh/via-pmu: Fix section mismatch warning
>>   macintosh/via-pmu: Add missing mmio accessors
>>   macintosh/via-pmu: Don't clear shift register interrupt flag twice
>>   macintosh/via-pmu: Enhance state machine with new 'uninitialized'
>>     state
>>   macintosh/via-pmu: Replace via pointer with via1 and via2 pointers
>>   macintosh/via-pmu: Add support for m68k PowerBooks
>>   macintosh/via-pmu: Make CONFIG_PPC_PMAC Kconfig deps explicit
>>   macintosh/via-pmu68k: Don't load driver on unsupported hardware
>>   macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
>>   macintosh: Use common code to access RTC
>>   macintosh/via-pmu: Clean up interrupt statistics
>>   macintosh/via-pmu: Disambiguate interrupt statistics
>> 
>
> Patch 10/12 ("macintosh: Use common code to access RTC") conflicts with 
> Arnd's RTC work, but the rest of this series can still be reviewed and 
> merged as-is.

OK so you're saying we should drop 10/12 for now.

> I will rewrite patch 10/12 after Arnd's fixes and this series have all 
> made their way through both powerpc and m68k trees, and submit it 
> separately.

drivers/macintosh is supposedly maintained by Ben, but I'm not sure this
series is high on his todo list.

Should it just go in via the m68k tree?

Or I can create a topic branch to share it between ppc and m68k?

cheers
