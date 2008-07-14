Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F917DDE01
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 23:21:26 +1000 (EST)
Message-Id: <35075E1B-3492-4D10-AD4F-49C4462A269F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wang Jian <lark@linux.net.cn>
In-Reply-To: <48757086.2080704@linux.net.cn>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 1/2] Fix copper/fiber auto-selection for 88e1111
Date: Mon, 14 Jul 2008 08:21:15 -0500
References: <48757086.2080704@linux.net.cn>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 9, 2008, at 9:14 PM, Wang Jian wrote:

> The 27.15 bit (MII_M1111_HWCFG_FIBER_COPPER_AUTO) is disable bit. When
> set to 1, copper/fiber auto selection is disabled. The current code
> to enable but actually disable auto selection.
>
> Signed-off-by: Wang Jian <lark@linux.net.cn>
> ---
> drivers/net/phy/marvell.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

These should really get cc'd to the netdev list.

- k
