Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6D6CBDDDF0
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Feb 2008 11:23:07 +1100 (EST)
Date: Sat, 2 Feb 2008 18:23:43 -0600
From: Olof Johansson <olof@lixom.net>
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 3/3 2.6.24-git] PPC/LIBATA: Select HAVE_PATA_PLATFORM
	for ARCH_PPC
Message-ID: <20080203002343.GA1372@lixom.net>
References: <20080202162133.678366209@fluff.org.uk>
	<20080202162232.212855590@fluff.org.uk>
	<20080202191239.GA29039@lixom.net>
	<20080202194102.GJ26792@trinity.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080202194102.GJ26792@trinity.fluff.org>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com, jeff@garzik.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 02, 2008 at 07:41:02PM +0000, Ben Dooks wrote:
> On Sat, Feb 02, 2008 at 01:12:39PM -0600, Olof Johansson wrote:
> > On Sat, Feb 02, 2008 at 04:21:36PM +0000, Ben Dooks wrote:
> > > Use the new HAVE_PATA_PLATFORM to select PATA_PLATFORM
> > > driver.
> > > 
> > > CC: linuxppc-dev@ozlabs.org
> > > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> > 
> > What tree is this against? It doesn't apply to current mainline nor
> > jgarzik's libata-dev upstream branch.
> 
> It is a series that i've just sent to the linux-ide list, only the ppc
> part was cc'd to the ppc list.

D'oh. Ok, makes more sense now.

Are you planning on adding HAVE_PATA_PLATFORM to the other archs that
use it as well, or keep it under EMBEDDED there?


> > Anyway: NACK: I like this approach but this needs to be added to
> > arch/powerpc as well.
> 
> I can add that to the series.

Ok, cool. We can probably move it in under the relevant powerpc
sub-platforms over time, and that's a powerpc-specific change anyway,
no need to get that through linux-ide.

> > It's actually more needed there than arch/ppc, I don't personally care
> > if arch/ppc can't use pata_platform for the last couple of months it's
> > still around (it's getting deleted this summer, all platforms should
> > have moved to powerpc by then).
> 
> Thanks, didn't know that.

No problem. :)


-Olof
