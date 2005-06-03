Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7A2267B59
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Jun 2005 09:57:40 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.62.0506031001460.15256@numbat.sonytel.be>
References: <bf0d9d49e4c115e67aa5df39e33017a1@freescale.com>
	<42A06E8C.5020705@rambler.ru>
	<Pine.LNX.4.62.0506031001460.15256@numbat.sonytel.be>
Content-Type: text/plain
Date: Sat, 04 Jun 2005 09:56:20 +1000
Message-Id: <1117842981.31082.199.camel@gaston>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: Getting ownership for various boards/platforms configs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-06-03 at 10:02 +0200, Geert Uytterhoeven wrote:
> On Fri, 3 Jun 2005, Pavel Fedin wrote:
> > Kumar Gala wrote:
> > > One issue that comes up from time to time is knowing who to contact about
> > > some of the various boards that are supported for PPC.  I've suggested in
> > > the past that we create a MAINTAINERS file in arch/ppc/platforms.
> > 
> >  I am an owner of PegasosII board. You didn't mention it here.
> 
> Pegasos II is CHRP, hence under common (and BenH will take care of it? ;-).

Yup, and Sven Luther is the actual maintainer of that bit of chrp.

Ben.
