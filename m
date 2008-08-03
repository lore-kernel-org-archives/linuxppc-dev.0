Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5A6A8DDED0
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Aug 2008 01:02:45 +1000 (EST)
Date: Mon, 4 Aug 2008 01:02:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: move include files to arch/powerpc/include/asm
Message-Id: <20080804010238.a493e1c0.sfr@canb.auug.org.au>
In-Reply-To: <A5259752-468C-4CBA-BEF3-4E088ED1A5B9@kernel.crashing.org>
References: <20080801152030.ff10b6b2.sfr@canb.auug.org.au>
	<A5259752-468C-4CBA-BEF3-4E088ED1A5B9@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__4_Aug_2008_01_02_38_+1000_UEqVS_pRBb.n0ozB"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Roland Dreier <rdreier@cisco.com>,
	Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
	general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__4_Aug_2008_01_02_38_+1000_UEqVS_pRBb.n0ozB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 3 Aug 2008 09:58:14 -0500 Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> Paul, what's the plan for this change?  If this is something that will =20
> go in so can we get a tree with it so we can base other patches on it =20
> (like the PPC_MERGE cleanup)?

It looks like Linus is happy to take these patches, so if Paul is game he
could just shove it in powerpc-{next,master,merge} and ask Linus to pull
it.  The sooner the better in that case.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__4_Aug_2008_01_02_38_+1000_UEqVS_pRBb.n0ozB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiVyI4ACgkQjjKRsyhoI8ypigCgs1ZlTYhitZ49N+k40abxXlV/
UqIAoK6Vlu4nVDo+6dXUim3w2XUk4EsC
=rBK2
-----END PGP SIGNATURE-----

--Signature=_Mon__4_Aug_2008_01_02_38_+1000_UEqVS_pRBb.n0ozB--
