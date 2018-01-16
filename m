Return-Path: <Christian.Koenig@amd.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0051.outbound.protection.outlook.com [104.47.41.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLPBC00XJzF0Xq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 19:52:48 +1100 (AEDT)
Subject: Re: consolidate swiotlb dma_map implementations
To: Christoph Hellwig <hch@lst.de>
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20180110080932.14157-1-hch@lst.de>
 <20180116075338.GB12693@infradead.org>
 <76e47666-3de1-68cc-07ad-003491d26ef9@gmail.com>
 <20180116082827.GA9211@lst.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <485e6f8b-ef22-0792-1acc-3fefe203040c@amd.com>
Date: Tue, 16 Jan 2018 09:52:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180116082827.GA9211@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 16.01.2018 um 09:28 schrieb Christoph Hellwig:
> On Tue, Jan 16, 2018 at 09:22:52AM +0100, Christian König wrote:
>> Hi Konrad,
>>
>> can you send the first patch to Linus for inclusion in 4.15 if you haven't
>> already done so?
> It's in the 4.16 queue with a cc to stable.  I guess we're ok with
> a duplicate commit if we have to.

Yeah, while it's only a false positive warning it would be really nice 
to have in 4.15.

It affects all drivers using TTM in the system and not just the two I'm 
the maintainer of.

Regards,
Christian.
