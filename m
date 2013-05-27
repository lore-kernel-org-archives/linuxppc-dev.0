Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 757752C02AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 19:23:44 +1000 (EST)
Date: Mon, 27 May 2013 02:23:39 -0700 (PDT)
Message-Id: <20130527.022339.791886107453761860.davem@davemloft.net>
To: sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH 1/2] ARM: kirkwood: proper retain MAC address
 workaround on DT ethernet
From: David Miller <davem@davemloft.net>
In-Reply-To: <51A26B62.4050009@gmail.com>
References: <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130525.210441.818472895703230779.davem@davemloft.net>
 <51A26B62.4050009@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: andrew@lunn.ch, jason@lakedaemon.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, buytenh@wantstofly.org, grant.likely@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Sun, 26 May 2013 22:06:58 +0200

> good you mention it. I added Grant on Cc and will give a short
> sum-up why I casted the const from property->value away here.
> 
> Maybe I overlooked the API for modifying the DT property but as
> far as I've seen - there is no API for modifying it. And yes,
> you are right, it is kind of an abuse of DT here.

Sparc has an of_set_property(), it needs to become generic.
