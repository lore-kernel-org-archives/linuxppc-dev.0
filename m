Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7F562DDE9E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 10:58:44 +1000 (EST)
Date: Tue, 15 May 2007 10:58:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] Bamboo platform support
Message-Id: <20070515105837.204d080f.sfr@canb.auug.org.au>
In-Reply-To: <1179154743.3420.25.camel@zod.rchland.ibm.com>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
	<1179154743.3420.25.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_May_2007_10_58_37_+1000_OTkjniN_6PeGz1Xk"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_May_2007_10_58_37_+1000_OTkjniN_6PeGz1Xk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Josh,

On Mon, 14 May 2007 09:59:03 -0500 Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
>
> @@ -35,6 +35,7 @@ config 440EP
>  	bool
>  	select PPC_FPU
>  	select IBM440EP_ERR42
> +#	select IBM_NEW_EMAC_ZMII

This bit belongs in a separate patch (I assume it slipped in by accident).

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_May_2007_10_58_37_+1000_OTkjniN_6PeGz1Xk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSQXCFdBgD/zoJvwRAuEmAJ4gnjwByYKHUymqJeYxc3HzmFx+VQCeM+SH
omco2LLVzEZZlm8z7vX0siQ=
=2Or2
-----END PGP SIGNATURE-----

--Signature=_Tue__15_May_2007_10_58_37_+1000_OTkjniN_6PeGz1Xk--
