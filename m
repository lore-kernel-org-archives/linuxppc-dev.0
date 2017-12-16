Return-Path: <dan.j.williams@intel.com>
Received: from mail-ot0-x22d.google.com (mail-ot0-x22d.google.com
 [IPv6:2607:f8b0:4003:c0f::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz9bX3yS6zDsQ5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 13:04:40 +1100 (AEDT)
Received: by mail-ot0-x22d.google.com with SMTP id 103so9297996otj.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 18:04:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215140947.26075-7-hch@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
 <20171215140947.26075-7-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 15 Dec 2017 18:04:37 -0800
Message-ID: <CAPcyv4iNDonroVQy7YFsM-uC_0GMsjQgSBj=ZfdOB-XUK5tsKw@mail.gmail.com>
Subject: Re: [PATCH 06/17] mm: pass the vmem_altmap to arch_remove_memory and
 __remove_pages
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
> We can just pass this on instead of having to do a radix tree lookup
> without proper locking 2 levels into the callchain.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>wip

I assume that "wip" is a typo?

Otherwise,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
