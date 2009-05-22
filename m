Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 55A74DE1D0
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 11:28:16 +1000 (EST)
Date: Fri, 22 May 2009 11:28:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: linux-next: powerpc tree build warning
Message-Id: <20090522112811.433432e2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__22_May_2009_11_28_11_+1000_rfyL2T_Onf7BBDwS"
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Vinay Sridhar <vinay@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__22_May_2009_11_28_11_+1000_rfyL2T_Onf7BBDwS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Today's linux-next build (powerpc ppc64_defconfig) produced this warning:

arch/powerpc/xmon/xmon.c: In function 'dump_log_buf':
arch/powerpc/xmon/xmon.c:2133: warning: unused variable 'i'

Introduced by commit f312deb4cd0c88196edf6dab192b7d42514398d6
("powerpc/xmon: Add dl command to dump contents of __log_buf").

[As an aside, that commit contains this:
	Signed-off-by: Michael Ellerman <michael at ellerman.id.au>
but we use real email addresses normally]

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__22_May_2009_11_28_11_+1000_rfyL2T_Onf7BBDwS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoV/6sACgkQjjKRsyhoI8z8AgCfWP+uELrtefAYzlaAQkJlLibO
RbAAoKbYp02h/fCYq0zDdXcJdSQNch3O
=Y/5/
-----END PGP SIGNATURE-----

--Signature=_Fri__22_May_2009_11_28_11_+1000_rfyL2T_Onf7BBDwS--
