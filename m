Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C7B4AB7189
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 11:12:09 +1000 (EST)
Date: Fri, 3 Sep 2010 11:12:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: linux-next: manual merge of the galak tree with the powerpc-merge tree
Message-Id: <20100903111202.6529b9c4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__3_Sep_2010_11_12_02_+1000_FoOh2.BmjlSlcK1B"
Cc: linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__3_Sep_2010_11_12_02_+1000_FoOh2.BmjlSlcK1B
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

Today's linux-next merge of the galak tree got a conflict in
arch/powerpc/platforms/85xx/mpc85xx_mds.c between commit
6d4f2fb0860c36e7ef16cc41126242a8b6542771 ("powerpc/85xx: Fix compilation
of mpc85xx_mds.c") from the powerpc-merge tree and commit
5dc45967402dd124980fce88d34d7f4a012a381b ("powerpc/85xx: Fix compile
error in mpc85xx_mds.c") from the galak tree.

I used the version in the powerpc-merge tree as the inititalisation of np
is unnecessary.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__3_Sep_2010_11_12_02_+1000_FoOh2.BmjlSlcK1B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMgEtiAAoJEDMEi1NhKgbsh6oH/jrfmOL7kCK6FhIe5T7E4nDi
HE/vSbMMW5tPQupQTy2srr9drBupSnBUg6EMuJJrbHmk4c+0iD3YjtmT4RYHYHNG
oy05IccAIYmNuf+w3zOY/CewZPTr/ibLNMdbML7C1OrR3+RY6ZCfCcpTDBcy4COA
LBBLfTgA4176QRVhcU7YdckxeSCVyB6K3vXkNCJNUpnERoJzEWV7XMe056/7DiuR
Ij/zGn5LdGyS4zHbHTOEHr4vZDWIR/acwKx5c5ro0hvIi5CrMeTdOxM1n+BXLyT6
Q1L7jAs221gCwGAdNrv0nH2Pci5OsS+eyys8wBMd13ruUhzsTAR2h+YnlAjM/tc=
=DHLf
-----END PGP SIGNATURE-----

--Signature=_Fri__3_Sep_2010_11_12_02_+1000_FoOh2.BmjlSlcK1B--
