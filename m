Return-Path: <horia.geanta@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0055.outbound.protection.outlook.com [104.47.2.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406xH63FH2zF21p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 19:17:36 +1100 (AEDT)
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] crypto: talitos - fix IPsec cipher in length
Date: Fri, 23 Mar 2018 08:17:30 +0000
Message-ID: <AM3PR04MB4524FABE12B33113FF4C2D598A80@AM3PR04MB452.eurprd04.prod.outlook.com>
References: <20180322095701.4563E6F352@po15720vm.idsi0.si.c-s.fr>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/22/2018 11:57 AM, Christophe Leroy wrote:=0A=
> For SEC 2.x+, cipher in length must contain only the ciphertext length.=
=0A=
          ^^^^ turns out this should be 3.x+=0A=
=0A=
> In case of using hardware ICV checking, the ICV length is provided via=0A=
> the "extent" field of the descriptor pointer.=0A=
> =0A=
> Cc: <stable@vger.kernel.org> # 4.8+=0A=
> Fixes: 549bd8bc5987 ("crypto: talitos - Implement AEAD for SEC1 using HMA=
C_SNOOP_NO_AFEU")=0A=
> Reported-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>=0A=
Tested-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
=0A=
Thanks,=0A=
Horia=0A=
=0A=
