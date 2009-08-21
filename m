Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7BCA0B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 01:18:05 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6A75ADDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2009 01:18:05 +1000 (EST)
Date: Sat, 22 Aug 2009 01:17:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] powerpc/pci: move pci_64.c device tree scanning
	code  into pci-common.c
Message-Id: <20090822011758.aa817290.sfr@canb.auug.org.au>
In-Reply-To: <fa686aa40908210754s5e54af99sdbd11eb6ec48b5f9@mail.gmail.com>
References: <20090821052714.2289.41279.stgit@localhost.localdomain>
	<20090821053014.2289.59798.stgit@localhost.localdomain>
	<20090821160116.b4a7b713.sfr@canb.auug.org.au>
	<fa686aa40908210754s5e54af99sdbd11eb6ec48b5f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__22_Aug_2009_01_17_58_+1000_2BbcTuNOzSllhde."
Cc: linuxppc-dev@ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sat__22_Aug_2009_01_17_58_+1000_2BbcTuNOzSllhde.
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Fri, 21 Aug 2009 08:54:25 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> On Fri, Aug 21, 2009 at 12:01 AM, Stephen Rothwell<sfr@canb.auug.org.au> =
wrote:
> >
> > And similarly with sparc's pci_parse_of_addrs() and pci_parse_of_flags
> > () ? =C2=A0Maybe create drivers/of/pci.c (or drivers/pci/of.c)? =C2=A0O=
r maybe they
> > are still too different?
> >
> > There is probably scope for more consolidation there.
>=20
> I agree, but I'll do those things in a separate patch.  I'm making as
> few code changes as possible in this patch to ease review.

Yeah, that makes sense - it just struck me that I had seen that code
before elsewhere :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__22_Aug_2009_01_17_58_+1000_2BbcTuNOzSllhde.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqOuqYACgkQjjKRsyhoI8wjsgCfYxdgPZLAJyww7l1L0/JBxiny
HroAoJrA22QVsYi+9TaiXPxdOeDermrE
=cQ9j
-----END PGP SIGNATURE-----

--Signature=_Sat__22_Aug_2009_01_17_58_+1000_2BbcTuNOzSllhde.--
