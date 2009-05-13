Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E12C0DDFBE
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 16:39:08 +1000 (EST)
Date: Wed, 13 May 2009 16:39:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>
Subject: Re: [PowerPC] Next May 8 boot failure: OOPS during ibmveth moduleinit
Message-Id: <20090513163901.42f1110d.sfr@canb.auug.org.au>
In-Reply-To: <20090512174451.eeed4126.sfr@canb.auug.org.au>
References: <20090508180251.f53f204e.sfr@canb.auug.org.au>
	<4A042B20.4090903@in.ibm.com>
	<20090508.125722.54378771.davem@davemloft.net>
	<20090508223332.GA4881@psychotron.englab.brq.redhat.com>
	<4A085B3D.5000806@in.ibm.com>
	<20090512170458.39c4ffb7.sfr@canb.auug.org.au>
	<20090512174451.eeed4126.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__13_May_2009_16_39_01_+1000_WqeK12O6tU83QWoA"
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org, netdev@vger.kernel.org,
	Jiri Pirko <jpirko@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__13_May_2009_16_39_01_+1000_WqeK12O6tU83QWoA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Tue, 12 May 2009 17:44:51 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 12 May 2009 17:24:02 +1000
> Subject: [PATCH] net/ibmveth: fix panic in probe
>=20
> netdev->dev_addr changed from being an array to being a pointer, so we
> should not take its address for memcpy().

I have applied this to linux-next until you decide what to do with it.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__13_May_2009_16_39_01_+1000_WqeK12O6tU83QWoA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoKawUACgkQjjKRsyhoI8yb5QCeIn6gd4nvVJ1my7iV/BGP0GnZ
Jf8An3ps24EgleVouCX40HH5hW83QllC
=tQMf
-----END PGP SIGNATURE-----

--Signature=_Wed__13_May_2009_16_39_01_+1000_WqeK12O6tU83QWoA--
