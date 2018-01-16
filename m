Return-Path: <ckoenig.leichtzumerken@gmail.com>
Received: from mail-wm0-x234.google.com (mail-wm0-x234.google.com
 [IPv6:2a00:1450:400c:c09::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLNWk1zn2zF0Yl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 19:22:57 +1100 (AEDT)
Received: by mail-wm0-x234.google.com with SMTP id v71so6712690wmv.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 00:22:57 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: consolidate swiotlb dma_map implementations
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
 linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
 linux-ia64@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
References: <20180110080932.14157-1-hch@lst.de>
 <20180116075338.GB12693@infradead.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <76e47666-3de1-68cc-07ad-003491d26ef9@gmail.com>
Date: Tue, 16 Jan 2018 09:22:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180116075338.GB12693@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Konrad,

can you send the first patch to Linus for inclusion in 4.15 if you 
haven't already done so?

I'm still getting reports from people complaining about the error message.

Thanks,
Christian.

Am 16.01.2018 um 08:53 schrieb Christoph Hellwig:
> I've pulled this into the dma-mapping for-next tree, including the
> missing free_pages noted.  I'd be fine to rebase another day or two
> for additional reviews or important fixes.
