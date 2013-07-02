Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 383122C06EE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 01:34:12 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 3 Jul 2013 01:22:24 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7E5C82BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 01:34:08 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r62FJ1Fo53739678
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jul 2013 01:19:01 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r62FY7bf003290
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jul 2013 01:34:08 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH -V3 1/4] mm/cma: Move dma contiguous changes into a
 seperate config
In-Reply-To: <51D28D51.6090305@samsung.com>
References: <1372743918-12293-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <51D28D51.6090305@samsung.com>
Date: Tue, 02 Jul 2013 21:03:57 +0530
Message-ID: <87txkdyo0q.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kvm@vger.kernel.org, agraf@suse.de, mina86@mina86.com, linux-mm@kvack.org,
 paulus@samba.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> Hello,
>
> On 7/2/2013 7:45 AM, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>
>> We want to use CMA for allocating hash page table and real mode area for
>> PPC64. Hence move DMA contiguous related changes into a seperate config
>> so that ppc64 can enable CMA without requiring DMA contiguous.
>>
>> Acked-by: Michal Nazarewicz <mina86@mina86.com>
>> Acked-by: Paul Mackerras <paulus@samba.org>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> OK. It looks that there is not that much that can be easily shared between
> dma-mapping cma provider and ppc/kvm cma allocator. I would prefer to merge
> patch 1/4 to my dma-mapping tree, because I plan some significant changes in
> cma code, see: 
> http://thread.gmane.org/gmane.linux.drivers.devicetree/40013/
> I think it is better to keep those changes together.
>
> For now I've merged your patch with removed defconfig updates. AFAIK such
> changes require separate handling to avoid pointless merge conflicts.

How do we get the defconfig changes done ?

> I've
> also prepared a topic branch for-v3.12-cma-dma, available at
> git://git.linaro.org/people/mszyprowski/linux-dma-mapping, which You can 
> merge
> together with your changes to ppc kernel trees.
>

Thanks. Will update accordingly as other patches get picked into
respective trees

-aneesh
