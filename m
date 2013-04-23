Return-Path: <devurandom@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by ozlabs.org (Postfix) with ESMTP id 7278F2C0118
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 23:17:04 +1000 (EST)
Received: from mailout-de.gmx.net ([10.1.76.30]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0Lu28G-1UbkaZ2XA6-011PQq for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:17:01 +0200
From: Dennis Schridde <devurandom@gmx.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no threads
 shown in spufs
Date: Tue, 23 Apr 2013 15:16:53 +0200
Message-ID: <3242341.cjDFP0lvB2@ernie>
In-Reply-To: <20130423135155.7b307094@samson>
References: <1470334.YUWOQ37ijW@ernie> <20130423091246.GA18195@concordia>
 <20130423135155.7b307094@samson>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5674710.Q5Vd7XBReF";
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


--nextPart5674710.Q5Vd7XBReF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello!

Am Dienstag, 23. April 2013, 13:51:55 schrieb Dennis Schridde:
> Am Tue, 23 Apr 2013 19:12:47 +1000
> schrieb Michael Ellerman <michael@ellerman.id.au>:
> > On Mon, Apr 22, 2013 at 06:44:13PM +0200, Dennis Schridde wrote:
> > For me it is fixed by applying the following patch, it should be in
> > v3.10:
> I am currently compiling the patched kernel. Will report back with the
> results later.

Thanks! The patch has the intended result on my Linux 3.8.8 kernel. All 4 CPU 
cores are now being used and the cellminer hashrate went up from 42Mh/s to 
62Mh/s (with 2 PPE and 16 SPE threads, just as before).

Could it be backported, especially to 3.8?

Again - thanks for your work and quick reply,
Dennis
--nextPart5674710.Q5Vd7XBReF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlF2icoACgkQjqfyF1DtJW63NQCfQbkJU48se11phziFgdIY2MSU
31sAoJbuVwgbLs3D7n2HfVpXTb212wCD
=bXA5
-----END PGP SIGNATURE-----

--nextPart5674710.Q5Vd7XBReF--
