Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EAA86B7B7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 19:35:26 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 45CB0DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 19:35:25 +1000 (EST)
Subject: Re: [PATCH 1/5] ucc_geth: Fix NULL pointer dereference in
	uec_get_ethtool_stats()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20090830.215224.203201252.davem@davemloft.net>
References: <20090827173547.GA1580@oksana.dev.rtsoft.ru>
	<20090830.215224.203201252.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 31 Aug 2009 19:35:11 +1000
Message-Id: <1251711311.15353.2.camel@pasglop>
Mime-Version: 1.0
Cc: scottwood@freescale.com, netdev@vger.kernel.org, timur@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-08-30 at 21:52 -0700, David Miller wrote:
> All 5 patches applied to net-next-2.6
> 
> I would have liked to have seen at least one powerpc ACK for
> patch #2 but these were posted more than a week ago, the
> patch looks pretty reasonable, and we can't wait forever for
> stuff like this.

The qe stuff ? Well, that's entirely Kumar's domain, but Anton
patches tend to be of good quality so I wouldn't have too much
second thoughts here.

Cheers,
Ben.
