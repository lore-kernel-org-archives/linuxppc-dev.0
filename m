Return-Path: <B16394@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E3C92C008E
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2012 15:04:44 +1100 (EST)
From: Garg Vakul-B16394 <B16394@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] Revert "crypto: caam - Updated SEC-4.0 device tree
 binding for ERA information."
Date: Thu, 13 Dec 2012 04:04:37 +0000
Message-ID: <065BBB7616BCE543832A2EF096986B94141389@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1354870649-3656-1-git-send-email-vakul@freescale.com>
 <C38A27FC-51EF-44F3-8474-33162DE1A272@kernel.crashing.org>
In-Reply-To: <C38A27FC-51EF-44F3-8474-33162DE1A272@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kumar

This has been applied to:=20

git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git.

Regards

Vakul

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, December 13, 2012 3:00 AM
> To: Garg Vakul-B16394
> Cc: linux-crypto@vger.kernel.org; linuxppc-dev@ozlabs.org; devicetree-
> discuss@lists.ozlabs.org
> Subject: Re: [PATCH] Revert "crypto: caam - Updated SEC-4.0 device tree
> binding for ERA information."
>=20
>=20
> On Dec 7, 2012, at 2:57 AM, Vakul Garg wrote:
>=20
> > This reverts commit a2c0911c09190125f52c9941b9d187f601c2f7be.
> >
> > Signed-off-by: Vakul Garg <vakul@freescale.com>
> > ---
> > Instead of adding SEC era information in crypto node's compatible, a
> > new property 'fsl,sec-era' is being introduced into crypto node.
> >
> > .../devicetree/bindings/crypto/fsl-sec4.txt        |    5 ++---
> > 1 files changed, 2 insertions(+), 3 deletions(-)
>=20
> What tree do you think this has been applied to?
>=20
> - k
