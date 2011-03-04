Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: disable MSI using new interface if possible
From: Michael Ellerman <michael@ellerman.id.au>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <1299202862-10682-1-git-send-email-nacc@us.ibm.com>
References: <1299200729.3630.52.camel@concordia>
	<1299202862-10682-1-git-send-email-nacc@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-fG6evUNwjIVRmjkJZ64I"
Date: Fri, 04 Mar 2011 14:06:56 +1100
Message-ID: <1299208016.3630.81.camel@concordia>
Mime-Version: 1.0
Cc: Joe Russell <joe@perches.com>, paulus@samba.org,
	linuxppc-dev@lists.ozlabs.org, miltonm@bga.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-fG6evUNwjIVRmjkJZ64I
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-03-03 at 17:41 -0800, Nishanth Aravamudan wrote:
> On 04.03.2011 [12:05:29 +1100], Michael Ellerman wrote:
> > On Thu, 2011-03-03 at 11:39 -0800, Nishanth Aravamudan wrote:
> > > On upcoming hardware, we have a PCI adapter with two functions, one o=
f
..
> > > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > > Cc: Milton Miller <miltonm@bga.com>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Paul Mackerras <paulus@samba.org>
> >=20
> > Cc: Me  :)
>=20
> Sorry! I was in a hurry to get this out the door, my fault. Note, you
> don't show up per scripts/get_maintainer.pl :)

No worries, though I will remember never to use get_maintainer.pl, it is
obviously utterly broken:

$ git log --pretty=3Dformat:"%an %ae" arch/powerpc/platforms/pseries/msi.c
Andre Detsch adetsch@br.ibm.com
Michael Ellerman michael@ellerman.id.au
Michael Ellerman michael@ellerman.id.au
Michael Ellerman michael@ellerman.id.au
Michael Ellerman michael@ellerman.id.au
Michael Ellerman michael@ellerman.id.au
Michael Ellerman michael@ellerman.id.au
Michael Ellerman michael@ellerman.id.au
Michael Ellerman michael@ellerman.id.au
Michael Ellerman michael@ellerman.id.au
Michael Ellerman michael@ellerman.id.au
Michael Ellerman michael@ellerman.id.au

And the patch from Andre was also signed off by me.

cheers

--=-fG6evUNwjIVRmjkJZ64I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk1wV1AACgkQdSjSd0sB4dICPACdH9YEkbmM58G7tbx1iy3nsoFj
WtMAnjmneQ8qejBIKkJbpBzUC4ihWDw2
=MVGf
-----END PGP SIGNATURE-----

--=-fG6evUNwjIVRmjkJZ64I--
