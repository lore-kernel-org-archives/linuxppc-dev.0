Date: Mon, 8 May 2000 02:16:31 -0800
From: Ethan Benson <erbenson@alaska.net>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
Cc: Daniel Jacobowitz <drow@false.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: problem with Makefile
Message-ID: <20000508021631.V7928@plato.local.lan>
References: <20000508014714.A19467@drow.res.cmu.edu> <Pine.LNX.3.96.1000507234646.3380B-100000@deepspace.mklinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X6f5cqjOqKjuoPgI"
In-Reply-To: <Pine.LNX.3.96.1000507234646.3380B-100000@deepspace.mklinux.org>; from dgatwood@deepspace.mklinux.org on Sun, May 07, 2000 at 11:49:16PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--X6f5cqjOqKjuoPgI
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sun, May 07, 2000 at 11:49:16PM -0700, David A. Gatwood wrote:
>=20
> On Mon, 8 May 2000, Daniel Jacobowitz wrote:
>=20
> > On Mon, May 08, 2000 at 01:26:05PM +0800, Rolf Liu wrote:
> > >
> > > current work
> > > is to translate the Makefile of linux-ppc into a standard one, such a=
s one
> > > for windows-based
> > > Makefile,which is meaningful to other standard "make" utilities,inclu=
ding
> >
> > There is a standard make.  It's POSIX, I believe.  The linux makefile
> > is pretty close to it.  Why on earth would you want to use Microsoft or
> > Borland tools (which are nmake, not make, IIRC) to build a kernel?
>=20
> As a fun exercise?
>=20
> Seriously, though, what would be good would be to modify the makefile to
> eliminate all gnu extensions, i.e. converting it into a pure lowest-
> common-denominator makefile (yes, it's probably POSIX).  That would allow
> it to be built under other OSes, including Windoze, but also *BSD, Darwin,
> MacOS X, etc.  That having been said, it's a pain in the backside to do
> that sort of thing, so I wish you lots of luck.  ;-)

or you could just install gnu make on your {BSD,darwin,OSX} box, thats
what you do to compile emacs, GnuPG etc... =20

as for windows i think compiling a linux kernel on windows would cause
a massive explosion ;P =20

(somone who had waaaay to much time on there hands took the linux
kernel source code and used it to create a HUGE ascii art image of a
penguin, even changing the color of certain characters to create
shading and proper coloring for the beak, looks pretty cool actualy
you can find it on slashdot archives somewhere (quickies i think). the
funny thing is netscape loads this rather large complex html file with
no difficulty at all, no real slowdown or bloat (amazing for
netscape..) but try loading it in IE and it just blows up, most of the
time it actually takes down NT itself (no joke!).  it does a nice job
of killing IE on(and) macos too)


> David
>=20
> ---------------------------------------------------------------------
> Let's make a virus that spreads through Outlook and Outlook Express
> that opens MSIE and points it at a page that says "Your Email Program
> is prone to viruses" with a link to the pine home page.
>     -- Me

lol, good idea, except i would point it at mutt or linux.org ;-)

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--X6f5cqjOqKjuoPgI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkWk/8ACgkQJKx7GixEevz8ggCfSoKiblbOoqrR8+HhahiHpFRz
p4EAn0nEEbcm0hhoXjB410KiI+yjyiGC
=PjXt
-----END PGP SIGNATURE-----

--X6f5cqjOqKjuoPgI--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
