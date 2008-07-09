Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6BDA6DE53D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 03:13:22 +1000 (EST)
Date: Thu, 10 Jul 2008 03:13:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'powerpc-next' branch
Message-Id: <20080710031305.0ccede72.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0807090812110.6382@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0807090812110.6382@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Jul_2008_03_13_05_+1000_7uRxWFvDdZBqF520"
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_Jul_2008_03_13_05_+1000_7uRxWFvDdZBqF520
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Wed, 9 Jul 2008 08:13:03 -0500 (CDT) Kumar Gala <galak@kernel.crashing.o=
rg> wrote:
>
> Please pull from 'powerpc-next' branch of
>=20
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/dts.git powerpc-next

$ git ls-remote ssh://master.kernel.org/pub/scm/linux/kernel/git/galak/dts.=
git
fatal: '/pub/scm/linux/kernel/git/galak/dts.git': unable to chdir or not a =
git archive
fatal: The remote end hung up unexpectedly

Did you mean ".../powerpc.git"?

Also, the master branch of that tree has the same problem I came up
against in linux-next today: include/asm-powerpc/pgtable-ppc64.h
mismerges between Linus' tree and the Paul's tree so you end up with two
copies of huge_ptep_set_wrprotect.  So you should amend the merge to
remove one.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Jul_2008_03_13_05_+1000_7uRxWFvDdZBqF520
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh08aEACgkQjjKRsyhoI8w+MgCgtAUAlg0/4BeMVjzPTPnQMBi5
JT8AmweP0kQ3HTrzmk1lPQ3QDnxjNT6n
=qe5/
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Jul_2008_03_13_05_+1000_7uRxWFvDdZBqF520--
