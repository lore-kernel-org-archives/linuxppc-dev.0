Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 9B0862C0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 10:54:26 +1000 (EST)
Date: Tue, 2 Jul 2013 10:54:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the powerpc tree
Message-Id: <20130702105415.8579055c3539bbb3e3cacfbc@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__2_Jul_2013_10_54_15_+1000_6lmMRLOZs4.YIL2+"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__2_Jul_2013_10_54_15_+1000_6lmMRLOZs4.YIL2+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/pstore/ftrace.c: In function 'pstore_ftrace_call':
fs/pstore/ftrace.c:47:6: warning: passing argument 7 of 'psinfo->write_buf'=
 makes integer from pointer without a cast [enabled by default]
      sizeof(rec), psinfo);
      ^
fs/pstore/ftrace.c:47:6: note: expected 'size_t' but argument is of type 's=
truct pstore_info *'
fs/pstore/ftrace.c:47:6: error: too few arguments to function 'psinfo->writ=
e_buf'

Caused by commit 6bbbca735936 ("pstore: Pass header size in the pstore
write callback").

I have used the version from next-20130701 for today.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__2_Jul_2013_10_54_15_+1000_6lmMRLOZs4.YIL2+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR0iS8AAoJEECxmPOUX5FE/BEP/iW7+HjyytorMyGWIT7qo5VC
FqEX9wRwTGe63tTRZ/c9fds9ARm+LFruMB8az+WFbLHEloV+I0ESp3SHbVa9X4FC
LZb3HdxjY5HRfR15tc/xwu/dRhsLVt2hyds4u3D6gsT2c+XDMWSEZlakeeUph1+z
fShfX4S8zE//J10scU6OoYm+9dLEY1uT6pL7v2PYD5GpywX557mhtqXdroeYNmE8
POmGmHsYZoSuJBkZW/287EC66uUHG0TUUXNMf4282NDQsjpmuiXbWfvMIESNw/6v
+X8mKiR/7ZxZqFebG+5cjiiXdhTbIbecF8D4+AMQR3lAKXy6jh8EY3hnzGN0N56g
ltPOnSvhS4R6hjX0+6Ff0cI8YOwCrOdEqyzJVexYjSI2xNjiRRlOob94E8Tvqzi/
eTMvBN4NUnM6Ooz4IZjMpLEmiKHw8bfBXeBcq8Utvx4N8d2gFAFZgCrDdOpYOeU+
vdaAQWS8J1fleMpi5JJDDaA/XPfqBZbIekqzFfnjVwu2NX8vfMHR37Re0HoEAIw2
EZsfEFRlUR6CjGA+KcqWx1SVGemuZ8wXsevu14LgbUS2sMiaI5iX/DfpU548oW3D
KWkbWYax9lMc8ib/UKGDDHy4OCpl+vz6wJkKtuLvv95uQpzqngrPWHAz+XvPGF+A
m8+Rmh7sZ2hs5yaCq9so
=qlRT
-----END PGP SIGNATURE-----

--Signature=_Tue__2_Jul_2013_10_54_15_+1000_6lmMRLOZs4.YIL2+--
