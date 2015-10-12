Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CFD21A06B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 13:51:57 +1100 (AEDT)
Message-ID: <1444618316.7194.0.camel@ellerman.id.au>
Subject: Re: [kbuild-all] [PATCH 4/5 v2] pseries/iommu: implement DDW-aware
 dma_get_page_shift
From: Michael Ellerman <mpe@ellerman.id.au>
To: Fengguang Wu <lkp@intel.com>
Cc: Keith Busch <keith.busch@intel.com>, Alexey Kardashevskiy
 <aik@ozlabs.ru>,  Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org,  linux-nvme@lists.infradead.org, Christoph
 Hellwig <hch@infradead.org>, Paul Mackerras <paulus@samba.org>,
 kbuild-all@01.org, Matthew Wilcox <willy@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Oct 2015 13:51:56 +1100
In-Reply-To: <20151011142235.GC17528@wfg-t540p.sh.intel.com>
References: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
 <1444102746.16909.4.camel@ellerman.id.au>
 <20151007135602.GA17377@wfg-t540p.sh.intel.com>
 <1444263119.31685.4.camel@ellerman.id.au>
 <20151008010603.GA24198@wfg-t540p.sh.intel.com>
 <20151008011609.GA25163@wfg-t540p.sh.intel.com>
 <1444277187.9940.7.camel@ellerman.id.au>
 <20151011142235.GC17528@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-10-11 at 22:22 +0800, Fengguang Wu wrote:
> > 
> > So do you mind adding linuxppc-dev@lists.ozlabs.org ? :)
> > 
> > It's pretty low traffic compared to lkml.
> 
> Sure, I'm subscribing to it. :)

Thanks.

cheers
