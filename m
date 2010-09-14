Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 13A8FB70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Sep 2010 12:02:49 +1000 (EST)
Date: Tue, 14 Sep 2010 12:02:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 02/25] arch/powerpc: Use static const char arrays
Message-Id: <20100914120232.c50056ba.sfr@canb.auug.org.au>
In-Reply-To: <a2d6296e9aabed2de77ae0b44f16b13008129e48.1284406638.git.joe@perches.com>
References: <cover.1284406638.git.joe@perches.com>
	<a2d6296e9aabed2de77ae0b44f16b13008129e48.1284406638.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__14_Sep_2010_12_02_32_+1000_pML/CNC5HhCDluv5"
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__14_Sep_2010_12_02_32_+1000_pML/CNC5HhCDluv5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joe,

On Mon, 13 Sep 2010 12:47:40 -0700 Joe Perches <joe@perches.com> wrote:
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/powerpc/boot/addnote.c    |    4 ++--
>  arch/powerpc/boot/cuboot-c2k.c |    4 ++--
>  arch/powerpc/kernel/irq.c      |    2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

I am also unsure that the transformation to cuboot-c2k.c adds anything.
Other than that

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__14_Sep_2010_12_02_32_+1000_pML/CNC5HhCDluv5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMjte4AAoJEDMEi1NhKgbs6KcH/AnRgTZc22rupS1hcHUNspvF
Mhu+QCqxDvj04PNjThqlR+KmsKInTX34IxaDUjzbOf4oZHzBgn9sgz3jnafRMD2k
b1deBhg/z7dcFSNwqGnn74tpUuLFIFUPV4Jsw70SVBW/iMlO0NL/uwvCyCN5esHt
hoDMk5bJKOkLQAN2ffL3zyahNCSm8+qROkPEtzyyCSNhnn11uYI5LznGpaxSV4VP
W1vQ0O8UEjHT+Tx7ejxR7/0kBZu+2AOpZo2DmlFSpjq7hFLBQfFQwofzM8iwehD9
TMK7N7hCcXDxOBPgLyBrNBKc4QajoAXFn9q5Ew7f9z1k2osSYq+htq8TbsK2r6U=
=pzGa
-----END PGP SIGNATURE-----

--Signature=_Tue__14_Sep_2010_12_02_32_+1000_pML/CNC5HhCDluv5--
