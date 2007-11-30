Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 90A05DDE38
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 08:26:50 +1100 (EST)
Date: Fri, 30 Nov 2007 15:30:17 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/11] ibm_newemac: Add ET1011c PHY support
Message-ID: <20071130213017.GA10440@lixom.net>
References: <1196401223.5661.297518056501.qpush@grosgo>
	<20071130054126.E3EFADDE0C@ozlabs.org>
	<20071130142904.GC3117@lixom.net>
	<1196456356.13230.104.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196456356.13230.104.camel@pasglop>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 01, 2007 at 07:59:16AM +1100, Benjamin Herrenschmidt wrote:
> 
> On Fri, 2007-11-30 at 08:29 -0600, Olof Johansson wrote:
> > Hi,
> > 
> > On Fri, Nov 30, 2007 at 04:40:24PM +1100, Benjamin Herrenschmidt wrote:
> > 
> > > This adds support for the Agere ET1011c PHY as found on the AMCC Taishan
> > > board.
> > 
> > The whole patch has whitespace messed up (tabs vs spaces).
> 
> Thanks for noticing it on the ...3rd time those are sent to the list...

Yeah, sorry about that. Should have caught it sooner.

Anyway, can be fixed up with incremental patch, doesn't need to hold up
the whole series.


-Olof
