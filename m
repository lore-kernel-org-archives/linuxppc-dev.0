Return-Path: <B32616@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 472F02C01FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 13:13:26 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Phillips Kim-R1AAHA <R1AAHA@freescale.com>
Subject: RE: [PATCH 1/4] Talitos: move the data structure into header file
Date: Wed, 11 Jul 2012 03:13:17 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C02CC@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1341899809-20630-1-git-send-email-qiang.liu@freescale.com>
 <1341899809-20630-2-git-send-email-qiang.liu@freescale.com>
 <20120710191107.28347d94783d8c001c67ce57@freescale.com>
In-Reply-To: <20120710191107.28347d94783d8c001c67ce57@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 Geanta Neag Horia Ioan-B05471 <B05471@freescale.com>,
 Herbert Xu <herbert@gondor.hengli.com.au>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Phillips Kim-R1AAHA
> Sent: Wednesday, July 11, 2012 8:11 AM
> To: Liu Qiang-B32616
> Cc: linux-crypto@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Li Yang-
> R58472; Herbert Xu; David S. Miller; Geanta Neag Horia Ioan-B05471
> Subject: Re: [PATCH 1/4] Talitos: move the data structure into header
> file
>=20
> On Tue, 10 Jul 2012 13:56:46 +0800
> Qiang Liu <qiang.liu@freescale.com> wrote:
>=20
> > Move the declaration of talitos data structure into talitos.h.
> >
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> > ---
>=20
> this patch has already been submitted [1].
>=20
> Subsequent patches in this series also don't apply cleanly:  can
> you rebase onto [2], which is based on Herbert's cryptodev tree and
> contain's Horia's four patches, and re-send?
Kim, Thanks for your note, I will rebase the cryptodev tree and resend
the patch again.

>=20
> Also note that upstream talitos does not yet contain NAPI support
> [3].
Thanks.
>=20
> Thanks,
>=20
> Kim
>=20
> [1] http://www.mail-archive.com/linux-
> crypto@vger.kernel.org/msg07299.html
> [2] git://git.freescale.com/crypto/cryptodev.git
> [3] http://www.mail-archive.com/linux-
> crypto@vger.kernel.org/msg07289.html
