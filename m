Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6C7A474D7
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 15:22:04 +1100 (EST)
Date: Tue, 6 Jan 2009 20:21:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] serial: add support for the cell network processor
	NWP device
Message-Id: <20090106202143.b31b908e.akpm@linux-foundation.org>
In-Reply-To: <1231297694.14860.55.camel@pasglop>
References: <200811241453.32166.arnd@arndb.de>
	<1231297694.14860.55.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 07 Jan 2009 14:08:14 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2008-11-24 at 14:53 +0100, Arnd Bergmann wrote:
> > From: Benjamin Krill <ben@codiert.org>
> > 
> > Add support for the nwp serial device which is connected to a DCR bus. It
> > uses the of_serial device driver to determine necessary properties from
> > the device tree.  The supported device is added as serial port number 84.
> > 
> > NWP stands for network processor and it is part of the QPACE - Quantum
> > Chromodynamics Parallel Computing on the Cell Broadband Engine project.
> > The implementation is a lightweight uart implementation with the focus
> > to consume as little resources as possible and it is connected to a
> > DCR bus.
> > 
> > Signed-off-by: Benjamin Krill <ben@codiert.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> There have been no comment nor objection about this patch.

That doesn't mean anyone looked at it ;)

> Andrew, do we have a serial maintainer or should I merge it via the
> powerpc tree ?

OK by me.  Maybe Alan wants to grab it.


My version is mucked up anyway - PORT_NWPSERIAL has the same value as
PORT_S3C6400.
