Return-Path: <michael@ellerman.id.au>
Subject: Re: Fix regression.  Make hot unlplug of CPU0 work again.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20071005070519.GQ9814@bakeyournoodle.com>
References: <20071005035241.GO9814@bakeyournoodle.com>
	<20071005070519.GQ9814@bakeyournoodle.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-31PRjKHTdu4CkPlBUxay"
Date: Fri, 05 Oct 2007 22:20:15 +1000
Message-Id: <1191586815.9375.2.camel@concordia>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-31PRjKHTdu4CkPlBUxay
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-10-05 at 17:05 +1000, Tony Breeds wrote:
> On Fri, Oct 05, 2007 at 01:52:41PM +1000, Tony Breeds wrote:
> > Early in the 2.6.23 cycle we broke the ability to offline cpu0
> > (7ccb4a662462616f6be5053e26b79580e02f1529).  This patch fixes that by
> > ensuring that the (xics)  default irq server, will not be 0 when taking
> > cpu0 offline.
> >=20
> > Also catches a use of irq, when virq should be used (I think that the
> > last one).
>=20
> Hmm testing, this on a JS21 shows that it doesn't work.  I guess I'll go
> back to the drawing board.

Maybe we should revert the original patch and go back to the drawing
board for 2.6.24? Making sure we address the initial problem (which was
exposed by kexec I think) and that we don't break cpu hotplug on the
way.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-31PRjKHTdu4CkPlBUxay
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBiv/dSjSd0sB4dIRAsVEAKC7cjjCGnzwOpqFNQ8h7qX6O2rk9wCfdY3X
ndoPtgfYkfwBHbyDE3HUGSI=
=RVTg
-----END PGP SIGNATURE-----

--=-31PRjKHTdu4CkPlBUxay--
