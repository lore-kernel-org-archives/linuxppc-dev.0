Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B40D6B7267
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 23:55:51 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A5922DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 23:55:51 +1000 (EST)
Date: Wed, 17 Jun 2009 23:55:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Avi Kivity <avi@redhat.com>
Subject: Re: linux-next: kvm/powerpc tree build failure
Message-Id: <20090617235546.95aa39a5.sfr@canb.auug.org.au>
In-Reply-To: <4A38F47F.509@redhat.com>
References: <20090617150419.e406a69a.sfr@canb.auug.org.au>
	<4A38F47F.509@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__17_Jun_2009_23_55_46_+1000_GyhvIH0i2ThtTBbK"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__17_Jun_2009_23_55_46_+1000_GyhvIH0i2ThtTBbK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Avi,

On Wed, 17 Jun 2009 16:49:51 +0300 Avi Kivity <avi@redhat.com> wrote:
>
> Thanks, applied.  For some reason my own build testing didn't fail on thi=
s.

Thanks.  It could be a different compiler version doesn't complain (I am
currently using 4.4.0) and the powerpc tree has a patch to build parts of
arch/powerpc with -Werror which makes it stand out a bit :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__17_Jun_2009_23_55_46_+1000_GyhvIH0i2ThtTBbK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko49eIACgkQjjKRsyhoI8wnagCbBoNlSUAGVX48030lymGSm9Pe
fEAAnjef5ljG6Khkc4qz5+fYk4+kfWld
=ettf
-----END PGP SIGNATURE-----

--Signature=_Wed__17_Jun_2009_23_55_46_+1000_GyhvIH0i2ThtTBbK--
