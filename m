Return-Path: <LeoLi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [RFC] New target 'cuImage' - compatibility uImage 
Date: Thu, 3 Aug 2006 19:38:58 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0B2F60@zch01exm20.fsl.freescale.net>
In-Reply-To: <20060802223302.9667135360F@atlas.denx.de>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Wolfgang Denk" <wd@denx.de>,
	"McClintock Matthew-R56630" <msm@freescale.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of
> Wolfgang Denk
> Sent: Thursday, August 03, 2006 6:33 AM
> To: McClintock Matthew-R56630
> Cc: linuxppc-dev
> Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
>=20
> In message <1154552346.5550.51.camel@localhost> you wrote:
> >
> > And the new cuImage will look like this:
> >
> > -------------------------------------
> > -	compressed uImage	  - -
> > - ------------------------------- - -
> > - - 	_start			- - -
> > - -	boot wrapper code	- - -
> > - - ----------------------------- - -
> > - - -	device tree	      	- - -
> > - - ----------------------------- - -
> > - - ----------------------------- - -
> > - - - 			      	- - -
> > - - - 	UNcompressed	      	- - -
> > - - - 	kernel image	      	- - -
> > - - -			      	- - -
> > - - ----------------------------- - -
> > - --------------------------------- -
> > -------------------------------------
>=20
> Please explain.
>=20
> In my understanding, an "uImage" file is a  image  consisting  of  an
> U-Boot  header (64 bytes) followed by an (compressed or uncompressed)
> Linux kernel image.
>=20
> So what do you mean by "compressed uImage"? If you take  an  "uImage"
> file  according  to  above definition and compress it, it will not be
> recognized by U-Boot.

I don't know if my understanding is exactly what Matt means.  But the
compressed uImage seems to be (u-boot header + compress(wrapper + FDT +
kernel image)), instead of original (u-boot header + compress(kernel
image)).  A better naming probably is needed to prevent misleading.

>=20
> And why do you need a second, "UNcompressed  kernel  image"  in  your
> setup?  I  must  be missing something, because including *two* kernel
> images makes no sense to me, and I don't  understand  why  you  would
> want to insist of an "UNcompressed" image...
>=20
> Best regards,
>=20
> Wolfgang Denk
