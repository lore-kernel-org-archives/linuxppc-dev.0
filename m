Return-Path: <dedekind1@gmail.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id A70E12C0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2012 19:45:15 +1100 (EST)
Message-ID: <1353055550.20111.4.camel@sauron.fi.intel.com>
Subject: Re: [PATCH] driver/mtd/IFC:Wait tWB time, poll R/B before command
 execution
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Fri, 16 Nov 2012 10:45:50 +0200
In-Reply-To: <1352362380-13568-1-git-send-email-prabhakar@freescale.com>
References: <1352362380-13568-1-git-send-email-prabhakar@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-p1u89ZdsBtvAtDSqQGJd"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org, Hemant Nautiyal <hemant.nautiyal@freescale.com>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-p1u89ZdsBtvAtDSqQGJd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-11-08 at 13:42 +0530, Prabhakar Kushwaha wrote:
> IFC_FIR_OP_CMD0 issues command for execution without checking flash
> readiness. It may cause problem if flash is not ready. Instead use
> IFC_FIR_OP_CW0 which Wait for tWB time and poll R/B to return high or
> time-out, before issuing command.
>=20
> NAND_CMD_READID command implemention does not fulfill above requirement. =
So
> update its programming.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Signed-off-by: Hemant Nautiyal <hemant.nautiyal@freescale.com>

Pushed to l2-mtd.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-p1u89ZdsBtvAtDSqQGJd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQpf0+AAoJECmIfjd9wqK0VYgQALKyCPQINHPfi2KU+qyEkiuJ
RQzzoCS/U9nmdFnpBRrby1cXdXadtKl3uN7bb1hnncGYDRORc6DS+841B6UsyHWP
GIghG2THSU2CbIeyLJQr5PWyPMPtlr2SU74bLeeU2OVcgbX8Ssv+WorZwjGNMzpb
n3uKjOJZkXxGgQOMwJGesgb6rIJfbzQ3u/XLkUH6pgfM1jzNphxnQlqY4sP0NdTq
OXSYIbCp9V8eEv824a4+xZtjOHrim2wHM58bVh6baKP0fVfGvlpsgtf1jXXX2CEV
lLsfsL9oaZSab7PQWhPpkVYwzlVcZJPCj3HOqD7pZRhXSCjNqYULGeg+1RFJqwme
n8HKf2oyl9Pr3ZsbYTVY05aYNWk2PAVSynwh13OZaLJApso9puJUTAs9GdzWAXBA
TNenOtvlZmPQOYUToTstp7AOedGyTOAEEWaWmcFRBBH1s6wCxRtK4Ll991jhw5Yj
JWzA3gDzEWvH1jIs52N8cyWxyhwpH+NNS6Bt64X15LaFUIl68OAUhYggKFXppuSp
EoUGFdWK5JEU5ylnYJwCxt3/8glgHxjFmYSa7SSQfXErqBPR1+m0GK3WvyQ20cxP
f3wdhMfQcFRh/hws/jZ9iJknsCMdwYYEtTxI6MV759GefsqgRjKl6Z+r7Kv5QlFe
sQh4aCsf5T0Ahzo0DW/3
=2daM
-----END PGP SIGNATURE-----

--=-p1u89ZdsBtvAtDSqQGJd--
