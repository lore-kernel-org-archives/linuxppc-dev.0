Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2309967CBD
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 08:24:13 +1000 (EST)
Date: Wed, 4 Oct 2006 02:24:05 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: Please pull upstream branch of linux-2.6-PQ.git...
Message-ID: <20061004022405.45e26c26@localhost.localdomain>
In-Reply-To: <4522BC0F.7060001@smiths-aerospace.com>
References: <20061003223054.06e25136@localhost.localdomain>
	<4522BC0F.7060001@smiths-aerospace.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig___tyViavx+ARrap6WBByZ5f;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig___tyViavx+ARrap6WBByZ5f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 03 Oct 2006 15:37:51 -0400
Jerry Van Baren wrote:

> Vitaly Bordug wrote:
> > Paul,
> >=20
> > Please do a pull from
> >=20
> > git://git.kernel.org/pub/scm/linux/kernel/git/vitb/linux-2.6-PQ.git,
> > upstream branch.
> >=20
> > Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> >=20
> >=20
> > To receive the updated 8272 addition to the  arch/powerpc.
> > All the comments have been addressed, and it has a minor bugfix
> > addressed too in order to make both pq2 and pq3 co-exist happily in
> > fsl_soc.c. CPM PIC now has "compatible" property that could be
> > "CPM2" or "CPM1" for PQ/8xx.
> >=20
> > I think it should go to rc1, because relevant stuff in ppc/ is more
> > or less broken now, with new irq engine.=20
>=20
> Hi Vitaly,
>=20
> I've been following your -PQ progress with a lot of interest.  I have
> a PQ2FADS board (8272) and your changes should apply to it too.  I
> pulled a copy of your repository last week and had a couple of minor
> build errors.  I made a couple of minor fixes and it built OK but I
> didn't run it - I need a compatible boot loader, which leads into my
> question...
>=20
> What are you using for booting your 8272ADS board?  I have been using=20
> u-boot with the "bd" structure but am looking to switch to the
> flattened OF tree.  I made a half-hearted attempt to switch my u-boot
> build to the flattened OF tree but it didn't work and then I got
> distracted by other things instead of debugging it. :-(
>=20

Well I use latest u-boot + OF patches submitted to the u-boot list+ couple =
of minor fixes on top.
I was about to set up git repo for Wolfgang to pull, meanwhile there are a =
couple of existing
trees you may want to take a look: on http://www.jdl.com and http://opensou=
rce.freescale.com .

Both are holding uboot trees with OF additions, but are targeted to specifi=
c platforms apparently (and waiting to be
merged too).

I'll keep you posted while get the stuff available.
--

-Vitaly

--Sig___tyViavx+ARrap6WBByZ5f
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFIuMGuOg9JvQhSEsRAuEsAJ9qwEakF65g2IGJl6j2JoiHdk26ywCfZtQf
09skofQulLndig7eP+StumM=
=p9ZW
-----END PGP SIGNATURE-----

--Sig___tyViavx+ARrap6WBByZ5f--
