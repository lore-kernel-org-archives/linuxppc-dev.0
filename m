Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rMQ0w6GdczDq8G
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Jun 2016 01:31:28 +1000 (AEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
Message-Id: <2FB13B5B-42F0-4396-AD29-70924D2710CC@xenosoft.de>
Date: Sat, 4 Jun 2016 17:25:07 +0200
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <fa666396-4b81-f317-18e2-48078233bb57@xenosoft.de>
 <871t4dui4g.fsf@skywalker.in.ibm.com>
 <2bf8f412-2631-75b4-70a3-cb5ecee5cf48@xenosoft.de>
In-Reply-To: <2bf8f412-2631-75b4-70a3-cb5ecee5cf48@xenosoft.de>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net,
 Michael Ellerman <michaele@au1.ibm.com>,
 Julian Margetson <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 rtd@a-eon.com, rtd2@xtra.co.nz, pjwall@mac.com, pjwall@me.com,
 matthew@a-eon.biz,
 intermediadc@hotmail.com, contact@a-eon.com, info@xenosoft.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Which files are responsible for the early boot phase in the commit powerpc-4=
.7-1? Perhaps the problem is there.

- Christian

Sent from my iPhone

> On 04 Jun 2016, at 17:13, Christian Zigotzky <chzigotzky@xenosoft.de> wrot=
e:
>=20
> Aneesh,
>=20
> It's from the Nemo patch. I patch the kernel 4.7 with our Nemo patch. [1]
>=20
> Cheers,
>=20
> Christian
>=20
> [1] http://www.xenosoft.de/nemo_4.7-1.patch
>=20
>> On 04 June 2016 at 4:46 PM, Aneesh Kumar K.V wrote:
>>=20
>> Which kernel is that ? For upstream I have at that line
>>=20
>>  729                         hose->pci_io_size =3D range.pci_addr + range=
.size;
>>  730                         hose->io_base_phys =3D range.cpu_addr - rang=
e.pci_addr;
>>  731
>>  732                         /* Build resource */
>>  733                         res =3D &hose->io_resource;
>>  734                         range.cpu_addr =3D range.pci_addr;
>>  735                         break;
>>  736                 case IORESOURCE_MEM:
>>=20
>>=20
>> -aneesh
>=20
