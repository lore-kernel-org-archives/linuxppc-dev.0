Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: disable MSI using new interface if possible
From: Michael Ellerman <michael@ellerman.id.au>
To: Joe Perches <joe@perches.com>
In-Reply-To: <1299716903.20104.134.camel@Joe-Laptop>
References: <1299200729.3630.52.camel@concordia>
	<1299202862-10682-1-git-send-email-nacc@us.ibm.com>
	<1299208016.3630.81.camel@concordia>
	<1299209359.4338.220.camel@Joe-Laptop>
	<1299712336.6272.22.camel@concordia>
	<1299716903.20104.134.camel@Joe-Laptop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ll6aBs3rQ5POM5lDhff9"
Date: Thu, 10 Mar 2011 14:35:21 +1100
Message-ID: <1299728121.6272.46.camel@concordia>
Mime-Version: 1.0
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	Florian Mickler <florian@mickler.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-ll6aBs3rQ5POM5lDhff9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-03-09 at 16:28 -0800, Joe Perches wrote:
> On Thu, 2011-03-10 at 10:12 +1100, Michael Ellerman wrote:
> > True my last patch may have been two years ago, but I _wrote the entire
> > file_, and essentially no one else has ever touched it.
> >=20
> > > $ ./scripts/get_maintainer.pl -f arch/powerpc/platforms/pseries/msi.c
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FO=
R POWERPC...)
> > > Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR POWERPC...)
> > > Grant Likely <grant.likely@secretlab.ca> (maintainer:OPEN FIRMWARE AN=
D...)
> > > linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...)
> > > linux-kernel@vger.kernel.org (open list)
> > > devicetree-discuss@lists.ozlabs.org (open list:OPEN FIRMWARE AND...)
> > >=20
> > > If you don't like how it currently works, suggest
> > > improvements.
> >=20
> > I think I was suggesting that I should be in that list :)
>=20
> $ ./scripts/get_maintainer.pl -f --git-blame arch/powerpc/platforms/pseri=
es/msi.c
> Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FOR PO=
WERPC...,commits:8/11=3D73%)
> Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR POWERPC...,commits=
:4/11=3D36%)
> Grant Likely <grant.likely@secretlab.ca> (maintainer:OPEN FIRMWARE AND...=
)
> Michael Ellerman <michael@ellerman.id.au> (authored lines:481/481=3D100%,=
commits:11/11=3D100%)
> Linas Vepstas <linas@austin.ibm.com> (commits:1/11=3D9%)
> linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...)
> linux-kernel@vger.kernel.org (open list)
> devicetree-discuss@lists.ozlabs.org (open list:OPEN FIRMWARE AND...)

That's awesome. But it's not the default, so hardly anyone will ever use
it :)

cheers

--=-ll6aBs3rQ5POM5lDhff9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk14RvkACgkQdSjSd0sB4dJ1UACfbEC22dY4uK3v0lN6UoZ/Quv2
fMwAoKhphVZiJtMcdVPuJO2XfiF7uMxr
=AlZ8
-----END PGP SIGNATURE-----

--=-ll6aBs3rQ5POM5lDhff9--
