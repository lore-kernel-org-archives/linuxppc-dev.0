Return-Path: <roubert@df.lth.se>
Received: from df.lth.se (mail.df.lth.se [194.47.250.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F4A167B93
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 01:52:05 +1000 (EST)
Received: from igloo.df.lth.se (localhost [127.0.0.1])
	by df.lth.se (8.13.1/8.13.1) with ESMTP id k8RFq0Ub005950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 17:52:00 +0200 (CEST)
Received: (from roubert@localhost)
	by igloo.df.lth.se (8.13.1/8.13.1/Submit) id k8RFpx1p005946
	for linuxppc-embedded@ozlabs.org; Wed, 27 Sep 2006 17:51:59 +0200 (CEST)
Date: Wed, 27 Sep 2006 17:51:57 +0200
From: Fredrik Roubert <roubert@df.lth.se>
To: linuxppc-embedded@ozlabs.org
Subject: Re: How to move from /ppc/ to /powerpc/
Message-ID: <20060927155156.GC22745@igloo.df.lth.se>
References: <20060912153316.GC16340@igloo.df.lth.se>
	<20060912105830.3923d537.kim.phillips@freescale.com>
	<20060913132817.GD18263@igloo.df.lth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
In-Reply-To: <20060913132817.GD18263@igloo.df.lth.se>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 13 Sep 15:28 CEST 2006, Fredrik Roubert wrote:

> > Matt's u-boot patches address the issue well for 85xx, they are
> > straightforward to adapt to 83xx:
> >
> > http://sourceforge.net/mailarchive/forum.php?thread_id=3D15518792&forum=
_id=3D12898
>
> OK, I've adapted and applied those patches now.

In case someone else also is interested in using Matt's flat device tree
patches with U-Boot 1.1.4, I've posted my backport of the relevant parts
of the patch to the u-boot-users mailing list now.

Cheers // Fredrik Roubert

--=20
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (SunOS)

iQCVAwUBRRqeHMRKuLhQMn35AQLsFwP/adDD0ln4j3ggc25LEYzVNn6DJB5azaoG
50+52l5aqutm5pSWvIar6vr7DpMM/heKd/W8rVO/uzsd06r60nb0O2eUSmfA7mMy
L3Pv+5PoQvO7YOolvRuq6/SdvHcP2AkvbSpgZ5RBA7IlwgOY2rSNBUZmv9B4te4l
4qprKvfO+xo=
=o59p
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
