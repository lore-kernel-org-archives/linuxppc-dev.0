Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.protection.outlook.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 924352C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 16:58:45 +1100 (EST)
From: "Shengzhou.Liu@freescale.com" <Shengzhou.Liu@freescale.com>
To: Hongbo Zhang <hongbo.zhang@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 1/5] powerpc/85xx/dts: add third elo3 dma component
Date: Fri, 13 Dec 2013 05:43:19 +0000
Message-ID: <ae3fab730b4a45c0812d3ca5a89fce52@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1386760774-14743-1-git-send-email-Shengzhou.Liu@freescale.com>
 <52A9887D.3060109@freescale.com>
In-Reply-To: <52A9887D.3060109@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Hongbo Zhang [mailto:hongbo.zhang@freescale.com]
> Sent: Thursday, December 12, 2013 5:57 PM
> To: Liu Shengzhou-B36685; linuxppc-dev@lists.ozlabs.org; Wood Scott-
> B07421
> Subject: Re: [PATCH 1/5] powerpc/85xx/dts: add third elo3 dma component
>=20
> Shengzhou,
> I canceled my patch http://patchwork.ozlabs.org/patch/295157/ because the
> original wrong elo3-dma-2.dtsi hadn't been merged.
> But please pay attention to comments from Scott about my changes of
> adding 208 for some interrupts, and take some actions if needed, or
> further discussions.
>=20
> Below comments form Scott:
> "The FSL MPIC binding should be updated to point out how this works.
> Technically it's not a change to the binding itself, since it's defined
> in terms of register offset, but the explanatory text says "So interrupt
> 0 is at offset 0x0, interrupt 1 is at offset 0x20, and so on." which is
> not accurate for these new high interrupt numbers."
>=20
Hongbo,
Could you update FSL MPIC binding as Scott pointed out?

thanks,
Shengzhou
