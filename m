Return-Path: <devurandom@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by ozlabs.org (Postfix) with ESMTP id 35FC52C0270
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 22:46:29 +1000 (EST)
Received: from mailout-de.gmx.net ([10.1.76.16]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0LflnY-1UsC6K01mM-00pJte for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 14:41:22 +0200
From: Dennis Schridde <devurandom@gmx.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no threads
 shown in spufs
Date: Tue, 23 Apr 2013 14:41:18 +0200
Message-ID: <2626925.UsNZfo6Rvj@ernie>
In-Reply-To: <20130423121620.GB27200@concordia>
References: <1470334.YUWOQ37ijW@ernie> <20130423140116.0a40c2c6@samson>
 <20130423121620.GB27200@concordia>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1778623.XnQ1RCBlbD";
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


--nextPart1778623.XnQ1RCBlbD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 23. April 2013, 22:16:21 schrieb Michael Ellerman:
> On Tue, Apr 23, 2013 at 02:01:16PM +0200, Dennis Schridde wrote:
> > I applied following patch by Grant Likely
> > <grant.likely@secretlab.ca> to fix some IRQ mapping problems:
> Ah yes, I forgot I also have basically the same patch. I've just sent it
> to the list.
> 
> We appear to have a number of problems with the irq mapping on cell,
> that patch fixes the worst of them but there are more.

Yes, and it would be great if that patch could actually be merged (I have been 
using it since November, but Grant apparently never merged it) and maybe the 
other problems could be solved, too. I am willing to assist in debugging and 
testing.

--Dennis
--nextPart1778623.XnQ1RCBlbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlF2gW4ACgkQjqfyF1DtJW69hACdFZY9mWG1CdZ6iLgYgEXYRUEK
jxsAoJ1juYM5NPhT/lqZcJpXJ9albCnA
=h8XE
-----END PGP SIGNATURE-----

--nextPart1778623.XnQ1RCBlbD--
