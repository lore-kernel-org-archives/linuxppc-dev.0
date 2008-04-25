Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1467DDF5D
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 08:22:51 +1000 (EST)
Subject: Re: [PATCH] ibm_newemac: Increase MDIO timeouts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Fink <billfink@mindspring.com>
In-Reply-To: <20080425165703.864e63bd.billfink@mindspring.com>
References: <20080423051832.63BF7DDF65@ozlabs.org>
	<20080425165703.864e63bd.billfink@mindspring.com>
Content-Type: text/plain
Date: Sat, 26 Apr 2008 08:22:38 +1000
Message-Id: <1209162158.5420.35.camel@pasglop>
Mime-Version: 1.0
Cc: super.firetwister@googlemail.com, netdev@vger.kernel.org, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-04-25 at 16:57 -0400, Bill Fink wrote:
> On Wed, 23 Apr 2008, Benjamin Herrenschmidt wrote:
> 
> > This patch doubles the MDIO timeouts in EMAC as there are field
> > cases where they are two short to communicate with some PHYs.
> 
> I guess them being "two short" is why they needed to be doubled.  :-)

Well, in that case, it makes sense, it's still pretty short and better
safe than sorry. On day I may look at actually measuring PHYs and see if
it's worth trying to do sleeping waits in there.

Ben.
