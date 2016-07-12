Return-Path: <k.kozlowski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpgxb0F9QzDqDp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 22:19:14 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0OA7004Z7BJXGF80@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 12 Jul 2016 13:19:09 +0100 (BST)
Subject: Re: [PATCH v5 00/44] dma-mapping: Use unsigned long for dma_attrs
To: Andrew Morton <akpm@linux-foundation.org>, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, linux-rdma@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, hch@infradead.org,
 linux-rockchip@lists.infradead.org, nouveau@lists.freedesktop.org,
 xen-devel@lists.xenproject.org, linux-snps-arc@lists.infradead.org,
 linux-media@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-arm-msm@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <1467275019-30789-1-git-send-email-k.kozlowski@samsung.com>
 <20160712121625.GP23520@phenom.ffwll.local>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <5784E03B.6060000@samsung.com>
Date: Tue, 12 Jul 2016 14:19:07 +0200
MIME-version: 1.0
In-reply-to: <20160712121625.GP23520@phenom.ffwll.local>
Content-type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/12/2016 02:16 PM, Daniel Vetter wrote:
> On Thu, Jun 30, 2016 at 10:23:39AM +0200, Krzysztof Kozlowski wrote:
>> Hi,
>>
>>
>> This is fifth approach for replacing struct dma_attrs with unsigned
>> long.
>>
>> The main patch (1/44) doing the change is split into many subpatches
>> for easier review (2-42).  They should be squashed together when
>> applying.
> 
> For all the drm driver patches:
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Should I pull these in through drm-misc, or do you prefer to merge them
> through a special topic branch (with everything else) instead on your own?
> -Daniel

Thanks. I saw today that Andrew Morton applied the patchset so I think
he will handle it.

Best regards,
Krzysztof
