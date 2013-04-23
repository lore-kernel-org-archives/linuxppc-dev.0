Return-Path: <devurandom@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by ozlabs.org (Postfix) with ESMTP id 2C5332C011E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 04:14:13 +1000 (EST)
Received: from mailout-de.gmx.net ([10.1.76.20]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0Lbx3C-1Uttau2IYm-00jK0r for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 20:14:08 +0200
From: Dennis Schridde <devurandom@gmx.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no threads
 shown in spufs
Date: Tue, 23 Apr 2013 20:13:56 +0200
Message-ID: <1639058.AHCK50TIEC@ernie>
In-Reply-To: <20130423132436.GB1078@concordia>
References: <1470334.YUWOQ37ijW@ernie> <20130423132436.GB1078@concordia>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2742288.kJe894M9m4";
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


--nextPart2742288.kJe894M9m4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 23. April 2013, 23:24:36 schrieb Michael Ellerman:
> On Mon, Apr 22, 2013 at 06:44:13PM +0200, Dennis Schridde wrote:
> > [1.] One line summary of the problem:
> > .. no threads shown in spufs
> 
> So I think I've got this one fixed, this works for me, can you test it
> please?
Patch works - spu-top outputs threads and there are directories in /spu now.

Please also backport this to 3.8, just like the IRQ and NUMA patches. :)

Thanks!
--Dennis
--nextPart2742288.kJe894M9m4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlF2z2gACgkQjqfyF1DtJW7BxACaAt6fVZEW7VOHqSUbtJDcjcVv
nLMAn3Lo1FPcBNHZ5hoAxrPQlVdvP8W4
=UJmq
-----END PGP SIGNATURE-----

--nextPart2742288.kJe894M9m4--
