Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc3-s16.bay0.hotmail.com (bay0-omc3-s16.bay0.hotmail.com
	[65.54.246.216]) by ozlabs.org (Postfix) with ESMTP id B734FDDF4D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 01:37:15 +1000 (EST)
Message-ID: <BAY115-W14E65268F6A301B98090EEB24A0@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: <grant.likely@secretlab.ca>
Subject: RE: 2.6 Kernel , Xilinx Virtex and PPC 405 On chip memory
	controllers ( DSOCM and ISOCM )
Date: Tue, 24 Apr 2007 15:37:14 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Then in mailing list I saw some where that AVNET mini-modules are using a v=
ersion of FX12 FPGA which has problem with PPC caches and as the solution t=
he caches should be off.

Does the kernel always turns on the caches? Or If I choose in the base syst=
em builder to not to use caches, the kernel will not use them?=20

Any special config parameter for this in xparameters.h?

thanks



----------------------------------------
> Date: Tue, 24 Apr 2007 08:59:37 -0600
> From: grant.likely@secretlab.ca
> To: mamsadegh@hotmail.com
> Subject: Re: 2.6 Kernel , Xilinx Virtex and PPC 405 On chip memory contro=
llers ( DSOCM and ISOCM )
> CC: linuxppc-embedded@ozlabs.org
>=20
> On 4/24/07, Mohammad Sadegh Sadri  wrote:
> >
> >
> > what about the cache?
> > Does the current kernel use the cache efficiently?
>=20
> Yes, the caches work and are turned on by the kernel.
>=20
> g.
>=20
> --=20
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195

_________________________________________________________________
News, entertainment and everything you care about at Live.com. Get it now!
http://www.live.com/getstarted.aspx=
