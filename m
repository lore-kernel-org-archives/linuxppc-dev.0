Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from tama555.ecl.ntt.co.jp (tama555.ecl.ntt.co.jp [129.60.39.106])
	by ozlabs.org (Postfix) with ESMTP id 99706DDDEE
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 15:44:04 +1100 (EST)
To: balbir@linux.vnet.ibm.com
Subject: Re: SCSI errors on powerpc with 2.6.24-rc6-mm1
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <47732C41.7000003@linux.vnet.ibm.com>
References: <20071224044850.GA11449@linux.vnet.ibm.com>
	<20071227121108L.fujita.tomonori@lab.ntt.co.jp>
	<47732C41.7000003@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20071227134335O.fujita.tomonori@lab.ntt.co.jp>
Date: Thu, 27 Dec 2007 13:43:35 +0900
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 Dec 2007 10:08:25 +0530
Balbir Singh <balbir@linux.vnet.ibm.com> wrote:

> FUJITA Tomonori wrote:
> > On Mon, 24 Dec 2007 10:18:50 +0530
> > Balbir Singh <balbir@linux.vnet.ibm.com> wrote:
> > 
> [snip]
> 
> > 
> > I might break the IOMMU code. Can you reproduce it easily? If so,
> > reverting my IOMMU patches (I've attached a patch to revert them) fix
> > the problem?
> 
> [snip]
> 
> 
> Yes, this patch fixes the problem for me.

Thanks, so you can reproduce it easily, right?

The problem is that I don't want to revert these changes. I'll see
how these changes cause the problem shortly.
