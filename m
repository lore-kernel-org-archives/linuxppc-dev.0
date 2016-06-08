Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPWcW2r02zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 11:51:07 +1000 (AEST)
Message-ID: <1465350666.14294.0.camel@ellerman.id.au>
Subject: Re: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 darren@stevens-zone.net, Michael Ellerman <michaele@au1.ibm.com>, Julian
 Margetson <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 "R.T.Dickinson" <rtd@a-eon.com>,  "R.T.Dickinson" <rtd2@xtra.co.nz>, Pat
 Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,  "contact@a-eon.com"
 <contact@a-eon.com>, Matthew Leaman <matthew@a-eon.biz>, luigi burdo
 <intermediadc@hotmail.com>, Christian Zigotzky <info@xenosoft.de>
Date: Wed, 08 Jun 2016 11:51:06 +1000
In-Reply-To: <2a3a9bf7-baa4-07a9-1da0-94b596b3a955@xenosoft.de>
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
 <2a3a9bf7-baa4-07a9-1da0-94b596b3a955@xenosoft.de>
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

On Wed, 2016-06-08 at 00:14 +0200, Christian Zigotzky wrote:
> Hi All,
> 
> I replaced the file "slice.c" with the old one from kernel 4.6. It 
> compiled but unfortunately it doesn't boot.

I would expect nothing else.

You can't just replace whole files from different versions, the unit of work is
a commit, not a file.

cheers
