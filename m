Return-Path: <dan.j.williams@intel.com>
Received: from mail-oi0-x22d.google.com (mail-oi0-x22d.google.com
 [IPv6:2607:f8b0:4003:c06::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz9v60F9HzDqm7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 13:18:07 +1100 (AEDT)
Received: by mail-oi0-x22d.google.com with SMTP id t78so7404097oie.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 18:18:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215140947.26075-10-hch@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
 <20171215140947.26075-10-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 15 Dec 2017 18:18:05 -0800
Message-ID: <CAPcyv4g0074zD9ztrMu3cT-sVpZfkCK=i6F0XohRxw5TKDupVA@mail.gmail.com>
Subject: Re: [PATCH 09/17] mm: split altmap memory map allocation from normal
 case
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
> No functional changes, just untangling the call chain.

I'd also mention that creating more helper functions in the altmap_
namespace helps document why altmap is passed all around the hotplug
code.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
