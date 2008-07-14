Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AAADDDDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 15:45:09 +1000 (EST)
Date: Mon, 14 Jul 2008 15:44:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: linux-next: manual merge of the powerpc tree
Message-Id: <20080714154459.0ed9da62.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__14_Jul_2008_15_44_59_+1000_pSDqh29PAPt8IT/i"
Cc: Nelson <markn@au1.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Mark,
	linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__14_Jul_2008_15_44_59_+1000_pSDqh29PAPt8IT/i
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul, Ben,

Today's linux-next merge of the powerpc tree got a conflict in
arch/powerpc/Kconfig between commit
4e491d14f2506b218d678935c25a7027b79178b1 ("ftrace: support for PowerPC")
from the ftrace tree and commit 3affedc4e1ce837033b6c5e9289d2ce2f5a62d31
("powerpc/dma: implement new dma_*map*_attrs() interfaces") from the
powerpc tree.

The former commit moved the "select HAVE_OPROFILE" to the bottom of the
"config PPC" list (for no reason that I can fathom) while the latter
added another select.  Simple fixup.  I can carry it.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__14_Jul_2008_15_44_59_+1000_pSDqh29PAPt8IT/i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh659sACgkQjjKRsyhoI8x89ACgn1Jdi+9YtkDFihpj7rtiLlr6
p7sAnA7TaoxHfjZ+XiY9s3k4piIpms6w
=5R8K
-----END PGP SIGNATURE-----

--Signature=_Mon__14_Jul_2008_15_44_59_+1000_pSDqh29PAPt8IT/i--
