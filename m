Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 971F8DDF0D
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Feb 2009 19:54:29 +1100 (EST)
Date: Sun, 01 Feb 2009 00:54:25 -0800 (PST)
Message-Id: <20090201.005425.122181645.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH -next 1/2] gianfar: Implement proper, per netdevice
	wakeup management
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090128203854.GA14693@oksana.dev.rtsoft.ru>
References: <20090128203854.GA14693@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com, netdev@vger.kernel.org,
	jgarzik@pobox.com, peppe.cavallaro@st.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Wed, 28 Jan 2009 23:38:54 +0300

> This patch implements wakeup management for the gianfar driver.
> 
> The driver should set wakeup enable if WOL is enabled, so that
> phylib won't power off an attached PHY.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied.
