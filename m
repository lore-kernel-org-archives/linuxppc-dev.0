Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B83CDDFA4
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 21:34:30 +1000 (EST)
Subject: Re: PReP residual to device-tree converter
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1215602952.3670.39.camel@johannes.berg>
References: <18490.22494.511244.977267@cargo.ozlabs.ibm.com>
	<1215600470.3670.35.camel@johannes.berg>
	<1215602952.3670.39.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rMwxczrMO/efWtDWvbWW"
Date: Wed, 09 Jul 2008 13:33:41 +0200
Message-Id: <1215603221.3670.41.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-rMwxczrMO/efWtDWvbWW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-07-09 at 13:29 +0200, Johannes Berg wrote:
> On Wed, 2008-07-09 at 12:48 +0200, Johannes Berg wrote:
> > > I would like people that have PReP machines to take a copy of
> > > /proc/residual, run this program on it, and check that the output is
> > > sane.  If it isn't, or if it is missing bits, send me the residual
> > > blob with a description of what's wrong in the generated dts.
> >=20
> > Here's the output from qemu:
> [...]
>=20
> Milton wanted iomem and ioports, I didn't manage to get userspace
> working so I printed them in the kernel (hopefully correctly):
>=20
> iomem:
> c0000000-feffffff : PCI host bridge
>   c80000f0-c80000ff : 0000:00:01.0

Oh and if I attach a virtual ne2k_pci, it changes:

c0000000-feffffff : PCI host bridge
  c1100000-c110000f : 0000:00:02.0
  c80000f0-c80000ff : 0000:00:01.0

johannes

--=-rMwxczrMO/efWtDWvbWW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJIdKIRAAoJEKVg1VMiehFYm/wQALuAtkhScqjiREFykc76fzTq
Ehbaw4niSJgj5gutQ2kO1fHMp5Xe7ZmmnY1y9EgpzchiD/aZxbskYFBjkLTik0kQ
OY6bmDQ0MGVHl3I4W5T/VoM52sD7/NDk9NQ8eLfXNKD9Pjxu+C4REM4LPEhm+cb9
zm5649rUFX5kWuqooj3bNUbwN24k56WLYq0yRj+Tq/ITGCz3CUPTTYXQIXAg0hhP
oKyCrWu3eRcbEDL7d0cwyTSmVQBkktQushLQxCkw3U6CWOQvyLWai7z2BC7v/Nwe
+10E2oPI2f+/iO3ni77wttdbAv9TFvYLJMaHoXNS7IA5rIUbmFUTXt66Z13NHIre
0Aw+ZA2FVGeJKpfEPbWr/9RyLphlRrDIFyhgIbxTioHHsvnf989OKaZES/wua4WO
pm/On06tA6kvY2jon/HzaHTUs6vhgIY/cdc87023jyjscuJECNguk1RIz/+1fXYU
gkBWWb+ME9rfDASCPbUE3s3KRRo42nP79oQ1L+Bw4WHMZ2DeWfTpIkSKOb9gsOm9
lWdxHsA3Iu9ABruxgS3kTvJQakp/7twpTRrAN4QynqqnhzSmHqWwO9HeLWMhsS3m
JoV6EWsjcnJjXYPE76gcoiU1YK9P7pPwl2gOalHuunJJ+pGYNzaqcGNVb1v+espg
IANg4Rt9pSqaCp5zmdiz
=5AkQ
-----END PGP SIGNATURE-----

--=-rMwxczrMO/efWtDWvbWW--
