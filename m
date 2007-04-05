Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A2DEDDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 11:48:30 +1000 (EST)
Subject: Re: [PATCH 6/6] [POWERPC] make struct property's value a void *
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070404.122129.45875882.davem@davemloft.net>
References: <65f2b2574eca0b34e7986618cfbe7a6d@kernel.crashing.org>
	<20070403.112813.35016105.davem@davemloft.net>
	<19e36144f9d496f2a9670ac889435349@kernel.crashing.org>
	<20070404.122129.45875882.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 11:48:14 +1000
Message-Id: <1175737695.30879.109.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> No, that's just stupid.  Peppering simple accesses to properties
> with these wrappers is just going to make the code uglier for
> no tangible gain whatsoever.
> 
> There is no reason to make a mountain out of a mole hill wrt. this
> stuff.
> 
> And besides what Stephen is doing is just extending existing
> practice, he isn't changing how any of this stuff is already
> used.  So this discussion should not get in the way of his
> patches getting installed.

/me very much agrees.

Ben.
