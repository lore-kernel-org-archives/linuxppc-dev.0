Date: Tue, 2 May 2000 13:40:28 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: Albrecht Dress <adress@mpifr-bonn.mpg.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (still there)
Message-ID: <20000502134028.B17580@cheops.usf.Uni-Osnabrueck.DE>
References: <20000502104901.G14354@cheops.usf.Uni-Osnabrueck.DE> <Pine.SOL.4.21.0005021314210.13937-100000@mpifr-bonn.mpg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
In-Reply-To: <Pine.SOL.4.21.0005021314210.13937-100000@mpifr-bonn.mpg.de>; from adress@mpifr-bonn.mpg.de on Tue, May 02, 2000 at 01:22:21PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2000 at 01:22:21PM +0200, Albrecht Dress wrote:
> > my problems with the hard freezes still continue.
> > I have not come to any idea what is causing it.
> > Several methods of trying to encircle the problem area failed.
>=20
> Sorry, I am afraid I lost some messages of this thread.  Hope this is not
> too outdated ;-)

You can look it up in the webarchive.
http://lists.linuxppc.org/listarcs/linuxppc-dev/200004/threads.html


> I _have_ a Lombard running without problems.  So just some ideas which
> might give you some more information.  Maybe you should try to work from
> the first virtual (text) console (ctrl-opt-F1).  If the kernel panics
> (which is does very likely) it will emit this information there, but you
> will NEVER see it if you are in X, and it does not necessarily go into
> /var/log/messages.

The hard freeze's low temperature prohibits all output.
Never got any error message.=20

> Did you check the serial port drivers?  I rember there were some problems
> if you use the serial.c under LinuxPPC.  You do not need it, the right one
> is macserial.c.  I could trigger panics on the Lombard and on my old 7300
> by just typing "cat /dev/ttyS0 > /dev/null".

Yes I check the serial driver, built a kernel without usb and=20
serial support at all. But the symptoms are still there.

I have 192 MB of RAM though and a 10 Gb drive , these are the only=20
differences which I think my machine might have to other lombards.

	Bernhard

--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkOvqsACgkQh9ag3dpKERbKZACeOIs5ls/rLkWDWvnpzB3ZSfDK
izkAoJEPme+mVRNPyLzxcktuYinrIwSX
=pO6s
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
