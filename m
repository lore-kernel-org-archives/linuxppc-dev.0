Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSm1154HYzDqZV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 18:20:05 +1000 (AEST)
Message-ID: <1465805967.3022.14.camel@kernel.crashing.org>
Subject: Re: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, Michael Ellerman
 <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <michaele@au1.ibm.com>,
 Julian Margetson <runaway@candw.ms>,
 Adrian Cox <adrian@humboldt.co.uk>, "R.T.Dickinson" <rtd@a-eon.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Pat Wall <pjwall@mac.com>,
 Pat Wall <pjwall@me.com>, "contact@a-eon.com" <contact@a-eon.com>,
 Matthew Leaman <matthew@a-eon.biz>, luigi burdo <intermediadc@hotmail.com>,
 Christian Zigotzky <info@xenosoft.de>
Date: Mon, 13 Jun 2016 18:19:27 +1000
In-Reply-To: <25BBCC66-53B2-4009-B2BA-CD1070EA71E9@xenosoft.de>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <874m99uibc.fsf@skywalker.in.ibm.com>
 <ab51f49d-fc8f-24ce-6763-c641b949971e@xenosoft.de>
 <1465174304.12265.0.camel@ellerman.id.au>
 <50194690-18ac-edfd-42cb-8f1cc96055c9@xenosoft.de>
 <484bd17c3f3.74dd55e@auth.smtp.1and1.co.uk>
 <87r3c71zs9.fsf@skywalker.in.ibm.com>
 <d3753fa2-d88b-2e31-7d0d-d8952c29a12b@xenosoft.de>
 <bab57839-0160-ae01-3cfb-6950067652c0@xenosoft.de>
 <1465470910.31662.10.camel@ellerman.id.au>
 <40816527-1be8-329c-2be0-86c39062c2e9@xenosoft.de>
 <25BBCC66-53B2-4009-B2BA-CD1070EA71E9@xenosoft.de>
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

On Mon, 2016-06-13 at 09:14 +0100, Christian Zigotzky wrote:
> Can I disable the new PowerPC features with
> 
> Radix MMU Support (PPC_RADIX_MMU) [Y/n/?] (NEW) -> n
> 
> ?????
> 
> I can't compile the RC3 without the PowerPC commits. Our kernel lost
> the mainline kernel support. Revert of the three PowerPC commits
> works but the kernel doesn't compile anymore.

The right way to not have this problem anymore is to cleanup and
submit your patches upstream so they don't break all the time :-)

Cheers,
Ben.
