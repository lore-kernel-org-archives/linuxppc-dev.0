Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85FDBDDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 13:36:34 +1000 (EST)
Subject: Re: [PATCH] ibm_newemac: Increase MDIO timeouts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080425185842.7ab463e7@zod.rchland.ibm.com>
References: <20080423051832.63BF7DDF65@ozlabs.org>
	<20080425165703.864e63bd.billfink@mindspring.com>
	<1209162158.5420.35.camel@pasglop>
	<20080425185842.7ab463e7@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sat, 26 Apr 2008 13:35:13 +1000
Message-Id: <1209180913.5420.37.camel@pasglop>
Mime-Version: 1.0
Cc: super.firetwister@googlemail.com, netdev@vger.kernel.org,
	Bill Fink <billfink@mindspring.com>, jgarzik@pobox.com,
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


On Fri, 2008-04-25 at 18:58 -0500, Josh Boyer wrote:
> > > I guess them being "two short" is why they needed to be
> doubled.  :-)
> > 
> > Well, in that case, it makes sense, it's still pretty short and
> better
> > safe than sorry. On day I may look at actually measuring PHYs and
> see if
> > it's worth trying to do sleeping waits in there.
> 
> I think you missed Bill's joke.  Read your original email and spot the
> typo, then read Bill's pun.
> 
> And stop emailing before you eat breakfast ;)

Hrm ... yeah allright I missed my initial typo and I missed Bill
joke :-) looks like another case of replying while still half asleep ...

Ben.
