Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6C958DDE1B
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 18:12:32 +1000 (EST)
Date: Fri, 27 Jul 2007 18:12:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 4/5 v3] Add RapidIO support to powerpc architecture.
Message-Id: <20070727181221.79433178.sfr@canb.auug.org.au>
In-Reply-To: <11854393763547-git-send-email-wei.zhang@freescale.com>
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
	<11854393733580-git-send-email-wei.zhang@freescale.com>
	<11854393741899-git-send-email-wei.zhang@freescale.com>
	<11854393753986-git-send-email-wei.zhang@freescale.com>
	<11854393763547-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__27_Jul_2007_18_12_21_+1000_/oiy7i_VmRjfKJ/y"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__27_Jul_2007_18_12_21_+1000_/oiy7i_VmRjfKJ/y
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jul 2007 16:42:51 +0800 Zhang Wei <wei.zhang@freescale.com> wrot=
e:
>
> +
> +#include <../sysdev/fsl_rio.h>

This can just be <sysdev/fsl_rio.h> if it is only built on 32bit.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Jul_2007_18_12_21_+1000_/oiy7i_VmRjfKJ/y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGqajuTgG2atn1QN8RAt+GAJ4+PGrI0sH940WErfsYSWrQhJAlaACfZ0la
2DuaS6P2ye4ObokhC4vBwQI=
=UcRa
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Jul_2007_18_12_21_+1000_/oiy7i_VmRjfKJ/y--
