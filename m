Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F24A9DDDEF
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 04:53:10 +1100 (EST)
Subject: Re: [PATCH v2] powerpc: allow configuring max stack dump depth
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18724.36588.435729.738363@cargo.ozlabs.ibm.com>
References: <1225534317.3560.8.camel@johannes.berg>
	<18723.38125.245930.196074@cargo.ozlabs.ibm.com>
	<1227095318.26243.17.camel@johannes.berg>
	<18724.36588.435729.738363@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-gTzkQzX15zdYo7lp/2Ao"
Date: Thu, 20 Nov 2008 14:20:04 +0100
Message-Id: <1227187204.14852.14.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-gTzkQzX15zdYo7lp/2Ao
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-11-20 at 09:10 +1100, Paul Mackerras wrote:
> Johannes Berg writes:
>=20
> > On my screen, when something crashes, I only have space for maybe
> > 16 functions of the stack trace before the information above it
> > scrolls off the screen. It's easy to hack the kernel to print out
> > only that much, but it's harder to remember to do it. This patch
> > introduces a config option for it so that I can keep the setting
> > in my config.
> >=20
> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> > ---
> > Sure, here's an updated version. I used DEBUG_KERNEL since the
> > ADVANCED_CONFIGURATION help text implies it's for MM and can cause the
> > kernel to not boot, not something this config is related to.
>=20
> Um, with this I get a compile error when DEBUG_KERNEL=3Dn:
>=20
>   CC      arch/powerpc/kernel/process.o
> /home/paulus/kernel/powerpc/arch/powerpc/kernel/process.c:1001: error: 'C=
ONFIG_PRINT_STACK_DEPTH' undeclared here (not in a function)
> make[2]: *** [arch/powerpc/kernel/process.o] Error 1

Ouch, clearly I haven't been paying attention, my mistake. Sorry about
that.

> I think it needs to look like this:
>=20
> +config PRINT_STACK_DEPTH
> +	int "Stack depth to print" if DEBUG_KERNEL

Yes, that's better, thanks.

johannes

--=-gTzkQzX15zdYo7lp/2Ao
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJJWQBAAoJEKVg1VMiehFYaxEQAK+T0ZYNufSW8Wo5Uqrx3CDp
HsfF2Hks4Mg7K3cAas0VeSa71uUqAyP0gYO4kd59hdw6pVwdG6OUbGnh7gE+NmnR
9ke9Ei47MEAzJ8GuHRdIktb/QUX1Sua/xJ47J7YtFxaJNXjlgxiKBoctD03q4WqR
GZfnHyHyLjCAl3sfg3T951DB7h4bsp3ulUsaPWKjrhCtUdlLvOPlD+bsMY/jw6UX
FOYKysW5cuWVvNtSQiIxlUseWBYTHjJSg01v7z6WtqDVeKY/SOd2NNhDe26b6PvV
qAnGzZDqxvR5lOhi9rfKZuZYUMQuc8yQMLxRA4uPv35bRpzu6NLP5BnzJPbZfojX
OZy3CzDuonpcKu3U/3ohPOojxJ566j95KBdBAJigeOLJ2ZLc/uqX67krgiyQUnic
4AQ09/+6kB6URaKJ/kzcpV/AnwVGiBywSEPjxi05k3GKdZq5RXQcIYbexyvqwZFQ
68LvzXSipQ6X1sC5s2gBOlEKJMAI+AZBfiJTcxqqss7X2rWSvV8+Vh+gxy0RjGab
EBbiRW9M0t36TSRcxfwItVdyY8xNjqUaxClXejLJDlK08Of1gwd3l/hbFWZ6KJPO
YIz2G02EKXPj0UPS68eWuxjeHt8pfF6dNQLahRZpdFpo5JPrmctaP4Tl/+oCE0N2
mbPCX4vUyOGTWqCHURUR
=GwiQ
-----END PGP SIGNATURE-----

--=-gTzkQzX15zdYo7lp/2Ao--
