Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKncZ3pMqzF0bG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 20:10:06 +1100 (AEDT)
Date: Mon, 15 Jan 2018 10:10:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
 linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
 linux-ia64@vger.kernel.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Konrad Rzeszutek Wilk <konrad@darnok.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/22] swiotlb: refactor coherent buffer allocation
Message-ID: <20180115091002.GA398@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-11-hch@lst.de>
 <cecc98cf-2e6a-a7bc-7390-d6dcced038c4@arm.com>
 <20180110154649.GA18529@lst.de>
 <03c25dda-30da-9169-a8a1-1720ec741b9d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <03c25dda-30da-9169-a8a1-1720ec741b9d@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 10, 2018 at 05:02:30PM +0000, Robin Murphy wrote:
>>>
>>> Aren't we leaking the pages here?
>>
>> Yes, that free_pages got lost somewhere in the rebases, I've added
>> it back.
>
> Cool.

FYI, here is the fixed version, I don't want to re-send the whole
series for this fix:

http://git.infradead.org/users/hch/misc.git/commitdiff/0176adb004065d6815a8e67946752df4cd947c5b
