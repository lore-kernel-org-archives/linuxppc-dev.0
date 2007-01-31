Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 32DCDDDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 15:55:17 +1100 (EST)
Date: Wed, 31 Jan 2007 07:55:13 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 82xx CPU features
Message-ID: <20070131075513.55302696@localhost.localdomain>
In-Reply-To: <8E9D9D0A-80B5-4861-8612-7ABAF4815C4D@kernel.crashing.org>
References: <Pine.LNX.4.60.0701252333210.13557@poirot.grange>
	<EB5DC4AE-E872-432E-A078-79A4385D6D52@kernel.crashing.org>
	<Pine.LNX.4.60.0701302301250.15262@poirot.grange>
	<8E9D9D0A-80B5-4861-8612-7ABAF4815C4D@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_J0hmZ97BVKSMDM5ddRBW.62;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_J0hmZ97BVKSMDM5ddRBW.62
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jan 2007 16:35:03 -0600
Kumar Gala wrote:

>=20
> On Jan 30, 2007, at 4:31 PM, Guennadi Liakhovetski wrote:
>=20
> > On Fri, 26 Jan 2007, Kumar Gala wrote:
> >
> >> For _CAN_NAP, I'm guessing its historic, maybe Dan knows why it =20
> >> wasn't set.
> >> What happens if you try to set it?  Are there implications at the =20
> >> system level
> >> with regards to _CAN_NAP?
> >
> > Just tested: set CPU_FTR_MAYBE_CAN_DOZE for 82xx,
> > CONFIG_BDI_SWITCH is not
> > defined, echoed 1 to /proc/sys/kernel/powersave-nap - and a 8241
> > still runs... I'll try to measure if there's any difference in power
> > consumption:-))
> >
> >> I'm looking at the CPU_FTR_PPC_LE it varies if we should use =20
> >> _PPC_LE vs
> >> _TRUE_LE (or whatever the other one is called).
>=20
> It would be good for someone to test an 8260 class (826x, 8272, =20
> etc..) to see if they have any issues.

I can see with 8272 if that makes any difference.
--
Thanks, Vitaly

--Sig_J0hmZ97BVKSMDM5ddRBW.62
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFwCEyuOg9JvQhSEsRAiA8AKCFrZmOIQaCxP//gQ+p6YypIPosLQCeIJr5
Re+Pyto+cvucnz97otlwFs8=
=9Bny
-----END PGP SIGNATURE-----

--Sig_J0hmZ97BVKSMDM5ddRBW.62--
