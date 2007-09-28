Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [patch 0/8] PS3 AV Settings Driver patches for
	2.6.24
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0709271344130.10467@pademelon.sonytel.be>
References: <20070926163308.772580000@pademelon.sonytel.be>
	<1190860285.6502.6.camel@concordia>
	<Pine.LNX.4.62.0709271344130.10467@pademelon.sonytel.be>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fjhccH7olOKSdddQ7GLJ"
Date: Fri, 28 Sep 2007 18:44:16 +1000
Message-Id: <1190969056.15970.8.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org, "Antonino A. Daplas" <adaplas@gmail.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-fjhccH7olOKSdddQ7GLJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-09-27 at 13:53 +0200, Geert Uytterhoeven wrote:
> On Thu, 27 Sep 2007, Michael Ellerman wrote:
> > On Wed, 2007-09-26 at 18:33 +0200, Geert Uytterhoeven wrote:
> > > Here are some new patches for the PS3 AV Settings Driver (ps3av), whi=
ch is
> > > used in close collaboration with the PS3 Virtual Frame Buffer Device =
Driver
> > > (ps3fb):
> > >   [1] ps3av: eliminate unneeded temporary variables
> > >   [2] ps3av: eliminate PS3AV_DEBUG
> > >   [3] ps3av: use PS3 video mode ids in autodetect code
> > >   [4] ps3av: treat DVI-D like HDMI in autodetect
> > >   [5] ps3av: add autodetection for VESA modes
> > >   [6] ps3av: add quirk database for broken monitors
> > >   [7] ps3av: remove unused ps3av_set_mode()
> > >   [8] ps3av: don't distinguish between `boot' and `non-boot' autodete=
ction
> > >=20
> > > Please review, and queue for 2.6.24 if they're ok. Thanks!
> > >=20
> > > Question: As several DVI-D displays advertise they support 1080i mode=
s while
> > > they actually don't (cfr. the quirk database), perhaps I should drop =
1080i
> > > modes completely from the ps3av_preferred_modes[] table? Usually 720p=
 looks
> > > better than 1080i anyway.  What do you think?
> >=20
> > Definitely. If the autodetection fails Linux is basically unusable on
> > PS3 unless you hack the kernel sources and build your own kboot and
> > otheros.bld - not entirely trivial for novice users. So it's pretty
> > important that it works 100%.
>=20
> Well, this code has been in Geoff's git tree for a while, and it's been s=
everal
> weeks ago I got complaints (which have been adressed by adding displays t=
o the
> quirk database). The new kboot (from Distro Kit 1.4.1) also uses it.

Well yeah. Your instructions for diagnosing a quirk are to add #define
DEBUG to ps3av.c and then send the _output from the kernel log_  ... ?

Not to mention that for every quirk reported there's probably 50 users
who just figured Linux on PS3 was broken and gave up.

> The only 100% (sic) mode is 480p (actual usable resolution is 576x384), w=
hich
> is quite limited due to the very low resolution. This is what the current
> mainline kernel uses by default, causing complaints from people who don't=
 like
> their shiny expensive full-HD displays being driven by 480p by default.

Sure that's annoying, but not quite as annoying as getting a completely
black screen that you can do nothing about - short of hacking the kernel
and building your own otheros.bld.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-fjhccH7olOKSdddQ7GLJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/L7gdSjSd0sB4dIRAsnHAKC0+Kyxw3ph+wJItbuKHGVeMSPBBgCgt3uD
q66QYCJU/ajargJCggHAQ6Q=
=1jVr
-----END PGP SIGNATURE-----

--=-fjhccH7olOKSdddQ7GLJ--
