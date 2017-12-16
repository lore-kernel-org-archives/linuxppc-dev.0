Return-Path: <dan.j.williams@intel.com>
Received: from mail-ot0-x22d.google.com (mail-ot0-x22d.google.com
 [IPv6:2607:f8b0:4003:c0f::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz94y4d9FzDsNS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 12:41:34 +1100 (AEDT)
Received: by mail-ot0-x22d.google.com with SMTP id j2so9291435ota.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 17:41:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215140947.26075-2-hch@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
 <20171215140947.26075-2-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 15 Dec 2017 17:41:31 -0800
Message-ID: <CAPcyv4iENTTRvoigbdtztrtKiAFbBuCcwYwQ+c02XuCRGToH6g@mail.gmail.com>
Subject: Re: [PATCH 01/17] memremap: provide stubs for vmem_altmap_offset and
 vmem_altmap_free
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
> Currently all calls to those functions are eliminated by the compiler when
> CONFIG_ZONE_DEVICE is not set, but this soon won't be the case.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
