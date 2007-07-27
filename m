Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 73B8DDDE30
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 17:55:08 +1000 (EST)
Date: Fri, 27 Jul 2007 17:54:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 3/5 v3] Add the platform device support with RapidIO to
	MPC8641HPCN platform.
Message-Id: <20070727175449.e8915b5d.sfr@canb.auug.org.au>
In-Reply-To: <11854393753986-git-send-email-wei.zhang@freescale.com>
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
	<11854393733580-git-send-email-wei.zhang@freescale.com>
	<11854393741899-git-send-email-wei.zhang@freescale.com>
	<11854393753986-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__27_Jul_2007_17_54_49_+1000_fv+hKl.ew.OoBb9j"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__27_Jul_2007_17_54_49_+1000_fv+hKl.ew.OoBb9j
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jul 2007 16:42:50 +0800 Zhang Wei <wei.zhang@freescale.com> wrot=
e:
>
> +#include <asm/of_device.h>
> +#include <asm/of_platform.h>

These should now be <linux/of_device.h> and <linux/of_platform.h>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Jul_2007_17_54_49_+1000_fv+hKl.ew.OoBb9j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGqaTSTgG2atn1QN8RApDmAJ4j7AQLvOW1eHwSgnUD2NWIXr02qgCcDX/q
mG14ygnsm9uwxnM17BFCCpk=
=2kyQ
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Jul_2007_17_54_49_+1000_fv+hKl.ew.OoBb9j--
