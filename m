Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0133.outbound.protection.outlook.com [157.56.111.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DF471A0E24
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 07:48:34 +1000 (AEST)
Message-ID: <1436219299.2658.25.camel@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/t1024rdb: add ina220 current sense node
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 6 Jul 2015 16:48:19 -0500
In-Reply-To: <1435917049-24227-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1435917049-24227-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-03 at 17:50 +0800, Shengzhou Liu wrote:
> Add support for INA220 current sense.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
>  arch/powerpc/boot/dts/t1024rdb.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/t1024rdb.dts 
> b/arch/powerpc/boot/dts/t1024rdb.dts
> index 733e723..43474d9 100644
> --- a/arch/powerpc/boot/dts/t1024rdb.dts
> +++ b/arch/powerpc/boot/dts/t1024rdb.dts
> @@ -114,6 +114,13 @@
>                               reg = <0x4c>;
>                       };
>  
> +                     /* INA220 Current Sense */

Do you mean "current sensor"?

Why is this comment needed here, but not in the t1023 file?

> +                      ina220@40{

Node names should be generic (which would also eliminate any reason for the 
above comment).

-Scott
