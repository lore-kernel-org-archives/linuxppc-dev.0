Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D43C2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 10:04:47 +1000 (EST)
Date: Mon, 1 Jul 2013 19:04:35 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] DTS: Add compatible list for eSDHC
To: Haijun Zhang <Haijun.Zhang@freescale.com>
In-Reply-To: <1372656110-13876-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Mon Jul  1 00:21:50 2013)
Message-ID: <1372723475.8183.100@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/01/2013 12:21:50 AM, Haijun Zhang wrote:
> Add compatible of esdhc for below board:
> p2041   p3041   p4080   p5020   p5040
>=20
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> CC: Scott Wood <scottwood@freescale.com>
> CC: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 1 +
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 1 +
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 1 +
>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 1 +
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 1 +
>  5 files changed, 5 insertions(+)

Is there something specific that depends on this, or are you just =20
trying to conform to other examples?

I don't think we need the SoC name here, given that eSDHC has a version =20
register that you can read (and an SVR in the unlikely case that that =20
isn't adequate).  If you did end up relying on this device tree change, =20
you'd be broken if an older device trees is used.

-Scott=
