Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "radon.swed.at", Issuer "neon.swed.at" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32C70B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 22:19:12 +1100 (EST)
Message-ID: <4F6DAC15.7040702@nod.at>
Date: Sat, 24 Mar 2012 12:12:21 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [PATCH 09/10] um: Properly check all process' threads for a live
 mm
References: <20120324102609.GA28356@lizard> <20120324103110.GI29067@lizard>
In-Reply-To: <20120324103110.GI29067@lizard>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig88EC09FADEB6B6709009C1CF"
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
--------------enig88EC09FADEB6B6709009C1CF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 24.03.2012 11:31, schrieb Anton Vorontsov:
> kill_off_processes() might miss a valid process, this is because
> checking for process->mm is not enough. Process' main thread may
> exit or detach its mm via use_mm(), but other threads may still
> have a valid mm.
>=20
> To catch this we use find_lock_task_mm(), which walks up all
> threads and returns an appropriate task (with task lock held).
>=20
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard


--------------enig88EC09FADEB6B6709009C1CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPbawWAAoJEN9758yqZn9e/icH/iVN9aQ0/yXa9SJlm4SLtuzl
ihg243HbKaJpRbPXf+fqsEVutMgRKM+yqkVmeuTdeADDdVSoyoBb750N1fPvq7pU
yjTzeNfWySr727F6cMgblhtKzilRd6JOq+lI3JD74T/pga6mrlIE8Os8fp6HOyfR
sIyklQPPtXml4b1CboiWWwc8qlHSX+2I5w2pCcOSUozsFa8rPBdvtxiXVES0OdJJ
ZFcw2OICs2DbRRJXrq1PCx/qU6e9b3kb5Mj/peSQosjIltksQNafKECm6tonM8TN
e4ZxUnOXUxaULn9E5C7YnuQdP/0SnmF5jnKYNkNqwNIh+oqDPoVgmKnv7aG49GQ=
=Ic2C
-----END PGP SIGNATURE-----

--------------enig88EC09FADEB6B6709009C1CF--
