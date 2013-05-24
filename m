Return-Path: <sebastian.hesselbarth@gmail.com>
Message-ID: <519FA277.3010802@gmail.com>
Date: Fri, 24 May 2013 19:25:11 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] net: mv643xx_eth: proper initialization for Kirkwood
 SoCs
References: <1369253042-15082-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130522201607.GA18823@obsidianresearch.com>
 <20130523160111.GP31290@titan.lakedaemon.net>
 <20130523171112.GB31281@obsidianresearch.com>
 <20130523172339.GQ31290@titan.lakedaemon.net>
 <20130523175357.GB2821@obsidianresearch.com>
 <20130523184028.GU31290@titan.lakedaemon.net> <519E9ADA.3040204@gmail.com>
 <CACRpkdbsicPkPAiaQCOg2mQF2Ce2dg_K=BKqqx=FCdAH7Y+QBg@mail.gmail.com>
 <20130524170125.GX31290@titan.lakedaemon.net>
 <20130524171300.GD18614@n2100.arm.linux.org.uk>
In-Reply-To: <20130524171300.GD18614@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Lennert Buytenhek <buytenh@wantstofly.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/24/2013 07:13 PM, Russell King - ARM Linux wrote:
> Do you really want that on ARM?  Given the fiasco with the location of
> the registers, are you sure you want to place more trust in that
> direction?  Does it give you a warm fuzzy feeling to know that you
> might have to work out some way to patch vendor supplied bytecode?

Don't get me wrong. I want mv643xx_eth DT or even platform_data to
evolve to a fully self configured driver not depending on proper u-boot
setup at all.

But I don't want to go that road now and I wonder if it might be safer
for us (and PPC guys) if we start mv643xx_eth over from scratch one day.

For this patch set, I want a basic DT binding that works. Patching the
driver to play with kirkwood loosing the MAC and other important
registers is not my main concern here. If clearing that one bit doesn't
help for all kirkwood boards, I'd rather leave the non-gating
workaround.

mv643xx_eth not knowing DT for ARM is stalling last important bits for
Orion SoCs. I want this to go in first as with David another maintainer
is involved.

Sebastian
