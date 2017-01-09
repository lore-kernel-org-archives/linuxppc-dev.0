Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3ty1rT5HN8zDqT5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 04:10:49 +1100 (AEDT)
Date: Mon, 09 Jan 2017 12:10:46 -0500 (EST)
Message-Id: <20170109.121046.399740143771423691.davem@davemloft.net>
To: tremyfr@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 tlfalcon@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ibm: ibmveth: use new api
 ethtool_{get|set}_link_ksettings
From: David Miller <davem@davemloft.net>
In-Reply-To: <1483824913-6989-1-git-send-email-tremyfr@gmail.com>
References: <1483824913-6989-1-git-send-email-tremyfr@gmail.com>
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
Date: Sat,  7 Jan 2017 22:35:13 +0100

> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
