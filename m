Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1Lk75hYzzDwP2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 02:02:46 +1100 (AEDT)
Date: Tue, 19 Dec 2017 16:02:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/17] mm: pass the vmem_altmap to arch_remove_memory
 and __remove_pages
Message-ID: <20171219150242.GA13124@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
 <20171215140947.26075-7-hch@lst.de>
 <CAPcyv4iNDonroVQy7YFsM-uC_0GMsjQgSBj=ZfdOB-XUK5tsKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4iNDonroVQy7YFsM-uC_0GMsjQgSBj=ZfdOB-XUK5tsKw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 15, 2017 at 06:04:37PM -0800, Dan Williams wrote:
> On Fri, Dec 15, 2017 at 6:09 AM, Christoph Hellwig <hch@lst.de> wrote:
> > We can just pass this on instead of having to do a radix tree lookup
> > without proper locking 2 levels into the callchain.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>wip
> 
> I assume that "wip" is a typo?

It was the description of the patch this got folded into in my
local tree.  So basically equivalent to a typo :)
