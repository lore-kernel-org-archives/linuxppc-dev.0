Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vf0K45lngzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 17:06:47 +1100 (AEDT)
Date: Wed, 08 Mar 2017 22:06:34 -0800 (PST)
Message-Id: <20170308.220634.437174407885031242.davem@davemloft.net>
To: tremyfr@gmail.com
Cc: geoff@infradead.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: toshiba: ps3_genic_net: use new api
 ethtool_{get|set}_link_ksettings
From: David Miller <davem@davemloft.net>
In-Reply-To: <1488752466-27232-1-git-send-email-tremyfr@gmail.com>
References: <1488752466-27232-1-git-send-email-tremyfr@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Philippe Reynes <tremyfr@gmail.com>
Date: Sun,  5 Mar 2017 23:21:06 +0100

> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
> As I don't have the hardware, I'd be very pleased if
> someone may test this patch.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
