Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5AE26B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2012 21:14:04 +1000 (EST)
Date: Mon, 23 Apr 2012 12:13:27 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Boojin Kim <boojin.kim@samsung.com>
Subject: Re: [PATCH 5/9] dmaengine: provide a common function for
 completing a dma descriptor
Message-ID: <20120423111327.GM24211@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52yJ-0002Mx-2e@rmk-PC.arm.linux.org.uk>
 <056201cd2135$10ea5b70$32bf1250$%kim@samsung.com>
 <20120423095013.GL24211@n2100.arm.linux.org.uk>
 <1335175278.31825.108.camel@vkoul-udesk3>
 <000001cd2141$26914d60$73b3e820$%kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001cd2141$26914d60$73b3e820$%kim@samsung.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: 'Vinod Koul' <vinod.koul@linux.intel.com>,
 'Stephen Warren' <swarren@nvidia.com>,
 'Linus Walleij' <linus.walleij@stericsson.com>,
 'Srinidhi Kasagar' <srinidhi.kasagar@stericsson.com>,
 'Dan Williams' <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 23, 2012 at 08:06:36PM +0900, Boojin Kim wrote:
> I met the DMA probing fail problem on Linux 3.4.
> It's because the return value on regulator_get() is changed
> from ENODEV to EPROBE_DEFER in case not to supply a vcore regulator.
> So, I try to change the check value about the return value of regulator_get()
> in amba_get_enable_vcore()from ENODEV to EPROBE_DEFER.
> How about it ? Do you already fix it too?

A fix has already been committed and sent upstream - about a week ago.
