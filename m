Return-Path: <olaf@aepfle.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 228751A0BD7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 01:32:48 +1000 (AEST)
Date: Fri, 17 Apr 2015 17:26:42 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3 00/17] crypto: talitos - Add support for SEC1
Message-ID: <20150417152642.GA7671@aepfle.de>
References: <20150417143147.154871A242C@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20150417143147.154871A242C@localhost.localdomain>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kim Phillips <kim.phillips@freescale.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-crypto@vger.kernel.org,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 17, Christophe Leroy wrote:

> v3 is a complete rework of the patchset. Since a kernel can be built
> with support for both MPC82xx and MPC83xx at the same time, talitos
> driver shall support both SEC1 and SEC2+ at the same time.

The used git send-email command lacked the --thread option.

>From this perspective: NACK to the whole series...

Olaf
