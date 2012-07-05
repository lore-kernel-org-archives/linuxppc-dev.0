Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 446142C02EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 18:33:52 +1000 (EST)
Date: Thu, 5 Jul 2012 18:33:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the final tree
Message-Id: <20120705183345.ee84ec1048a19aa1c7129578@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__5_Jul_2012_18_33_45_+1000_611tFbWnbaq1mpxy"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__5_Jul_2012_18_33_45_+1000_611tFbWnbaq1mpxy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (powerpc
allyesconfig) failed like this:

powerpc64-linux-ld: drivers/built-in.o: In function `.gpiochip_is_requested=
':
(.text+0x4): sibling call optimization to `_savegpr0_29' does not allow aut=
omatic multiple TOCs; recompile with -mminimal-toc or -fno-optimize-sibling=
-calls, or make `_savegpr0_29' extern

I got more than 60000 of these messages before I killed the link. :-(  I
am not sure what has changed to do this, but it may have been masked for
the past few releases due to other linking problems.

I have left this broken for today.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__5_Jul_2012_18_33_45_+1000_611tFbWnbaq1mpxy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP9VFpAAoJEECxmPOUX5FEr/YQAIx9U+6XTE36nEohZEY6fKJL
hffLwEBbdUk0HWbk5x9oMTltSKK00V+Xgu/IJ7OCpsIbmWvZ10sn7NYqrSYmmO4B
aArh0od6j/Gd4cLKwfgBzTzMYI74XHHjGCm5t5yOzihFjDZwK9peg81RCqgbQ9YM
CjQDAuDgoI5Mx05/Bqg8yT70ACBOjsRV0n+0CslLu9+FanqHTvIPPQSQsZ/wbWu2
O/2v6nv+ZImgDkdUedzm1KGug61s3GJir8OSdcHb0RZYGgd+CAAT3mobtbA563PW
9r/1AfWJgcXnvDxJ2b/7QrBJ3lej0Wi6y/o5yjdQw80iR7dLKZ7ObonPZ7jHTm96
oFIXv0fA4SFS9H0pmNN0X2tIKL/ZZVF5Y+Yohzo4pEbSONNZY73/v+U9YYbOV+c1
w1GHfee6jvTem76IkXgGqotCYtXTa+21c5FaJgg+gU/FlmrSqpSSkdYriEPi+5CC
hW6/xrt90m1zQ4MSc9bp8yA47IKlPETTtSyymZ1nMjxzgvARo/sABEKNXythN3l2
X3kmaeK1ZGF8VBz1E/M1jzEOiSEoQupr3O0A3D5bjAQUCDopeaRVMz8xl5qB5Gfy
hVGCehopZMbW51+q9OHN92DcDFZaKuVi/NDKXMlrXuZNPNFkpdkETk5dM2JmWO33
XKNmYjZB0RyM7Q/XDY6k
=qvIb
-----END PGP SIGNATURE-----

--Signature=_Thu__5_Jul_2012_18_33_45_+1000_611tFbWnbaq1mpxy--
