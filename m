Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id 514722C01AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 11:28:01 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 4/7] ECHI Platform: Merge ppc-of EHCI driver into the
 ehci-platform driver
Date: Mon, 24 Feb 2014 11:28:01 +1100
Message-ID: <2268977.fdRl41kSok@mexican>
In-Reply-To: <Pine.LNX.4.44L0.1402211037300.1273-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1402211037300.1273-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 21 Feb 2014 10:41:50 Alan Stern wrote:
> On Fri, 21 Feb 2014, Alistair Popple wrote:
> > Currently the ppc-of driver uses the compatibility string
> > "usb-ehci". This means platforms that use device-tree and implement an
> > EHCI compatible interface have to either use the ppc-of driver or add
> > a compatible line to the ehci-platform driver. It would be more
> > appropriate for the platform driver to be compatible with "usb-ehci"
> > as non-powerpc platforms are also beginning to utilise device-tree.
> > 
> > This patch merges the device tree property parsing from ehci-ppc-of
> > into the platform driver and adds a "usb-ehci" compatibility
> > string. The existing ehci-ppc-of driver is removed and the 440EPX
> > specific quirks are added to the ehci-platform driver.
> > 
> > Signed-off-by: Alistair Popple <alistair@popple.id.au>
> 
> This patch is also out of date.  The compatibility string used by the
> ehci-platform driver is "generic-ehci".

Ok. I will switch to using "generic-ehci" in the Akebono device tree.

> There remains the question of whether to merge ehci-ppc-of into
> ehci-platform.  This would be a rather invasive change, but I suppose
> we could do it.  With adjustments along the lines suggested by Mark
> Rutland.

As I can use "generic-ehci" to support Akebono I will drop this patch. I can 
look at merging ehci-ppc-of at some later date if desired (thanks Mark & Tony 
for reviewing though).

- Alistair

> Alan Stern
