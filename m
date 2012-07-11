Return-Path: <R1AAHA@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A8752C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 10:13:13 +1000 (EST)
Date: Tue, 10 Jul 2012 19:11:07 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Qiang Liu <qiang.liu@freescale.com>
Subject: Re: [PATCH 1/4] Talitos: move the data structure into header file
Message-ID: <20120710191107.28347d94783d8c001c67ce57@freescale.com>
In-Reply-To: <1341899809-20630-2-git-send-email-qiang.liu@freescale.com>
References: <1341899809-20630-1-git-send-email-qiang.liu@freescale.com>
 <1341899809-20630-2-git-send-email-qiang.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>, horia.geanta@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 10 Jul 2012 13:56:46 +0800
Qiang Liu <qiang.liu@freescale.com> wrote:

> Move the declaration of talitos data structure into talitos.h.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> ---

this patch has already been submitted [1].

Subsequent patches in this series also don't apply cleanly:  can
you rebase onto [2], which is based on Herbert's cryptodev tree and
contain's Horia's four patches, and re-send?

Also note that upstream talitos does not yet contain NAPI support
[3].

Thanks,

Kim

[1] http://www.mail-archive.com/linux-crypto@vger.kernel.org/msg07299.html
[2] git://git.freescale.com/crypto/cryptodev.git
[3] http://www.mail-archive.com/linux-crypto@vger.kernel.org/msg07289.html
