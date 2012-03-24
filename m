Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "radon.swed.at", Issuer "neon.swed.at" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1BDF0B6FEC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 22:19:26 +1100 (EST)
Message-ID: <4F6DAC28.301@nod.at>
Date: Sat, 24 Mar 2012 12:12:40 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [PATCH 07/10] um: Should hold tasklist_lock while traversing
 processes
References: <20120324102609.GA28356@lizard> <20120324103030.GG29067@lizard>
In-Reply-To: <20120324103030.GG29067@lizard>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE41A5EA7F7A3D882738B89D5"
Cc: Mike Frysinger <vapier@gentoo.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mundt <lethal@linux-sh.org>,
 John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 uclinux-dist-devel@blackfin.uclinux.org, Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE41A5EA7F7A3D882738B89D5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 24.03.2012 11:30, schrieb Anton Vorontsov:
> Traversing the tasks requires holding tasklist_lock, otherwise it
> is unsafe.
>=20
> p.s. However, I'm not sure that calling os_kill_ptraced_process()
> in the atomic context is correct. It seem to work, but please
> take a closer look.

os_kill_ptraced_process() calls a host function.
=46rom UML's point of view nothing sleeps, so this is fine.

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard


--------------enigE41A5EA7F7A3D882738B89D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPbawoAAoJEN9758yqZn9enHsH/04wJSPdhgma1hiCpbwhLKzT
jLaxk9Jl2lXj7n7ydXmtkkiYkO9QCi9syUAFKi5fV0HDyI4Yvo9ymPUOxAd569mQ
p8Jo3iUBrgDKMbUAHyK+xxawB0TsLynRQbNY1iaKhbjcR9ejqKddlDXlV40GI3k0
bU/Yk1umtUZhV9sT1ymTiHa/zAzRRhTa/AlOONRsLFWYGwtdYTm2vnDwPR0x18Zg
kNF0OKf1/4hFCNUHYpJ8F99PDMN/T5hyJ52iXUsqeg/eJS5rJopbtsTFUxf1Fh78
ksu1G6Xh5iWQVHQPDWcNrSN7t4oWbpb6OlsdojQYdOEXySuUtBVELMcjhwMCELU=
=bzOH
-----END PGP SIGNATURE-----

--------------enigE41A5EA7F7A3D882738B89D5--
