Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 50DDEB7BD5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 17:02:41 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 39C19DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 17:02:41 +1000 (EST)
Date: Thu, 23 Jul 2009 17:02:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/20] powerpc: Add definitions used by exception
	handling on 64-bit Book3E
Message-Id: <20090723170236.8b87e72f.sfr@canb.auug.org.au>
In-Reply-To: <20090723060000.22008DDD1B@ozlabs.org>
References: <20090723060000.22008DDD1B@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__23_Jul_2009_17_02_36_+1000_v7mMX_0aozKqGIc5"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__23_Jul_2009_17_02_36_+1000_v7mMX_0aozKqGIc5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Another trivial one.

On Thu, 23 Jul 2009 15:59:49 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> +#ifndef __EXCEPTION_64E_H__
> +#define __EXCEPTION_64E_H__

To be consistent with most of our headers, please use
_ASM_POWERPC_EXCEPTION_64E_H.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__23_Jul_2009_17_02_36_+1000_v7mMX_0aozKqGIc5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpoCwwACgkQjjKRsyhoI8yuuQCcC+wZYat+neewI0sPX0JHunY0
ZnUAnRpKLwpUI11vv25FdK4ltxhgm0EP
=bj39
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Jul_2009_17_02_36_+1000_v7mMX_0aozKqGIc5--
