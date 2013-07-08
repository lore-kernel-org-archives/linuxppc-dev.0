Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F205D2C0296
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 09:43:39 +1000 (EST)
Date: Mon, 8 Jul 2013 18:43:06 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4] powerpc/85xx: Add support for 85xx cpu type detection
To: Haijun Zhang <Haijun.Zhang@freescale.com>
References: <1373249545-23928-1-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1373249545-23928-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Sun Jul  7 21:12:22 2013)
Message-ID: <1373326986.8183.185@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>, linux-mmc@vger.kernel.org,
 AFLEMING@freescale.com, cbouatmailru@gmail.com, cjb@laptop.org,
 linuxppc-dev@lists.ozlabs.org, Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/2013 09:12:22 PM, Haijun Zhang wrote:
> Add this file to help detect cpu type in runtime.
> These macros and inline routines will be more favorable for driver
> to apply errata and workaround to specified cpu type.
>=20
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
>  arch/powerpc/include/asm/mpc85xx.h | 96 =20
> ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/mpc85xx.h

What changed since the last time this was posted?  I don't see any of =20
the feedback addressed that I gave here:

http://patchwork.ozlabs.org/patch/144880/

-Scott=
