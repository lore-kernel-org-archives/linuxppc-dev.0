Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 48E7FB7D92
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Apr 2010 09:20:44 +1000 (EST)
Date: Fri, 23 Apr 2010 16:20:48 -0700 (PDT)
Message-Id: <20100423.162048.188424167.davem@davemloft.net>
To: avorontsov@mvista.com
Subject: Re: [PATCH 2/2] gianfar: Fix potential oops during OF address
	translation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100423171244.GB2140@oksana.dev.rtsoft.ru>
References: <20100423171244.GB2140@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, Sandeep.Kumar@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@mvista.com>
Date: Fri, 23 Apr 2010 21:12:44 +0400

> gianfar driver may pass NULL pointer to the of_translate_address(),
> which may lead to a kernel oops. Fix this by using of_iomap(), which
> is also much simpler and shorter.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>

Also applied to net-2.6, thanks.
