Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D89CFDDF50
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 00:05:56 +1100 (EST)
Date: Wed, 24 Jan 2007 16:05:44 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: CPM2 interrupt controller fix
Message-ID: <20070124160544.4bad687c@localhost.localdomain>
In-Reply-To: <17847.12237.166954.453166@cargo.ozlabs.ibm.com>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
	<17844.35471.554647.189851@cargo.ozlabs.ibm.com>
	<20070122164316.79569af9@localhost.localdomain>
	<1169495737.1582.7.camel@localhost.localdomain>
	<20070122235533.6f9f8d09@localhost.localdomain>
	<1169500388.1582.14.camel@localhost.localdomain>
	<20070123004203.5a3007fa@localhost.localdomain>
	<17847.12237.166954.453166@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_RYj58.zqRW7aVm833Jfnd.Y;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_RYj58.zqRW7aVm833Jfnd.Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jan 2007 21:07:09 +1100
Paul Mackerras wrote:

> I just tried to compile up the ads8272_defconfig with ARCH=3Dppc, since
> that was the only obviously 8272-based config in arch/ppc/configs.
> However, arch/ppc/platforms/mpc8272ads_setup.c fails to compile
> because of things like this in it (line 106):
That default config is just odd, as I have noticed while testing.
It still configured to use obsoleted stuff in 8260_io/ for network.=20

Yet that does not address the problem below.

>=20
> static void init_fcc1_ioports(struct fs_platform_info*)
> {
> ...
> }
>=20
> That is, it's a function definition (not declaration) with the
> parameter name missing, which gcc rejects with an error.  Gitk tells
> me it's been like this since September.
>=20
> Is there any 8272-based config that actually still compiles with
> ARCH=3Dppc?
>

No, there are not. 8272 haven't got a lot of attention in ppc realm. There =
are also some additional issues caused by say
PHY layer update, etc. The patch that fixes all is ready though - I'll give=
 it a try today and send to the list later today.

--
Thanks,=20
Vitaly=20

--Sig_RYj58.zqRW7aVm833Jfnd.Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFt1mpuOg9JvQhSEsRAtVmAJ4n/szm10nUY5AF0xF0Q2H8XkfiCgCfSC/B
QDRScQGflh8tilaXPFLeDO8=
=inib
-----END PGP SIGNATURE-----

--Sig_RYj58.zqRW7aVm833Jfnd.Y--
