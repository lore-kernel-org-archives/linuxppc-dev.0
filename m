Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 06FC5DDF7C
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 23:05:32 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: "Jon Smirl" <jonsmirl@gmail.com>
Date: Mon, 9 Jun 2008 15:05:05 +0200
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
	<200806090956.32160.jbe@pengutronix.de>
	<9e4733910806090537y73d29280ofce1ce04086dae5d@mail.gmail.com>
In-Reply-To: <9e4733910806090537y73d29280ofce1ce04086dae5d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806091505.07185.jbe@pengutronix.de>
Subject: Re: Comments on device tree for pcm030
Cc: linuxppc-dev@ozlabs.org, wsa@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon,

On Monday 09 June 2008 14:37, Jon Smirl wrote:
> On 6/9/08, Juergen Beisert <jbe@pengutronix.de> wrote:
> >  > > Device tree has an entry for AC97 on PSC1. I don't think the Phytec
> >  > > module or carrier board has AC97 hardware.
> >  >
> >  > Might be a bug
> >
> > NACK. The baseboard for the pcm030 CPU board has AC97 hardware connected
> > to PSC1. And it plays audio...
>
> I'm staring at a baseboard for the pcm030 in my hand, I don't see any
> AC97 hardware. It has two serial, two CAN, ethernet and power. Where's
> the AC97?

It seems you have an "old" development hardware. Here I have=20
the "PCM-030-02REI" (=3DCPU card) and "PCM-973-tiny" (=3Dbaseboard). The=20
PCM-973-tiny comes with a Wolfson AC97 sound device. This is the current=20
combination everyone can buy.

> http://www.phytec.com/products/rdk/PowerPC/phyCORE-MPC5200B-tinyRDK.html

Yes. This kit contains the PCM-973-tiny with AC97 sound.

Regards,
Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
