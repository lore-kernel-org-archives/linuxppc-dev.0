Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 68118DDF03
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 15:33:43 +1100 (EST)
Date: Wed, 25 Mar 2009 15:33:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Fw: linux-next: manual merge of the rr tree with the powerpc tree
Message-Id: <20090325153333.8a245026.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__25_Mar_2009_15_33_33_+1100_llgqCnMGwy0xxNw+"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__25_Mar_2009_15_33_33_+1100_llgqCnMGwy0xxNw+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Forgot the cc]

Begin forwarded message:

Date: Wed, 25 Mar 2009 15:08:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-next@vger.kernel.org
Subject: linux-next: manual merge of the rr tree with the powerpc tree


Hi Rusty,

Today's linux-next merge of the rr tree got a conflict in
arch/powerpc/kernel/sysfs.c between commit
9a3719341a9b5d2f5a2e590497346b61cf3462a5 ("powerpc: Make sysfs code use
smp_call_function_single") from the powerpc tree and commits
a604eba6e6850d9d225cc5e983c29be78e629580
("cpumask:remove-cpumask-games-arch-powerpc-kernel-sysfs.c") and
40d45a4bf32db8c75f837caa72bf4bb2c1040597
("cpumask:smp_call_function-in-powerpc-sysfs") from the rr tree.

The former appears to be an earlier version of the latter two.  I fixed
it up (using the rr tree version) and can carry the fix as necessary.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__25_Mar_2009_15_33_33_+1100_llgqCnMGwy0xxNw+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknJtB0ACgkQjjKRsyhoI8zLaACghTroU4SM40Hj7T2/UXYmyCVg
72wAnA4fWdcS+ARZyIaxsR52zCdlTeZK
=9sYs
-----END PGP SIGNATURE-----

--Signature=_Wed__25_Mar_2009_15_33_33_+1100_llgqCnMGwy0xxNw+--
