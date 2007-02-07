Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BE92DDF0E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 23:26:55 +1100 (EST)
Subject: Re: [RFC 06/10] powerpc: MPIC sys_device & suspend/resume
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070205185837.244398000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185837.244398000@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vS00IDSQWYIfotlZzLxw"
Date: Wed, 07 Feb 2007 13:24:04 +0100
Message-Id: <1170851044.6798.33.camel@johannes.berg>
Mime-Version: 1.0
Cc: Torrance <torrance123@gmail.com>, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-vS00IDSQWYIfotlZzLxw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-05 at 19:30 +0100, Johannes Berg wrote:
> plain text document attachment (mpic-suspend.patch)
> This adds mpic to the system devices and implements suspend
> and resume for them. This is necessary to get interrupts for
> modules back to where they were before a suspend to disk.

This patch isn't enough, I forgot about the broken u3 ht interrupt
stuff. Will resend with code that restores those as well which actually
makes all interrupts on my powermac work after resume.

johannes

--=-vS00IDSQWYIfotlZzLxw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFycTk/ETPhpq3jKURAjcZAJ9vVqD0gI3mqfpQOSomSoaovnxTLwCgrHk5
SeSSDpLgU9vgGii9zzRNEC8=
=YLVe
-----END PGP SIGNATURE-----

--=-vS00IDSQWYIfotlZzLxw--
