Return-Path: <scott.wood@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0073.outbound.protection.outlook.com [104.47.2.73])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTJSB5TdrzDrpH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 06:42:18 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Andy Fleming <afleming@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "scottwood@freescale.com"
 <scottwood@freescale.com>
CC: "aperez@alexperez.com" <aperez@alexperez.com>
Subject: Re: [PATCH 3/3] Cyrus: create a defconfig
Date: Tue, 6 Sep 2016 20:42:11 +0000
Message-ID: <DB5PR0401MB1928F23FDFF08F9E1288365691F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
 <1473189119-29458-4-git-send-email-afleming@gmail.com>
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

On 09/06/2016 02:12 PM, Andy Fleming wrote:=0A=
> This sets up the proper config elements for Power and Reset to work=0A=
> properly (using the gpio pins).=0A=
> =0A=
> Signed-off-by: Andy Fleming <afleming@gmail.com>=0A=
> ---=0A=
>  arch/powerpc/Makefile                      | 5 +++++=0A=
>  arch/powerpc/configs/cyrus_basic_defconfig | 9 +++++++++=0A=
>  2 files changed, 14 insertions(+)=0A=
>  create mode 100644 arch/powerpc/configs/cyrus_basic_defconfig=0A=
=0A=
Why does cyrus need its own defconfig?  Just enable the power/reset=0A=
stuff in 85xx-hw.config.=0A=
=0A=
> +CONFIG_EXT3_FS=3Dy=0A=
=0A=
This has nothing to do with power/reset, and is already present in=0A=
fsl-emb-nonhw.config.=0A=
=0A=
-Scott=0A=
=0A=
