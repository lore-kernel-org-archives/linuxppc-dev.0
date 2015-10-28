Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 16C901A0C23
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:38:04 +1100 (AEDT)
Date: Tue, 27 Oct 2015 17:54:43 -0700 (PDT)
Message-Id: <20151027.175443.140992924519172506.davem@davemloft.net>
To: keith.busch@intel.com
Cc: nacc@linux.vnet.ibm.com, willy@linux.intel.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aik@ozlabs.ru, david@gibson.dropbear.id.au, hch@infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
From: David Miller <davem@davemloft.net>
In-Reply-To: <20151027223643.GA25332@localhost.localdomain>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Busch, Keith" <keith.busch@intel.com>
Date: Tue, 27 Oct 2015 22:36:43 +0000

> If you're suggesting to compile-time break architectures that currently
> work just fine with NVMe, let me stop you right there.

Silently "working" without the architecture maintainer having to explicity
look at the new interface and make sure his platform is implementing it
properly is an extremely bad practice.
