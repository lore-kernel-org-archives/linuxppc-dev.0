Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E43C6DDE3B
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 09:12:33 +1000 (EST)
Date: Thu, 05 Apr 2007 16:12:31 -0700 (PDT)
Message-Id: <20070405.161231.18578184.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 6/6] [POWERPC] make struct property's value a void *
From: David Miller <davem@davemloft.net>
In-Reply-To: <1175814107.30879.143.camel@localhost.localdomain>
References: <20070404.122129.45875882.davem@davemloft.net>
	<a5ebb728f4c22755d884910149e43c86@kernel.crashing.org>
	<1175814107.30879.143.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 06 Apr 2007 09:01:47 +1000

> > I agree.  However when making this code more generally useful,
> > it would be good to make it more correct at the same time, since
> > it will only get harder to do so later on.
> 
> I think it's perfectly correct with void * ...

Me too.  Let's drop this discussion, it's pointless.
