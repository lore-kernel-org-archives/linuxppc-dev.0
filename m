Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 17696DDEB7
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 23:44:23 +1000 (EST)
Date: Fri, 19 Oct 2007 23:44:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v6 4/9] add platform support for MPC837x MDS board
Message-Id: <20071019234416.cc1066ec.sfr@canb.auug.org.au>
In-Reply-To: <044B09E9-2B1B-4BCC-BDFD-31269E41CC8F@kernel.crashing.org>
References: <1192719847-25045-1-git-send-email-leoli@freescale.com>
	<1192719847-25045-2-git-send-email-leoli@freescale.com>
	<1192719847-25045-3-git-send-email-leoli@freescale.com>
	<1192719847-25045-4-git-send-email-leoli@freescale.com>
	<20071019104318.edfd2ad1.sfr@canb.auug.org.au>
	<044B09E9-2B1B-4BCC-BDFD-31269E41CC8F@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__19_Oct_2007_23_44_16_+1000_FW2WEVnTJ2894Az3"
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__19_Oct_2007_23_44_16_+1000_FW2WEVnTJ2894Az3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Oct 2007 08:10:00 -0500 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> what's the rule of thumb to know when to include <asm/prom.h> does =20
> everything starting with of_flat_* come from there?

Basically anything that deals with the flattened device tee should
include asm/prom.h.  This may change in the future, but that will be my
problem.  linux/of.h should be included for dealing with the unflattened
device tree.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__19_Oct_2007_23_44_16_+1000_FW2WEVnTJ2894Az3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHGLS1TgG2atn1QN8RAjFVAJ9qVDZjHDn17nSyrRjM2gkRGDzAsACeIhSm
c+Efm0c+n2s4KDaWFW1zfYE=
=zmQR
-----END PGP SIGNATURE-----

--Signature=_Fri__19_Oct_2007_23_44_16_+1000_FW2WEVnTJ2894Az3--
