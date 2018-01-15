Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKnCV0v1KzF0cQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 19:51:48 +1100 (AEDT)
Date: Mon, 15 Jan 2018 09:51:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvdimm@lists.01.org,
 X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: revamp vmem_altmap / dev_pagemap handling V3
Message-ID: <20180115085144.GA32532@lst.de>
References: <20171229075406.1936-1-hch@lst.de> <20180108112646.GA7204@lst.de>
 <CAPcyv4hHipDHP5LZCgym5szqiUSCxG9wQUbRO_qe8T+USaZi9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4hHipDHP5LZCgym5szqiUSCxG9wQUbRO_qe8T+USaZi9Q@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 08, 2018 at 11:44:02AM -0800, Dan Williams wrote:
> On Mon, Jan 8, 2018 at 3:26 AM, Christoph Hellwig <hch@lst.de> wrote:
> > Any chance to get this fully reviewed and picked up before the
> > end of the merge window?
> 
> I'm fine carrying these through the nvdimm tree, but I'd need an ack
> from the mm folks for all the code touches related to arch_add_memory.

Looks like we got some semi ACKs, so I'd really like to see this go
in now as we have both nvdimm and p2p patches depending on it.
