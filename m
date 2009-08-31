Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 21BD9B7BB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 14:52:15 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D2367DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 14:52:14 +1000 (EST)
Date: Sun, 30 Aug 2009 21:52:24 -0700 (PDT)
Message-Id: <20090830.215224.203201252.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 1/5] ucc_geth: Fix NULL pointer dereference in
	uec_get_ethtool_stats()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090827173547.GA1580@oksana.dev.rtsoft.ru>
References: <20090827173547.GA1580@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


All 5 patches applied to net-next-2.6

I would have liked to have seen at least one powerpc ACK for
patch #2 but these were posted more than a week ago, the
patch looks pretty reasonable, and we can't wait forever for
stuff like this.
