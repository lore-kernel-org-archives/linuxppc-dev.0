Return-Path: <davem@davemloft.net>
Date: Thu, 11 Apr 2013 16:20:07 -0400 (EDT)
Message-Id: <20130411.162007.896982847089316512.davem@davemloft.net>
To: sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH 0/2] net: mv643xx_eth: use managed clk and allocation
From: David Miller <davem@davemloft.net>
In-Reply-To: <1365672574-31123-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365672574-31123-1-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: andrew@lunn.ch, jason@lakedaemon.net, sergei.shtylyov@cogentembedded.com,
 linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rob.herring@calxeda.com, paulus@samba.org,
 rob@landley.net, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 florian@openwrt.org, buytenh@wantstofly.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Thu, 11 Apr 2013 11:29:32 +0200

> With introduction of common clock framework and the ability to provide
> gated clocks, mv643xx_eth required calls to get and enable these clock
> gates on some platforms. Back then, common clock framework api wasn't
> safe for architectures without support for common clocks. This has
> changed now and there are also managed (devm_) counterparts for clock
> related functions.
> 
> The second patch in this series, also converts kzalloc to devm_kzalloc
> where applicable.
> 
> Both patches have been sent to the corresponding mailing lists as
> individual patches before. To get the order required to apply them right,
> this patch set combines both patches into one set.

Both applied to net-next, thanks.
