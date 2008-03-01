Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E7970DDE45
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 14:17:43 +1100 (EST)
Date: Sat, 1 Mar 2008 14:17:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 3/3] firewire: fw-ohci: shut up false compiler warning
	on PPC32
Message-Id: <20080301141741.172013ba.sfr@canb.auug.org.au>
In-Reply-To: <tkrat.ee238048a5a50184@s5r6.in-berlin.de>
References: <tkrat.ac97915a5b51e35b@s5r6.in-berlin.de>
	<tkrat.ee238048a5a50184@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__1_Mar_2008_14_17_41_+1100_o/GMhk9mU8xKS2eN"
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__1_Mar_2008_14_17_41_+1100_o/GMhk9mU8xKS2eN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 1 Mar 2008 02:50:44 +0100 (CET) Stefan Richter <stefanr@s5r6.in-ber=
lin.de> wrote:
>
> Shut up two "may be used uninitialised in this function" warnings due to
> PPC32's implementation of dma_alloc_coherent().
>=20
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> ---
>=20
> Wasn't there a macro somewhere for this?

Yes, uninitialized_var() in linux/compiler*.h

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__1_Mar_2008_14_17_41_+1100_o/GMhk9mU8xKS2eN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHyMrYTgG2atn1QN8RAuGnAJoCyrWtO5Jhedr4l88lJ17mjeGoCwCfV41U
PoDIU5XhAEeKWD9B/bRMCao=
=ZoQs
-----END PGP SIGNATURE-----

--Signature=_Sat__1_Mar_2008_14_17_41_+1100_o/GMhk9mU8xKS2eN--
