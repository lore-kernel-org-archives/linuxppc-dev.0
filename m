Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNNX04dgrzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 15:28:16 +1000 (AEST)
Subject: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net,
 Michael Ellerman <michaele@au1.ibm.com>, Julian Margetson
 <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>
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
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <fb6cfe13-8c5d-08c0-e2a6-eb88ba738d87@xenosoft.de>
Date: Mon, 6 Jun 2016 07:21:48 +0200
MIME-Version: 1.0
In-Reply-To: <1465174304.12265.0.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks. I'll try it.

- Christian

On 06 June 2016 at 02:51 AM, Michael Ellerman wrote:
> On Sat, 2016-06-04 at 17:07 +0200, Christian Zigotzky wrote:
>
>> Aneesh,
>>
>> Shall I bisect the kernel from the powerpc git?
> No just use linus' tree.
>
>> Shall I start with the following commit?
>>
>> https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?id=8ffb4103f5e28d7e7890ed4774d8e009f253f56e
> Yeah that would be a good one to start with.
>
> Then mark rc1 as bad and bisect should do the rest.
>
> cheers
>
>
