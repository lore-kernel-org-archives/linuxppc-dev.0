Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 4463B2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 00:21:15 +1000 (EST)
Subject: Re: [PATCH -V3 1/4] mm/cma: Move dma contiguous changes into a
 seperate config
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372743918-12293-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 8 Jul 2013 16:21:05 +0200
Message-Id: <1C7CE5C5-A66F-4EB1-B9D0-EED8B555E146@suse.de>
References: <1372743918-12293-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, mina86@mina86.com, linux-mm@kvack.org,
 paulus@samba.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 m.szyprowski@samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.07.2013, at 07:45, Aneesh Kumar K.V wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> We want to use CMA for allocating hash page table and real mode area =
for
> PPC64. Hence move DMA contiguous related changes into a seperate =
config
> so that ppc64 can enable CMA without requiring DMA contiguous.
>=20
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
> Acked-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Thanks, applied all to kvm-ppc-queue. Please provide a cover letter next =
time :).


Alex
