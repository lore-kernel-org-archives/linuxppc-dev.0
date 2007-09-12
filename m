Return-Path: <davem@davemloft.net>
Received: from picasso.davemloft.net (unknown [74.93.104.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1CEEDDDFE
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 23:28:39 +1000 (EST)
Date: Wed, 12 Sep 2007 06:27:32 -0700 (PDT)
Message-Id: <20070912.062732.68054135.davem@davemloft.net>
To: RAISCH@de.ibm.com
Subject: Re: new NAPI interface broken for POWER architecture?
From: David Miller <davem@davemloft.net>
In-Reply-To: <OF2D6ED296.BDB04FBF-ONC1257354.00473703-C1257354.0048406C@de.ibm.com>
References: <200709071137.02801.ossthema@de.ibm.com>
	<20070912.055004.88490155.davem@davemloft.net>
	<OF2D6ED296.BDB04FBF-ONC1257354.00473703-C1257354.0048406C@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: ossthema@linux.vnet.ibm.com, pmac@au1.ibm.com, netdev@vger.kernel.org,
	THEMANN@de.ibm.com, linuxppc-dev@ozlabs.org, ARNDB@de.ibm.com,
	ellerman@au1.ibm.com, shemminger@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Wed, 12 Sep 2007 15:10:08 +0200

> This is definitely not something we can change in the HEA device driver
> alone.

And it shouldn't be, x86 implements the policy in irq balance
daemon, powerpc should do it wherever it would be appropriate
there.

> Paul, Michael, Arndt, what is your opinion here?

I'm all ears too :)
