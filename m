Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B2BDDDDF80
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 10:52:40 +1000 (EST)
Date: Thu, 7 May 2009 10:52:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: clean up direct access to sysdata by
	iseries platform
Message-Id: <20090507105229.cb2e4900.sfr@canb.auug.org.au>
In-Reply-To: <20090506231338.ea3e280d.sfr@canb.auug.org.au>
References: <1241525095-18041-1-git-send-email-galak@kernel.crashing.org>
	<20090506231338.ea3e280d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__7_May_2009_10_52_29_+1000_rR4.iM4eKhChesYB"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__7_May_2009_10_52_29_+1000_rR4.iM4eKhChesYB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Wed, 6 May 2009 23:13:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Tue,  5 May 2009 07:04:55 -0500 Kumar Gala <galak@kernel.crashing.org>=
 wrote:
> >
> > We shouldn't directly access sysdata to get the device node.  We should
> > be calling pci_device_to_OF_node().
> >=20
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>=20
> It looks ok, but all I can say for now is that it doesn not make things
> worse.  During 2.6.28, the iSeries PCI code was broken.  I am working on
> a fix and after that I will be able to properly test this patch.

With my fix for the old PCI breakage, I have tested your "pci" tree for
iseries_defconfig.  Built and booted with and without CONFIG_PCI.

Tested-by: Stephen Rothwell <sfr@canb.auug.og.au>
Acked-by: Stephen Rothwell <sfr@canb.auug.og.au>

My patch, however, will probably need your attention once Ben takes
it. :-)
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__7_May_2009_10_52_29_+1000_rR4.iM4eKhChesYB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoCMM0ACgkQjjKRsyhoI8ybMwCaAoTeA/vNb5Gjgbx6jMMQJoqz
qAQAn2tANAYTLhrsWVwvELhC3bO4Fy2t
=QPNh
-----END PGP SIGNATURE-----

--Signature=_Thu__7_May_2009_10_52_29_+1000_rR4.iM4eKhChesYB--
