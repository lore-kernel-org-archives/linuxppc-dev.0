Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F782DDFEE
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 03:03:15 +1100 (EST)
Date: Fri, 18 Jan 2008 10:03:03 -0600
From: Scott Wood <scottwood@freescale.com>
To: Sergej Stepanov <Sergej.Stepanov@ids.de>
Subject: Re: [PATCH 2/2] mpc82xx: Embedded Planet EP8248E support
Message-ID: <20080118160303.GC15620@ld0162-tx32.am.freescale.net>
References: <20080117223205.GB17300@loki.buserror.net>
	<1200654427.3204.4.camel@p60365-ste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1200654427.3204.4.camel@p60365-ste>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 18, 2008 at 12:07:07PM +0100, Sergej Stepanov wrote:
> 
> > +			/* "Serial" port/SCC1 */
> > +			scc1: serial@11a00 {
> > +				device_type = "serial";
> > +				compatible = "fsl,mpc8248-scc-uart",
> > +				             "fsl,cpm2-scc-uart";
> > +				reg = <0x11a00 0x20 0x8000 0x100>;
> > +				interrupts = <40 8>;
> are you sure with 40 as interrupt? has not it be "28"(hex) here?

This is a version 1 dts file -- the default base is decimal.

-Scott
