Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41b28J2zCRzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 14:20:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
 Samuel Ortiz <sameo@linux.intel.com>, "David S. Miller" <davem@davemloft.net>,
 Rob Herring <robh+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-pm@vger.kernel.org, lvs-devel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
In-Reply-To: <20180724111600.4158975-1-arnd@arndb.de>
References: <20180724111600.4158975-1-arnd@arndb.de>
Date: Wed, 25 Jul 2018 14:20:25 +1000
Message-ID: <87o9ewx7xy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> writes:

> Almost all files in the kernel are either plain text or UTF-8
> encoded. A couple however are ISO_8859-1, usually just a few
> characters in a C comments, for historic reasons.
>
> This converts them all to UTF-8 for consistency.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
...
>  drivers/crypto/vmx/ghashp8-ppc.pl             |  12 +-
...
> diff --git a/drivers/crypto/vmx/ghashp8-ppc.pl b/drivers/crypto/vmx/ghash=
p8-ppc.pl
> index f746af271460..38b06503ede0 100644
> --- a/drivers/crypto/vmx/ghashp8-ppc.pl
> +++ b/drivers/crypto/vmx/ghashp8-ppc.pl
> @@ -129,9 +129,9 @@ $code=3D<<___;
>  	 le?vperm	$IN,$IN,$IN,$lemask
>  	vxor		$zero,$zero,$zero
>=20=20
> -	vpmsumd		$Xl,$IN,$Hl		# H.loXi.lo
> -	vpmsumd		$Xm,$IN,$H		# H.hiXi.lo+H.loXi.hi
> -	vpmsumd		$Xh,$IN,$Hh		# H.hiXi.hi
> +	vpmsumd		$Xl,$IN,$Hl		# H.lo=C2=B7Xi.lo
> +	vpmsumd		$Xm,$IN,$H		# H.hi=C2=B7Xi.lo+H.lo=C2=B7Xi.hi
> +	vpmsumd		$Xh,$IN,$Hh		# H.hi=C2=B7Xi.hi
>=20=20
>  	vpmsumd		$t2,$Xl,$xC2		# 1st phase
>=20=20
> @@ -187,11 +187,11 @@ $code=3D<<___;
>  .align	5
>  Loop:
>  	 subic		$len,$len,16
> -	vpmsumd		$Xl,$IN,$Hl		# H.loXi.lo
> +	vpmsumd		$Xl,$IN,$Hl		# H.lo=C2=B7Xi.lo
>  	 subfe.		r0,r0,r0		# borrow?-1:0
> -	vpmsumd		$Xm,$IN,$H		# H.hiXi.lo+H.loXi.hi
> +	vpmsumd		$Xm,$IN,$H		# H.hi=C2=B7Xi.lo+H.lo=C2=B7Xi.hi
>  	 and		r0,r0,$len
> -	vpmsumd		$Xh,$IN,$Hh		# H.hiXi.hi
> +	vpmsumd		$Xh,$IN,$Hh		# H.hi=C2=B7Xi.hi
>  	 add		$inp,$inp,r0
>=20=20
>  	vpmsumd		$t2,$Xl,$xC2		# 1st phase

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
