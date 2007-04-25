Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4A6B1DDEE3
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 14:23:29 +1000 (EST)
Date: Tue, 24 Apr 2007 21:23:30 -0700 (PDT)
Message-Id: <20070424.212330.82514412.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/6] Consolidate of_device_is_compatible
From: David Miller <davem@davemloft.net>
In-Reply-To: <1177459165.14873.153.camel@localhost.localdomain>
References: <20070424223245.78f4fdfb.sfr@canb.auug.org.au>
	<20070424223812.2842f3f2.sfr@canb.auug.org.au>
	<1177459165.14873.153.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 Apr 2007 09:59:24 +1000

> On Tue, 2007-04-24 at 22:38 +1000, Stephen Rothwell wrote:
> > The only difference here is that Sparc uses strncmp to match compatibility
> > names while PowerPC uses strncasecmp.
> 
> We should settle for a single implementation. In theory, strncmp would
> be the way to go but there have been "bugs" here or there, especially in
> Apple DTs, that made me use strncasecmp instead in the past.
> 
> Dave, what do you reckon ? I should try to find out the bogus machines
> and add workarounds in the various drivers etc... instead or we can just
> go common on strncasecmp ?

I think strncasecmp is the safest thing to start with.
