Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: disable MSI using new interface if possible
From: Michael Ellerman <michael@ellerman.id.au>
To: Joe Perches <joe@perches.com>
In-Reply-To: <1299209359.4338.220.camel@Joe-Laptop>
References: <1299200729.3630.52.camel@concordia>
	<1299202862-10682-1-git-send-email-nacc@us.ibm.com>
	<1299208016.3630.81.camel@concordia>
	<1299209359.4338.220.camel@Joe-Laptop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-60nfqp3fgqbQjkDinuyC"
Date: Thu, 10 Mar 2011 10:12:16 +1100
Message-ID: <1299712336.6272.22.camel@concordia>
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


--=-60nfqp3fgqbQjkDinuyC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-03-03 at 19:29 -0800, Joe Perches wrote:
> On Fri, 2011-03-04 at 14:06 +1100, Michael Ellerman wrote:
> > On Thu, 2011-03-03 at 17:41 -0800, Nishanth Aravamudan wrote:
> > > On 04.03.2011 [12:05:29 +1100], Michael Ellerman wrote:
> > > > Cc: Me  :)
> > > Sorry! I was in a hurry to get this out the door, my fault. Note, you
> > > don't show up per scripts/get_maintainer.pl :)
> > No worries, though I will remember never to use get_maintainer.pl, it i=
s
> > obviously utterly broken:
>=20
> Blah, blah, stupid tool doesn't work exactly as I want,
> and it doesn't credit me for my over 2 year old patches,
> therefore it's not only stupid, it's broken...

I do not give two shits about being given "credit" for this horrible
code, but if someone changes it I may have input.

True my last patch may have been two years ago, but I _wrote the entire
file_, and essentially no one else has ever touched it.

> $ ./scripts/get_maintainer.pl -f arch/powerpc/platforms/pseries/msi.c
> Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FOR PO=
WERPC...)
> Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR POWERPC...)
> Grant Likely <grant.likely@secretlab.ca> (maintainer:OPEN FIRMWARE AND...=
)
> linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...)
> linux-kernel@vger.kernel.org (open list)
> devicetree-discuss@lists.ozlabs.org (open list:OPEN FIRMWARE AND...)
>=20
> If you don't like how it currently works, suggest
> improvements.

I think I was suggesting that I should be in that list :)

In the life of this file there have been 553 lines changed (added or
deleted), of which I have written 551, and I signed off the other 2.

So I guess I'm suggesting that when someone has written a large number
of the changes to a file they should be CC'ed. I don't know what the cut
off for "large number" should be, but anything > 50% would seem
reasonable (in terms of lines, not commits).

> How nice for you.  Last patch from you was 2 years ago.

Last patch from _anyone_ was 2 years ago. As much as I may have tried to
banish that code from my mind I can still remember some of the details,
even after 2 years :)

> CC'ing inactive non named maintainers via git
> history also draws complaints btw.

Yeah I can imagine. But that is a case of someone who is no longer
interested getting one extra email, ie. a false positive, whereas in
this case it's someone who does care _not_ seeing the patch, ie. a false
negative.

cheers


--=-60nfqp3fgqbQjkDinuyC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk14CUsACgkQdSjSd0sB4dJY9ACgk0DafyMUMYLC8nV0gtrQ8T6J
ZBIAn2glIR6GbkYW8ldthmIYzYn6i7/Z
=K+Lb
-----END PGP SIGNATURE-----

--=-60nfqp3fgqbQjkDinuyC--
