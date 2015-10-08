Return-Path: <BATV+bb4de8422e7d4d01d52c+4428+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 612681A0171
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 18:46:37 +1100 (AEDT)
Date: Thu, 8 Oct 2015 00:46:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Fengguang Wu <lkp@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Christoph Hellwig <hch@infradead.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>,
 Paul Mackerras <paulus@samba.org>, kbuild-all@01.org,
 Matthew Wilcox <willy@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kbuild-all] [PATCH 4/5 v2] pseries/iommu: implement DDW-aware
 dma_get_page_shift
Message-ID: <20151008074616.GA16089@infradead.org>
References: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
 <1444102746.16909.4.camel@ellerman.id.au>
 <20151007135602.GA17377@wfg-t540p.sh.intel.com>
 <1444263119.31685.4.camel@ellerman.id.au>
 <20151008010603.GA24198@wfg-t540p.sh.intel.com>
 <20151008011609.GA25163@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151008011609.GA25163@wfg-t540p.sh.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Fengguang,

I think this proactive testing does a little more harm than good in
it's current form.  While offering testing for patches that aren't in
git trees and or by people that don't even have a git tree that the
build bots known about does seem useful, blindly doing it for every
patch against something that most likely isn't the right base seems
counter intertuitive.  We'll probaby need some annotation in the O/n
mail that asks for a test and sets a base tree to actually make it
useful.  With those few tweaks it should be really useful!

Maybe we should have a discussion about this at kernel summit?


On Thu, Oct 08, 2015 at 09:16:09AM +0800, Fengguang Wu wrote:
> And of course linux-kernel. More lists could be added in future.
> 
> Thanks,
> Fengguang
---end quoted text---
