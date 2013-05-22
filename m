Return-Path: <jason@lakedaemon.net>
Received: from mho-02-ewr.mailhop.org (mho-02-ewr.mailhop.org [204.13.248.72])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DC52D2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 03:35:13 +1000 (EST)
Date: Wed, 22 May 2013 13:35:05 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v4 06/12] ARM: dove: add gigabit ethernet and mvmdio
 device tree nodes
Message-ID: <20130522173505.GH31290@titan.lakedaemon.net>
References: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-7-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130521174849.GL26249@lunn.ch> <519C9333.20609@gmail.com>
 <519C9822.9040909@windriver.com> <519C9A66.3050807@gmail.com>
 <20130522131010.GB31290@titan.lakedaemon.net>
 <20130522165908.GB12320@obsidianresearch.com>
 <519D0143.1000203@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <519D0143.1000203@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Lennert Buytenhek <buytenh@wantstofly.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 22, 2013 at 07:32:51PM +0200, Sebastian Hesselbarth wrote:
> On 05/22/2013 06:59 PM, Jason Gunthorpe wrote:
> >On Wed, May 22, 2013 at 09:10:10AM -0400, Jason Cooper wrote:
> >>iirc, our solution to this was to parse the ATAGs for the mac addr and
> >>update the appended dtb.  This way, module load and unload would work
> >>without loosing the mac address.  I believe Jason Gunthorpe has a patch
> >>to atags_to_fdt() for this...  This should allow us to get rid of the
> >>clocks hack.
> >
> >Sorry, no, we don't use ATAGs here, our platforms start the kernel
> >with a correct DTB that has the correct mac address to use. My patch
> >was to have the driver accept it, and I think Sebastian has already
> >got that functionality...
> 
> Not neccessary anyway, after talking Jason C in a Kirkwood-only
> workaround I prepared a patch that reads mac address registers early
> and stores it in the local-mac-address property.

Sweet!

> Just tested on Dockstar with gated clocks and modular DT mv643xx_eth.
> 
> Will append to the DT mv643xx_eth patch set if a v5 will be required
> or as single patch prior Jason C taking in the ARM part of it
> otherwise.

Please post, in-reply-to v4 is fine.

thx,

Jason.
