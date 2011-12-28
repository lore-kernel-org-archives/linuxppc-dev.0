Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
 [IPv6:2402:b800:7003:1::15])
 by ozlabs.org (Postfix) with ESMTP id 46FB9B6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 19:49:56 +1100 (EST)
Date: Wed, 28 Dec 2011 19:49:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the final tree (powerpc
 related)
Message-Id: <20111228194949.ff20a609745e816c266f7d91@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__28_Dec_2011_19_49_49_+1100_UydnkmtpD6GOxCBy"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__28_Dec_2011_19_49_49_+1100_UydnkmtpD6GOxCBy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ,

After merging the final tree, today's linux-next build (powerpc
allyesconfig) failed like this:

kernel/built-in.o: In function `irq_dispose_mapping':
(.opd+0x159f0): multiple definition of `irq_dispose_mapping'
arch/powerpc/kernel/built-in.o:(.opd+0x960): first defined here
kernel/built-in.o: In function `irq_create_of_mapping':
(.opd+0x15a20): multiple definition of `irq_create_of_mapping'
arch/powerpc/kernel/built-in.o:(.opd+0x9a8): first defined here
kernel/built-in.o: In function `.irq_create_of_mapping':
(.text+0x147030): multiple definition of `.irq_create_of_mapping'
arch/powerpc/kernel/built-in.o:(.text+0x9de0): first defined here
kernel/built-in.o: In function `.irq_dispose_mapping':
(.text+0x146f4c): multiple definition of `.irq_dispose_mapping'
arch/powerpc/kernel/built-in.o:(.text+0x9684): first defined here

I am not sure what caused this. And have just left it broken.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__28_Dec_2011_19_49_49_+1100_UydnkmtpD6GOxCBy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO+tgtAAoJEECxmPOUX5FEdx8P/1eTRXmj1hKoxaUq2WiQ4ZDz
qIZ/ktbMolhwkemwJ345R69KiGSBJc0DPug0PcGveTN0dTEFT9gazlAMhTpwjE+0
4RBtyOrCgN8ubVX7mv0x9UVUzPrBvxZel1zvKMCxuBO7YOlBWZdZF8Qt7SewZGDW
3l+1NJmCO40Vv2hVqmI7SYSFGipVx2b2XwpkFZdtMuR9jvd/4b3sbwqmwLxY9omR
HnJQQiLetiFcTkrS2unlPLOeKGQvmJWkKv+SKNaNOPh37Yk0dIirC2XLXSRj+/bu
EKPfKJoglUlxgZhN96MaQDjF2QWFZljxtJqjKzbbzBJLvpoThRh4XMcxTcg1XI5i
W9YY2CiBmKQcnWtKXbFbU0RotufTX24ejPcab6yJsYjQuHsSEeo009RlUdJFzbA4
gcgnoSnYn61iSpShbLFTX7pvRhV8wiL3yUTx3jDO6sXg39S2QA95w44vhP3vwQVb
QDsYP4zYMVcphVOiv/wNl396fYJ8eRCKtOuoLnlFMpLAvYX2Iy/V8v7w40tGFC7c
10KHT/TP0FkkDrXb+IAcIFeBeopE9CON824S2pGKDNayj49VhyPP0v9MRzkj/UZf
hGexcNrWXNAGO7Ns6ypxAzaGUGcI6YxZLxhxMkxLHdaYWp3uspYEt+73ZiuuSAJm
viq+DQsQTa6KnBtYbQiS
=TzMH
-----END PGP SIGNATURE-----

--Signature=_Wed__28_Dec_2011_19_49_49_+1100_UydnkmtpD6GOxCBy--
