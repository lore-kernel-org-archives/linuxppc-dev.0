Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AE8F81007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 03:03:31 +1100 (EST)
Date: Thu, 19 Nov 2009 08:03:24 -0800
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Bug in drivers/serial/of_serial.c?
Message-ID: <20091119160324.GA7492@kroah.com>
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<200911191441.27581.arnd@arndb.de>
	<8B957E110B62714A84290A01A597805F05D2AE47@Exchange.discretix.com>
	<200911191509.31270.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200911191509.31270.arnd@arndb.de>
Cc: Alon Ziv <alonz@discretix.com>, linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 19, 2009 at 03:09:31PM +0100, Arnd Bergmann wrote:
> On Thursday 19 November 2009, Alon Ziv wrote:
> > On Thursday, November 19, 2009, Arnd Bergmann wrote:
> > > I'd still add support for the compatible="ns16550a" property
> > > so that we do the right thing for future systems.
> > > 
> > 
> > OK...
> > ---
> > Xilinx 16550 UART is actually 16550A-compatible
> > 
> > Signed-off-by: Alon Ziv <alonz@discretix.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Does this go through the powerpc or the tty tree?
> I'd be happy if either Ben or Greg could pick this up.
> 
> I'm happy to keep maintaining the driver itself but it
> would be nice to know a definite subsystem maintainer
> responsible for it.
> 
> Greg, if you want to take patches for of_serial.c generally,
> I'll start forwarding them to you as they come in and make
> sure they apply to your tree.

Sure, I would be glad to do so, send them on.

thanks,

greg k-h
