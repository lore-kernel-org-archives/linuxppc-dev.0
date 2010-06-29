Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id CCF51B6F05
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 08:16:14 +1000 (EST)
Date: Tue, 29 Jun 2010 15:16:26 -0700 (PDT)
Message-Id: <20100629.151626.90794001.davem@davemloft.net>
To: avorontsov@mvista.com
Subject: Re: [PATCH 1/3] gianfar: Implement workaround for eTSEC74 erratum
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100629205959.GA10905@oksana.dev.rtsoft.ru>
References: <20100629205959.GA10905@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com,
	Sandeep.Kumar@freescale.com, manfred.rudigier@omicron.at,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I really don't see any value at all to this config option,
the errata fixup code should be there all the time.

It really does no harm to be there in the cases where it isn't
used, and forcing users to turn this on is just another
obscure way to end up with an incorrect configuration.
