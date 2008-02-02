Return-Path: <ben@trinity.fluff.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.145.97.151])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADF8BDDE45
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Feb 2008 07:32:52 +1100 (EST)
Date: Sat, 2 Feb 2008 19:41:02 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/3 2.6.24-git] PPC/LIBATA: Select HAVE_PATA_PLATFORM for
	ARCH_PPC
Message-ID: <20080202194102.GJ26792@trinity.fluff.org>
References: <20080202162133.678366209@fluff.org.uk>
	<20080202162232.212855590@fluff.org.uk>
	<20080202191239.GA29039@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080202191239.GA29039@lixom.net>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com, jeff@garzik.org,
	Ben Dooks <ben-linux@fluff.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 02, 2008 at 01:12:39PM -0600, Olof Johansson wrote:
> On Sat, Feb 02, 2008 at 04:21:36PM +0000, Ben Dooks wrote:
> > Use the new HAVE_PATA_PLATFORM to select PATA_PLATFORM
> > driver.
> > 
> > CC: linuxppc-dev@ozlabs.org
> > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> What tree is this against? It doesn't apply to current mainline nor
> jgarzik's libata-dev upstream branch.

It is a series that i've just sent to the linux-ide list, only the ppc
part was cc'd to the ppc list.
 
> Anyway: NACK: I like this approach but this needs to be added to
> arch/powerpc as well.

I can add that to the series.
 
> It's actually more needed there than arch/ppc, I don't personally care
> if arch/ppc can't use pata_platform for the last couple of months it's
> still around (it's getting deleted this summer, all platforms should
> have moved to powerpc by then).

Thanks, didn't know that.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
