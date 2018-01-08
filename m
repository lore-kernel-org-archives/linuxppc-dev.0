Return-Path: <dan.j.williams@intel.com>
Received: from mail-oi0-x22a.google.com (mail-oi0-x22a.google.com
 [IPv6:2607:f8b0:4003:c06::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFm1P3cHrzF0cJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 06:44:05 +1100 (AEDT)
Received: by mail-oi0-x22a.google.com with SMTP id a70so1871751oib.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jan 2018 11:44:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180108112646.GA7204@lst.de>
References: <20171229075406.1936-1-hch@lst.de> <20180108112646.GA7204@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 8 Jan 2018 11:44:02 -0800
Message-ID: <CAPcyv4hHipDHP5LZCgym5szqiUSCxG9wQUbRO_qe8T+USaZi9Q@mail.gmail.com>
Subject: Re: revamp vmem_altmap / dev_pagemap handling V3
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvdimm@lists.01.org, X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 8, 2018 at 3:26 AM, Christoph Hellwig <hch@lst.de> wrote:
> Any chance to get this fully reviewed and picked up before the
> end of the merge window?

I'm fine carrying these through the nvdimm tree, but I'd need an ack
from the mm folks for all the code touches related to arch_add_memory.
