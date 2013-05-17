Return-Path: <devurandom@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by ozlabs.org (Postfix) with ESMTP id 8AD522C0106
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 May 2013 01:46:58 +1000 (EST)
Received: from mailout-de.gmx.net ([10.1.76.30]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MhOyy-1Upvu63D50-00MYLu for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 17:46:56 +0200
From: Dennis Schridde <devurandom@gmx.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no threads
 shown in spufs
Date: Fri, 17 May 2013 17:46:52 +0200
Message-ID: <1401780.1HKOhdHcrh@ernie>
In-Reply-To: <20130423091246.GA18195@concordia>
References: <1470334.YUWOQ37ijW@ernie> <20130423091246.GA18195@concordia>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3952569.Ln6MXAY723";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nextPart3952569.Ln6MXAY723
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello!

Am Dienstag, 23. April 2013, 19:12:47 schrieb Michael Ellerman:
> For me it is fixed by applying the following patch, it should be in v3.10:
> 
>   http://patchwork.ozlabs.org/patch/230103/

Can you please also backport this to 3.8? It is still missing in 3.8.12.

The patch for cbe_init_pm_irq() was included - Thanks!

--Dennis
--nextPart3952569.Ln6MXAY723
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iEYEABECAAYFAlGWUOwACgkQjqfyF1DtJW76/wCeK1IchERExK3t3WBHJVHZsIE7
7ywAnRrdKrlIBSjHrjFkDB72HWVZSpme
=Fc43
-----END PGP SIGNATURE-----

--nextPart3952569.Ln6MXAY723--
