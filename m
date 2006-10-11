Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19FDF67B8D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 17:16:04 +1000 (EST)
Subject: Re: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jschopp <jschopp@austin.ibm.com>
In-Reply-To: <452C2AAA.5070001@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
	<20061010212324.GR4381@austin.ibm.com>
	<452C2AAA.5070001@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 17:15:10 +1000
Message-Id: <1160550910.6177.66.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-10 at 18:20 -0500, jschopp wrote:
> Linas Vepstas wrote:
> > The current driver code performs 512 DMA mappns of a bunch of 
> > 32-byte structures. This is silly, as they are all in contiguous 
> > memory. Ths patch changes the code to DMA map the entie area
> > with just one call.
> > 
> > Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> > Cc: James K Lewis <jklewis@us.ibm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> The others look good, but this one complicates the code and doesn't have any benefit.  20 
> for 21 isn't bad.

Hi Joel !

I'm not sure what you mean here.... (especially your 20 to 21 comment).

The patch looks perfectly fine to me, and in fact removes more lines of
code than it adds :)

Cheers,
Ben.
