Return-Path: <dan.j.williams@intel.com>
Received: from mail-ot0-x235.google.com (mail-ot0-x235.google.com
 [IPv6:2607:f8b0:4003:c0f::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0Ck70J8jzDrnK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 05:43:53 +1100 (AEDT)
Received: by mail-ot0-x235.google.com with SMTP id v40so1056957ote.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 10:43:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215140947.26075-16-hch@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
 <20171215140947.26075-16-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 17 Dec 2017 10:43:50 -0800
Message-ID: <CAPcyv4gRX8=xNL+td6umKHjjZdugWMej42eBait8xizR8c_boQ@mail.gmail.com>
Subject: Re: [PATCH 15/17] memremap: drop private struct page_map
To: Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 15, 2017 at 6:09 AM, Christoph Hellwig <hch@lst.de> wrote:
> From: Logan Gunthorpe <logang@deltatee.com>
>
> 'struct page_map' is a private structure of 'struct dev_pagemap' but the
> latter replicates all the same fields as the former so there isn't much
> value in it. Thus drop it in favour of a completely public struct.
>
> This is a clean up in preperation for a more generally useful
> 'devm_memeremap_pages' interface.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
