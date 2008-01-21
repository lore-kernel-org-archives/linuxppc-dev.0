Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 34C32DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 02:28:35 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id D3A90F4901A
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 16:28:32 +0100 (CET)
Subject: Re: [PATCH 2/2] mpc82xx: Embedded Planet EP8248E support
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080118160303.GC15620@ld0162-tx32.am.freescale.net>
References: <20080117223205.GB17300@loki.buserror.net>
	<1200654427.3204.4.camel@p60365-ste>
	<20080118160303.GC15620@ld0162-tx32.am.freescale.net>
Date: Mon, 21 Jan 2008 16:28:32 +0100
Message-Id: <1200929312.3242.6.camel@p60365-ste>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Am Freitag, den 18.01.2008, 10:03 -0600 schrieb Scott Wood:
> On Fri, Jan 18, 2008 at 12:07:07PM +0100, Sergej Stepanov wrote:
> > 
> > > +			/* "Serial" port/SCC1 */
> > > +			scc1: serial@11a00 {
> > > +				device_type = "serial";
> > > +				compatible = "fsl,mpc8248-scc-uart",
> > > +				             "fsl,cpm2-scc-uart";
> > > +				reg = <0x11a00 0x20 0x8000 0x100>;
> > > +				interrupts = <40 8>;
> > are you sure with 40 as interrupt? has not it be "28"(hex) here?
> 
> This is a version 1 dts file -- the default base is decimal.
> 
> -Scott
yes, you are right, sorry.
