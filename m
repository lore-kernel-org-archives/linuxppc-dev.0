Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 06972B7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 10:04:59 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E745DDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 10:04:58 +1000 (EST)
Date: Thu, 27 Aug 2009 10:04:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: michael@ellerman.id.au
Subject: Re: PPC driver - generic bus width
Message-Id: <20090827100452.b872c7fd.sfr@canb.auug.org.au>
In-Reply-To: <1251296565.7492.7.camel@concordia>
References: <d970ff420908260625q2d34bc10p62241218f022b5c2@mail.gmail.com>
	<1251296565.7492.7.camel@concordia>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__27_Aug_2009_10_04_52_+1000_Nxqm+2Yz+bwuMFrG"
Cc: linuxppc-dev@ozlabs.org, Alemao <xcarandiru@gmail.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__27_Aug_2009_10_04_52_+1000_Nxqm+2Yz+bwuMFrG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2009 00:22:45 +1000 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> > struct device_info_t {
> > 	void (*read)();
> > 	void (*write)();

These are not prototypes because there is no parameter list (use "void" for=
 empty).

> > };
> >=20
> > static int __devinit device_probe()

This isn't a prototype either.

> > cc1: warnings being treated as errors
> > drivers/dev_test.c:37: warning: function declaration isn't a prototype
> > drivers/dev_test.c:38: warning: function declaration isn't a prototype
> > drivers/dev_test.c: In function 'device_probe':
> > drivers/dev_test.c:113: warning: assignment from incompatible pointer
> > type
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__27_Aug_2009_10_04_52_+1000_Nxqm+2Yz+bwuMFrG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqVzaQACgkQjjKRsyhoI8yRfQCgvq09fSY3N41YiJ9Vm0xACqnL
5bkAni6e6kP69a50HmamFzaEF0+OCfWQ
=saha
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Aug_2009_10_04_52_+1000_Nxqm+2Yz+bwuMFrG--
