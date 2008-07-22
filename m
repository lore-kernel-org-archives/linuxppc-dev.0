Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DDC08DDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 11:35:02 +1000 (EST)
Date: Tue, 22 Jul 2008 11:34:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] serial: fix struct uart_info change fallout
Message-Id: <20080722113458.8c5c77c6.sfr@canb.auug.org.au>
In-Reply-To: <20080722003814.GA14809@redhat.com>
References: <20080722102520.ca801ab5.sfr@canb.auug.org.au>
	<20080722003814.GA14809@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__22_Jul_2008_11_34_58_+1000_.7NOZ=DtUIsBKIno"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__22_Jul_2008_11_34_58_+1000_.7NOZ=DtUIsBKIno
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Mon, 21 Jul 2008 20:38:14 -0400 Dave Jones <davej@redhat.com> wrote:
>
> That's the same pair of patches I sent earlier, which apparently were
> "Already in the ttydev tree" which should be in linux-next ?

Indeed.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__22_Jul_2008_11_34_58_+1000_.7NOZ=DtUIsBKIno
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiFOUIACgkQjjKRsyhoI8wLvwCgv4wDxAOhnWLBb4/63R7TAOsj
iLwAn2xD4EMYGZ2Msglqn8ozg+ifokjZ
=bfBK
-----END PGP SIGNATURE-----

--Signature=_Tue__22_Jul_2008_11_34_58_+1000_.7NOZ=DtUIsBKIno--
