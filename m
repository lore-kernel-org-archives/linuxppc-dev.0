Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rT1Cb6vCrzDqZx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 04:15:07 +1000 (AEST)
Subject: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <michaele@au1.ibm.com>, Julian Margetson
 <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>, Matthew Leaman <matthew@a-eon.biz>,
 luigi burdo <intermediadc@hotmail.com>, Christian Zigotzky <info@xenosoft.de>
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
 <1465805967.3022.14.camel@kernel.crashing.org>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <575EF6BE.6020208@xenosoft.de>
Date: Mon, 13 Jun 2016 20:09:02 +0200
MIME-Version: 1.0
In-Reply-To: <1465805967.3022.14.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

I could send you a patch but it doesn't work with the three PowerPC
commits. I think we have to fix the boot issue at first. After that we
can integrate the first patch for the Nemo board.

Cheers,

Christian

On 13 June 2016 at 10:19 AM, Benjamin Herrenschmidt wrote:
>
> The right way to not have this problem anymore is to cleanup and
> submit your patches upstream so they don't break all the time :-)
>
> Cheers,
> Ben.
>
>
