Date: Tue, 8 Aug 2000 09:13:11 -0400
From: Josh Huber <huber@mclx.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: Kind of success! (r128 on PPC (Re: LinuxPPC X Server))
Message-ID: <20000808091311.B248@mclx.com>
References: <20000807093124.B248@mclx.com> <Pine.LNX.4.10.10008081433260.442-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
In-Reply-To: <Pine.LNX.4.10.10008081433260.442-100000@cassiopeia.home>; from geert@linux-m68k.org on Tue, Aug 08, 2000 at 02:35:19PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2000 at 02:35:19PM +0200, Geert Uytterhoeven wrote:
>=20
> Is this XF4.0.1 in `fbdev' mode? If yes, it's a bug in the X server. Sett=
ing
> the DSP registers is part of the video mode initialization and thus is the
> sole responsability of the frame buffer device, when running in `fbdev' m=
ode.

Yes.  The server shows the SAME behavior using the fbdev driver and
the ati driver.  Also, as a note, the 3.3.6 XF68FB_Dev server with ati
accel also does the same thing!   So there's some code that's getting
used by all three that is wrong?

I'm a little confused as to where the problem lies...

--=20
Josh
6B21489A | GnuPG ID/Fingerprint | huber@mclx.com |
61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature
Content-Disposition: inline


--KFztAG8eRSV9hGtP--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
