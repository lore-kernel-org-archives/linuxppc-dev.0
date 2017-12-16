Return-Path: <dan.j.williams@intel.com>
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com
 [IPv6:2607:f8b0:4003:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz95D4DK9zDsPm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 12:41:52 +1100 (AEDT)
Received: by mail-oi0-x232.google.com with SMTP id 184so7383924oii.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 17:41:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215140947.26075-3-hch@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
 <20171215140947.26075-3-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 15 Dec 2017 17:41:49 -0800
Message-ID: <CAPcyv4jduU6jZgfGWzirj2oj5-7g_mArriNGBhueaQzmUOLL6Q@mail.gmail.com>
Subject: Re: [PATCH 02/17] mm: don't export arch_add_memory
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
> Only x86_64 and sh export this symbol, and it is not used by any
> modular code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
