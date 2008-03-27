Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E007CDDF1E
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 14:48:07 +1100 (EST)
Date: Thu, 27 Mar 2008 14:48:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] Remove CONFIG_PCI_LEGACY from pasemi_defconfig
Message-Id: <20080327144802.7ef491f4.sfr@canb.auug.org.au>
In-Reply-To: <20080327034103.GA31504@lixom.net>
References: <20080327142743.82c4f0fb.sfr@canb.auug.org.au>
	<20080327034103.GA31504@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__27_Mar_2008_14_48_02_+1100_bTZL.DH4FX86kmUZ"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__27_Mar_2008_14_48_02_+1100_bTZL.DH4FX86kmUZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2008 22:41:03 -0500 Olof Johansson <olof@lixom.net> wrote:
>
> I've already requested Paul to pull a defconfig update that includes
> all changes besides the PCI_LEGACY disabling. Since it's not critical,
> I'll do the same change in the for-2.6.26 branch but let the pull request
> for 2.6.25 be as-is, if that's OK with you. This is of course with the
> hopes that Paul will pull and push it before the .25 release.

Yeah, that's fine - I missed your pull request.  I'll redo the patch
based on your tree.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__27_Mar_2008_14_48_02_+1100_bTZL.DH4FX86kmUZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH6xj3TgG2atn1QN8RAnT9AKCD4i+c7OlV4FJSjmwNftu8+KNrlACfVPGU
yVzZ59/cUq6/9TWbpvMtpII=
=53qM
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Mar_2008_14_48_02_+1100_bTZL.DH4FX86kmUZ--
