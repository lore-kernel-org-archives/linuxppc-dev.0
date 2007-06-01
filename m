Return-Path: <daniel.schnell@marel.com>
Received: from mail.marel.com (mail.marel.com [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 336B8DDF6E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jun 2007 01:13:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Where is initial console initialized ?
Date: Fri, 1 Jun 2007 15:13:38 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01FAEC9B@is-hdq-exchange.marel.net>
In-Reply-To: <20070601063507.GA23294@moe.telargo.com>
References: <DD39B5C3F4963040ADC9768BE7E430CB01F550A7@is-hdq-exchange.marel.net>
	<20070601063507.GA23294@moe.telargo.com>
From: "Daniel Schnell" <daniel.schnell@marel.com>
To: "Domen Puncer" <domen.puncer@telargo.com>
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

Hi,

Well if one does it right, then things work as expected.

I simply chose the wrong Kernel configuration, the correct console =
driver has not been compiled in.

Now it works as expected.



Sorry for the noise.

Daniel Schnell.



-----Original Message-----
From: Domen Puncer [mailto:domen.puncer@telargo.com]=20
Sent: 1. j=FAn=ED 2007 06:35
To: Daniel Schnell
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Where is initial console initialized ?

On 31/05/07 13:42 -0000, Daniel Schnell wrote:
> Hi,
> =20
> I am trying to bring up 2.6.20.3 on a MPC5200B based custom board.=20
> This Kernel is based on the Phytec phyCore MPC5200B Mini BSP kernel=20
> and adapted to my board.
> So far I have troubles to get console output working when booting =
Linux.
> Uboot console output is fine. Linux begins to run (I can set=20
> breakpoints with the BDI2000 in the early initialization code) so I=20
> probably have a misconfiguration of the console output inside the fdt.
>=20
> The major difference between the Phytec phyCore 5200B mini fdt and=20
> mine is that we use PSC1 instead of PSC3/6 for serial. Accordingly I=20
> changed the fdt (or dts) values.
>=20
> To get some more insights, I would like to know, in which Linux=20
> function the console output is initialised ?
>=20
>=20
...
> If I dump the flat device tree inside uboot, I get the following
> entries:=20
...
the dump with:

         reg =3D <8>;

in most of nodes, which looks just wrong.


	Domen
