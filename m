Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rMPct11q0zDqHF
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Jun 2016 01:14:05 +1000 (AEST)
Subject: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
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
 <fa666396-4b81-f317-18e2-48078233bb57@xenosoft.de>
 <871t4dui4g.fsf@skywalker.in.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <2bf8f412-2631-75b4-70a3-cb5ecee5cf48@xenosoft.de>
Date: Sat, 4 Jun 2016 17:13:53 +0200
MIME-Version: 1.0
In-Reply-To: <871t4dui4g.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aneesh,

It's from the Nemo patch. I patch the kernel 4.7 with our Nemo patch. [1]

Cheers,

Christian

[1] http://www.xenosoft.de/nemo_4.7-1.patch

On 04 June 2016 at 4:46 PM, Aneesh Kumar K.V wrote:
>
> Which kernel is that ? For upstream I have at that line
>
>   729                         hose->pci_io_size = range.pci_addr + range.size;
>   730                         hose->io_base_phys = range.cpu_addr - range.pci_addr;
>   731
>   732                         /* Build resource */
>   733                         res = &hose->io_resource;
>   734                         range.cpu_addr = range.pci_addr;
>   735                         break;
>   736                 case IORESOURCE_MEM:
>
>
> -aneesh
>
>
