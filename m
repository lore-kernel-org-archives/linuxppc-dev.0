Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id F155DDDED5
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 09:37:05 +1100 (EST)
Date: Thu, 16 Oct 2008 15:36:41 -0700 (PDT)
Message-Id: <20081016.153641.32547403.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 1/7] powerpc and sparc: introduce dev_archdata node
	accessors
From: David Miller <davem@davemloft.net>
In-Reply-To: <20081016171251.GA5515@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081016171251.GA5515@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Thu, 16 Oct 2008 21:12:51 +0400

> The name of the device_node field differ across the platforms, so we
> have to implement inlined accessors. This is needed to avoid ugly
> #ifdef in the generic code.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

I'm happy to just change this member name on sparc to match
powerpc's choice.

That being said, this abstraction still has value and I'd
like to let you merge this now and make forward progress
so:

Acked-by: David S. Miller <davem@davemloft.net>
