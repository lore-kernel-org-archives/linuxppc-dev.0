Return-Path: <jdl@freescale.com>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
From: Jon Loeliger <jdl@freescale.com>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <45421FFD.8070407@bplan-gmbh.de>
References: <453FB582.20802@bplan-gmbh.de>
	<1161816783.22582.132.camel@localhost.localdomain>
	<45409760.7030902@bplan-gmbh.de>
	<1161866964.27827.2.camel@localhost.localdomain>
	<4540B0A9.6070404@bplan-gmbh.de>
	<528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>
	<4541118F.60002@bplan-gmbh.de>
	<528646bc0610261300s3e93e53fk5732990089b68d35@mail.gmail.com>
	<1161919709.25682.61.camel@localhost.localdomain>
	<45421C97.80501@bplan-gmbh.de>  <45421FFD.8070407@bplan-gmbh.de>
Content-Type: text/plain
Message-Id: <1161968926.2426.415.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 27 Oct 2006 12:08:46 -0500
Cc: akpm@osdl.org, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	sl@bplan-gmbh.de, sha@pengutronix.de,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-27 at 10:04, Nicolas DET wrote:

> > diff -uprN a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
> > --- a/include/asm-powerpc/mpc52xx.h	1970-01-01 01:00:00.000000000 +0100
> > +++ b/include/asm-powerpc/mpc52xx.h	2006-10-27 15:51:55.000000000 +0200
> > @@ -0,0 +1,414 @@
> > +/*
> > + * include/asm-ppc/mpc52xx.h
> > + * 
> 
> 
> Fixed to powerpc

I thought we were removing the names of files from
within the file itself, right?

Thanks,
jdl
