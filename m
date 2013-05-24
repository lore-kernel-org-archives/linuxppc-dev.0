Return-Path: <andrew@lunn.ch>
Received: from londo.lunn.ch (londo.lunn.ch [IPv6:2001:1620:f9f:1000::1])
 by ozlabs.org (Postfix) with ESMTP id C1A562C0395
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 May 2013 02:54:23 +1000 (EST)
Date: Fri, 24 May 2013 18:53:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 2/2] net: mv643xx_eth: proper initialization for Kirkwood
 SoCs
Message-ID: <20130524165315.GX26249@lunn.ch>
References: <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130522201607.GA18823@obsidianresearch.com>
 <20130523160111.GP31290@titan.lakedaemon.net>
 <20130523171112.GB31281@obsidianresearch.com>
 <20130523172339.GQ31290@titan.lakedaemon.net>
 <20130523175357.GB2821@obsidianresearch.com>
 <20130523184028.GU31290@titan.lakedaemon.net>
 <20130523190140.GA4010@obsidianresearch.com>
 <20130524164636.GV31290@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130524164636.GV31290@titan.lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Lennert Buytenhek <buytenh@wantstofly.org>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Why are you not keen on this? It seems like normal device driver
> > practice, that is what the data field of of_device_id is typically
> > used for..
> 
> I'm not keen on it because we don't have a document saying "All kirkwood
> SoCs need PSC1 set to X after reset."  We know it, but have we tested
> the 6282?

6282 looses its MAC address, that much i know. I've no idea about
PSC1, but if its MAC address behaviour is the same as 6281, is expect
PSC1 is the same.

	Andrew
