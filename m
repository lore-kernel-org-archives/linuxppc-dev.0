Return-Path: <ben@trinity.fluff.org>
Received: from trinity.fluff.org (trinity.dh.bytemark.co.uk [89.16.178.74])
	by ozlabs.org (Postfix) with ESMTP id DE072474C1
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 13:43:05 +1100 (EST)
Date: Mon, 23 Feb 2009 01:56:00 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [PATCH 01/13] sdhci: Add quirk for controllers with no
	end-of-busy IRQ
Message-ID: <20090223015559.GB30710@trinity.fluff.org>
References: <20090220173228.GA5091@oksana.dev.rtsoft.ru>
	<20090220173308.GA7583@oksana.dev.rtsoft.ru>
	<20090221170504.657ff791@mjolnir.ossman.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090221170504.657ff791@mjolnir.ossman.eu>
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 21, 2009 at 05:05:04PM +0100, Pierre Ossman wrote:
> On Fri, 20 Feb 2009 20:33:08 +0300
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > From: Ben Dooks <ben-linux@fluff.org>
> > 
> > The Samsung SDHCI (and FSL eSDHC) controller block seems to fail
> > to generate an INT_DATA_END after the transfer has completed and
> > the bus busy state finished.
> > 
> > Changes in e809517f6fa5803a5a1cd56026f0e2190fc13d5c to use the
> > new busy method are the cause of the behaviour change.
> > 
> > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> 
> Any objections to me merging this right away? It is needed for another
> controller.

none from me.

sorry about the delay, moving servers.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
