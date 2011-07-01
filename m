Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D50F6B6F6E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Jul 2011 16:59:47 +1000 (EST)
Date: Thu, 30 Jun 2011 23:57:38 -0700 (PDT)
Message-Id: <20110630.235738.1921750709257462142.davem@davemloft.net>
To: tklauser@distanz.ch
Subject: Re: [PATCH net-next] net: ucc_geth: Omit check for multicast bit
	in netdev_for_each_mc_addr
From: David Miller <davem@davemloft.net>
In-Reply-To: <1309349793-1864-1-git-send-email-tklauser@distanz.ch>
References: <1309349793-1864-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tobias Klauser <tklauser@distanz.ch>
Date: Wed, 29 Jun 2011 14:16:33 +0200

> There is no need to check for the address being a multicast address in
> the netdev_for_each_mc_addr loop, so remove it.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied.
