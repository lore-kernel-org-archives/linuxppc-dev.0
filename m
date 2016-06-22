Return-Path: <intermediadc@hotmail.com>
Received: from COL004-OMC1S9.hotmail.com (col004-omc1s9.hotmail.com
 [65.55.34.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZbBx6KWrzDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 06:03:53 +1000 (AEST)
From: luigi burdo <intermediadc@hotmail.com>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, "Aneesh
 Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Darren Stevens
 <darren@stevens-zone.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <michaele@au1.ibm.com>,
 Julian Margetson <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 R.T.Dickinson <rtd@a-eon.com>, R.T.Dickinson <rtd2@xtra.co.nz>, Pat Wall
 <pjwall@mac.com>, Pat Wall <pjwall@me.com>, "contact@a-eon.com"
 <contact@a-eon.com>, Matthew Leaman <matthew@a-eon.biz>, luigi burdo
 <intermediadc@hotmail.com>, Christian Zigotzky <info@xenosoft.de>
Subject: RE: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
Date: Wed, 22 Jun 2016 19:58:35 +0000
Message-ID: <HE1PR01MB154874F9367CE088CC7202EEC82C0@HE1PR01MB1548.eurprd01.prod.exchangelabs.com>
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
 <575EF6BE.6020208@xenosoft.de>,<576AE1D7.7090301@xenosoft.de>
In-Reply-To: <576AE1D7.7090301@xenosoft.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian, i think Darren patch override some memory region that on kernel.=
org was different and this make the kernel patched run and work

Luigi
________________________________________
Da: Christian Zigotzky [chzigotzky@xenosoft.de]
Inviato: mercoled=EC 22 giugno 2016 21.07
A: Benjamin Herrenschmidt; Michael Ellerman; Aneesh Kumar K.V; Darren Steve=
ns; linuxppc-dev@lists.ozlabs.org; Michael Ellerman; Julian Margetson; Adri=
an Cox; R.T.Dickinson; R.T.Dickinson; Pat Wall; Pat Wall; contact@a-eon.com=
; Matthew Leaman; luigi burdo; Christian Zigotzky
Oggetto: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE

Hi All,

Please find attached Darren's patch. With this patch, the Nemo board
boots. That means, the problematic source code is somewhere in this patch.
Which file in this patch is responsible for starting the kernel?

Thanks,

Christian

On 13 June 2016 at 8:09 PM, Christian Zigotzky wrote:
> Hi Ben,
>
> I could send you a patch but it doesn't work with the three PowerPC
> commits. I think we have to fix the boot issue at first. After that we
> can integrate the first patch for the Nemo board.
>
> Cheers,
>
> Christian
>
> On 13 June 2016 at 10:19 AM, Benjamin Herrenschmidt wrote:
>> The right way to not have this problem anymore is to cleanup and
>> submit your patches upstream so they don't break all the time :-)
>>
>> Cheers,
>> Ben.
>>
>>
