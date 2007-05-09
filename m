Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 72683DDE05
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 09:11:39 +1000 (EST)
Date: Thu, 10 May 2007 09:11:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] Move reg_booke.h to include/asm-powerpc
Message-Id: <20070510091138.6e4fe0e6.sfr@canb.auug.org.au>
In-Reply-To: <11787390792190-git-send-email-becky.bruce@freescale.com>
References: <11787390792190-git-send-email-becky.bruce@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_May_2007_09_11_38_+1000_4bNA+XVXpJFmxfuh"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_May_2007_09_11_38_+1000_4bNA+XVXpJFmxfuh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed,  9 May 2007 14:31:19 -0500 Becky Bruce <becky.bruce@freescale.com> wrote:
>
> This patch moves reg_booke.h from include/asm-ppc to include/asm-powerpc.  This is
> just a git-mv of the file; no changes were made.  Tested builds of 8540 ADS and
> Ebony platforms with ARCH=ppc and ARCH=powerpc.
>
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
>  include/{asm-ppc => asm-powerpc}/reg_booke.h |    0
>  1 files changed, 0 insertions(+), 0 deletions(-)
>  rename include/{asm-ppc => asm-powerpc}/reg_booke.h (100%)
>
> diff --git a/include/asm-ppc/reg_booke.h b/include/asm-powerpc/reg_booke.h
> similarity index 100%
> rename from include/asm-ppc/reg_booke.h
> rename to include/asm-powerpc/reg_booke.h

Could you please change the self inclusion protection defines?

Thanks.
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_May_2007_09_11_38_+1000_4bNA+XVXpJFmxfuh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQlUxFdBgD/zoJvwRApr2AJ4ipfaz6KA1OzhIKBskePVIOUsdsACcCyO3
DveLTm3W7vOEvIHPLDK3MG4=
=htE3
-----END PGP SIGNATURE-----

--Signature=_Thu__10_May_2007_09_11_38_+1000_4bNA+XVXpJFmxfuh--
