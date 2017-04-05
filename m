Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyhMf4grNzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 20:06:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, Horia =?utf-8?Q?Geant=C4=83?=
 <horia.geanta@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, Scott
 Wood <oss@buserror.net>, Roy Pledge <roy.pledge@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
 Cristian Stoica <cristian.stoica@nxp.com>, Dan Douglass <dan.douglass@nxp.com>,
 "linux-arm-kernel\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Vakul Garg <vakul.garg@nxp.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 Alexandru Porosanu <alexandru.porosanu@nxp.com>,
 "linux-crypto\@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [7/7] crypto: caam/qi - add ablkcipher and authenc algorithms
In-Reply-To: <58E39F90.6050408@nxp.com>
References: <20170317100602.2837-8-horia.geanta@nxp.com>
 <87vaqkvk6c.fsf@concordia.ellerman.id.au> <58E39F90.6050408@nxp.com>
Date: Wed, 05 Apr 2017 20:06:50 +1000
Message-ID: <87lgrftbgl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Laurentiu Tudor <laurentiu.tudor@nxp.com> writes:

> Hi Michael,
>
> Just a couple of basic things to check:
>   - was the dtb updated to the newest?

Possibly not, it's an automated build/boot, I'll have to check what it
does with the dtb.

>   - is the qman node present? This should be easily visible in 
> /proc/device-tree/soc@ffe000000/qman@318000.

No it's not there.

That's running linux-next with:

CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI=n


Does that mean I didn't update the device tree?

cheers
