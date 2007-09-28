Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [patch 0/8] PS3 AV Settings Driver patches for
	2.6.24
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <46FBE6FD.3030605@am.sony.com>
References: <20070926163308.772580000@pademelon.sonytel.be>
	<1190860285.6502.6.camel@concordia>  <46FBE6FD.3030605@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1qaHv7xrLXI47F1yCWXX"
Date: Fri, 28 Sep 2007 18:40:33 +1000
Message-Id: <1190968833.15970.3.camel@concordia>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
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


--=-1qaHv7xrLXI47F1yCWXX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-09-27 at 10:23 -0700, Geoff Levand wrote:
> Michael Ellerman wrote:
> > On Wed, 2007-09-26 at 18:33 +0200, Geert Uytterhoeven wrote:
> >> 	Hi,
> >>=20
> >> Here are some new patches for the PS3 AV Settings Driver (ps3av), whic=
h is
> >> used in close collaboration with the PS3 Virtual Frame Buffer Device D=
river
> >> (ps3fb):
> >>   [1] ps3av: eliminate unneeded temporary variables
> >>   [2] ps3av: eliminate PS3AV_DEBUG
> >>   [3] ps3av: use PS3 video mode ids in autodetect code
> >>   [4] ps3av: treat DVI-D like HDMI in autodetect
> >>   [5] ps3av: add autodetection for VESA modes
> >>   [6] ps3av: add quirk database for broken monitors
> >>   [7] ps3av: remove unused ps3av_set_mode()
> >>   [8] ps3av: don't distinguish between `boot' and `non-boot' autodetec=
tion
> >>=20
> >> Please review, and queue for 2.6.24 if they're ok. Thanks!
> >>=20
> >> Question: As several DVI-D displays advertise they support 1080i modes=
 while
> >> they actually don't (cfr. the quirk database), perhaps I should drop 1=
080i
> >> modes completely from the ps3av_preferred_modes[] table? Usually 720p =
looks
> >> better than 1080i anyway.  What do you think?
> >=20
> > Definitely. If the autodetection fails Linux is basically unusable on
> > PS3 unless you hack the kernel sources and build your own kboot and
> > otheros.bld - not entirely trivial for novice users. So it's pretty
> > important that it works 100%.
>=20
> It is not that bad.  If a bootloader is configued to use autodetection
> so that it is shown at best video mode, then it should have advertised
> key sequences to default to known video modes, with at least a 480p 'safe=
'
> mode.

Oh OK, that is a good idea. What's the "safe mode" key sequence for the
otheros.bld you provide on kernel.org?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-1qaHv7xrLXI47F1yCWXX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/L4BdSjSd0sB4dIRAmK3AJ9IxYifSuJ7KFDcbNTR7DWFPlifgQCghjKz
exZ3Z2IVT9R1bnWw5hDgPwc=
=s66q
-----END PGP SIGNATURE-----

--=-1qaHv7xrLXI47F1yCWXX--
