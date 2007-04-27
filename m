Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54F00DE03F
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 07:54:44 +1000 (EST)
Subject: Re: [PATCH] powerpc: fix suspend states again
From: Johannes Berg <johannes@sipsolutions.net>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070427215338.GB17224@lixom.net>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177710095.3565.64.camel@johannes.berg>
	<20070427215338.GB17224@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zSxydu0VpXzwdVcBHZvn"
Date: Fri, 27 Apr 2007 23:54:43 +0200
Message-Id: <1177710883.3565.66.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-zSxydu0VpXzwdVcBHZvn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 16:53 -0500, Olof Johansson wrote:

> > + * GPLv2
> > + */
>=20
> A regular GPL copyright blurb isn't that hard to paste in. :-)

Aw, I just hate cluttering all the files with it :)

> > +#ifdef CONFIG_SPE
> > +extern void enable_kernel_spe(void);
> > +#endif
>=20
> This should be added to asm-powerpc/system.h instead

and it shouldn't be ifdef'ed either ;)

> , and that should
> be included here since that has the enable_kernel_altivec() and
> enable_kernel_fp() definitions.

True. Guess I get to make two new patches.

johannes

--=-zSxydu0VpXzwdVcBHZvn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMnEj/ETPhpq3jKURAu6NAJ9H++A7DFk1fex6qF2h8qIRtgPKvACeMOnu
rgl2ZcskGdq/+XIyl+j24Pc=
=mVaE
-----END PGP SIGNATURE-----

--=-zSxydu0VpXzwdVcBHZvn--
