Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 11730B7B78
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 08:54:44 +1100 (EST)
Date: Wed, 14 Oct 2009 14:54:59 -0700 (PDT)
Message-Id: <20091014.145459.118730396.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] net: Fix OF platform drivers coldplug/hotplug when
	compiled as modules
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091008121512.GA2390@oksana.dev.rtsoft.ru>
References: <20091008121512.GA2390@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Thu, 8 Oct 2009 16:15:12 +0400

> Some OF platform drivers are missing module device tables, so they won't
> load automatically on boot. This patch fixes the issue by adding proper
> MODULE_DEVICE_TABLE() macros to the drivers.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied, thanks!
