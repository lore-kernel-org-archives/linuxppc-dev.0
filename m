Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3ty1rY3vvWzDqTB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 04:10:53 +1100 (AEDT)
Date: Mon, 09 Jan 2017 12:10:51 -0500 (EST)
Message-Id: <20170109.121051.996723005103082118.davem@davemloft.net>
To: tremyfr@gmail.com
Cc: tlfalcon@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ibm: ibmvnic: use new api
 ethtool_{get|set}_link_ksettings
From: David Miller <davem@davemloft.net>
In-Reply-To: <1483825049-7501-1-git-send-email-tremyfr@gmail.com>
References: <1483825049-7501-1-git-send-email-tremyfr@gmail.com>
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
Date: Sat,  7 Jan 2017 22:37:29 +0100

> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
