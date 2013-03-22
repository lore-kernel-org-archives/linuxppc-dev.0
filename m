Return-Path: <davem@davemloft.net>
Date: Fri, 22 Mar 2013 10:26:26 -0400 (EDT)
Message-Id: <20130322.102626.1889236227505288422.davem@davemloft.net>
To: florian@openwrt.org
Subject: Re: [PATCH 0/4 v3] mv643xx_eth: use mvmdio MDIO bus driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <1363959568-16976-1-git-send-email-florian@openwrt.org>
References: <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <1363959568-16976-1-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: thomas.petazzoni@free-electrons.com, andrew@lunn.ch, linux@arm.linux.org.uk,
 jason@lakedaemon.net, linux-doc@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 rob.herring@calxeda.com, netdev@vger.kernel.org, paulus@samba.org,
 linux-arm-kernel@lists.infradead.org, rob@landley.net,
 gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
 buytenh@wantstofly.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Florian Fainelli <florian@openwrt.org>
Date: Fri, 22 Mar 2013 14:39:24 +0100

> This patch converts the mv643xx_eth driver to use the mvmdio MDIO bus driver
> instead of rolling its own implementation. As a result, all users of this
> mv643xx_eth driver are converted to register an "orion-mdio" platform_device.
> The mvmdio driver is also updated to support an interrupt line which reports
> SMI error/completion, and to allow traditionnal platform device registration
> instead of just device tree.
> 
> David, I think it makes sense for you to merge all of this, since we do
> not want the architecture files to be desynchronized from the mv643xx_eth to
> avoid runtime breakage. The potential for merge conflicts should be very small.

Series applied to net-next, thanks Florian.
