Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BA35A1007D2
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Nov 2009 22:06:27 +1100 (EST)
Date: Sun, 29 Nov 2009 22:06:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 16/27] PPC: use helpers for rlimits
Message-Id: <20091129220603.e96d1613.sfr@canb.auug.org.au>
In-Reply-To: <1259442963.2076.17.camel@pasglop>
References: <1259363167-9347-1-git-send-email-jslaby@suse.cz>
	<1259363167-9347-16-git-send-email-jslaby@suse.cz>
	<1259367557.2076.11.camel@pasglop> <4B10E385.1030900@gmail.com>
	<1259442963.2076.17.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__29_Nov_2009_22_06_03_+1100_/Zvb4eLUFcV_h4j4"
Cc: Jiri Slaby <jirislaby@gmail.com>, nhorman@tuxdriver.com,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, oleg@redhat.com,
	linuxppc-dev@ozlabs.org, mingo@redhat.com, tglx@linutronix.de,
	marcin.slusarz@gmail.com, hpa@zytor.com,
	Paul Mackerras <paulus@samba.org>, akpm@linux-foundation.org,
	James Morris <jmorris@namei.org>, torvalds@linux-foundation.org,
	mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sun__29_Nov_2009_22_06_03_+1100_/Zvb4eLUFcV_h4j4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Sun, 29 Nov 2009 08:16:03 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> On Sat, 2009-11-28 at 09:47 +0100, Jiri Slaby wrote:
> > Are you sure? The previous version with ACCESS_ONCE was generally
> > NACKed. This one uses a newly added helper which is much more cleaner
> > way to do it.
>=20
> I haven't seen a nack, but then I haven't pushed out yet so I can easily
> back it off and replace it with this one.

You need to hold off adding this to your tree until after patch 14/27
("resource: add helpers for fetching rlimits") of this series (or a
modified version of it) reaches Linus' tree.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__29_Nov_2009_22_06_03_+1100_/Zvb4eLUFcV_h4j4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksSVZsACgkQjjKRsyhoI8z7xgCfUKMP9lW83BqkRUhzJLvV4ETK
v/kAn3WGivyaF2xMoZR7AsD8r5mODJjG
=Cnxu
-----END PGP SIGNATURE-----

--Signature=_Sun__29_Nov_2009_22_06_03_+1100_/Zvb4eLUFcV_h4j4--
