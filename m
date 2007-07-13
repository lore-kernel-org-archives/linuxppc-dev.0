Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04068DDE3F
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 20:13:27 +1000 (EST)
Subject: Re: [PATCH 2/4] Implement arch disable/enable irq hooks.
From: Johannes Berg <johannes@sipsolutions.net>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20070712191257.GA31381@ld0162-tx32.am.freescale.net>
References: <20070712191257.GA31381@ld0162-tx32.am.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-XBdSR/VrvpG13TIo5q1e"
Date: Fri, 13 Jul 2007 12:11:00 +0200
Message-Id: <1184321460.30334.6.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-XBdSR/VrvpG13TIo5q1e
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-07-12 at 14:12 -0500, Scott Wood wrote:


> +void generic_suspend_disable_irqs(void)

> +void generic_suspend_enable_irqs(void)

Oh hm on second thought, can we have these in some header file so we can
call them if we need to use the ppc_md hooks?

johannes

--=-XBdSR/VrvpG13TIo5q1e
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGl0+0/ETPhpq3jKURAjCCAKCVtGMGH3TnKwsU8s+wbmuZ74U9MACgruzJ
nvmZceq3SnLJi/4lBYnGBv8=
=cq2C
-----END PGP SIGNATURE-----

--=-XBdSR/VrvpG13TIo5q1e--
