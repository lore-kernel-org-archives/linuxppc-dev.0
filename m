Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5FD33B7106
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Jan 2011 17:26:17 +1100 (EST)
Date: Mon, 31 Jan 2011 17:26:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the final tree
Message-Id: <20110131172609.1d5e1695.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__31_Jan_2011_17_26_09_+1100_VtEdLlAbZiOJDFgJ"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__31_Jan_2011_17_26_09_+1100_VtEdLlAbZiOJDFgJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (powerpc
allyesconfig) failed like this:

arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:989: Error: attempt to move .org backw=
ards
arch/powerpc/kernel/exceptions-64s.S:999: Error: attempt to move .org backw=
ards
arch/powerpc/kernel/exceptions-64s.S:1008: Error: attempt to move .org back=
wards

So something has added a bit of bloat in there.  I have left this broken
for now.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__31_Jan_2011_17_26_09_+1100_VtEdLlAbZiOJDFgJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJNRlYCAAoJEDMEi1NhKgbsSTwH/Rzop6pyZMJaVHLc9CSB1SQA
kZBm8uSuhPZqzeQsdGb3N8CbBPLI7u13Nha6stWkVKf1SVBaK+MezI6T2Jsnrqgm
1Oq6RJY2UaV07RoC2iZJxWGIvgQFVeuG432cP6057BKMdO1Sd0qM98676k2JJ5eF
U4373R7Q/hYuoRrHdAZpovd6vyrs8w1hdUEGMqV7eU7jNAfTYbFEYRuuggf2RaQ2
iUeKYQ2cvdftllZG4m1npiv9hrDkMGjCifvdP+NZ1ryaJID6bQjN8zvaG+4XglEM
HwUNDNDHuFFjGgIl5BQGtr+pP144+7Q4JXIhnpwWqYsb6dZyEdMEckljsJ1ecUM=
=YC3W
-----END PGP SIGNATURE-----

--Signature=_Mon__31_Jan_2011_17_26_09_+1100_VtEdLlAbZiOJDFgJ--
