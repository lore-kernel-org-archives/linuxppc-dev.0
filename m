Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B62AF67CC0
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Nov 2006 10:20:49 +1100 (EST)
Date: Thu, 9 Nov 2006 10:20:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Judith Lebzelter <judith@osdl.org>
Subject: Re: [PATCH]  powerpc iseries link error in allmodconfig
Message-Id: <20061109102032.8c3e3b58.sfr@canb.auug.org.au>
In-Reply-To: <20061108173429.GB14991@shell0.pdx.osdl.net>
References: <20061108173429.GB14991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__9_Nov_2006_10_20_32_+1100_imOnlbEjKaY9r.oi"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__9_Nov_2006_10_20_32_+1100_imOnlbEjKaY9r.oi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 8 Nov 2006 09:34:29 -0800 Judith Lebzelter <judith@osdl.org> wrote:
>
> Choose rpa_vscsi.c over iseries_vscsi.c when building both
> pseries and iseries.  This fixes a link error.
>
> Signed-off-by:  Judith Lebzelter <judith@osdl.org>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__9_Nov_2006_10_20_32_+1100_imOnlbEjKaY9r.oi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFUmZGFdBgD/zoJvwRAqQdAJ4q6UB2eodBXXBt+BeyEEb8e9MxRACfb2BK
bLPrP4dxPqP1HJPwFnsKW04=
=WKsI
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Nov_2006_10_20_32_+1100_imOnlbEjKaY9r.oi--
