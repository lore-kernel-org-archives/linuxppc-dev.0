Return-Path: <scott.wood@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0046.outbound.protection.outlook.com [104.47.1.46])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXwRV2drXzDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 03:54:14 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Andy Fleming <afleming@gmail.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>, "aperez@alexperez.com"
 <aperez@alexperez.com>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH 3/3] Cyrus: create a defconfig
Date: Mon, 12 Sep 2016 17:54:07 +0000
Message-ID: <DB5PR0401MB19281D6D9CFE4352E21E57A091FF0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
 <1473189119-29458-4-git-send-email-afleming@gmail.com>
 <DB5PR0401MB1928F23FDFF08F9E1288365691F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <CAKWjMd7kKSyg4Ksn8=T9q6308LNBvRH+YqLcAMqqh=-tqEEy7w@mail.gmail.com>
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

On 09/10/2016 05:12 PM, Andy Fleming wrote:=0A=
> =0A=
> =0A=
> On Tuesday, September 6, 2016, Scott Wood <scott.wood@nxp.com=0A=
> <mailto:scott.wood@nxp.com>> wrote:=0A=
> =0A=
>     On 09/06/2016 02:12 PM, Andy Fleming wrote:=0A=
>     > This sets up the proper config elements for Power and Reset to work=
=0A=
>     > properly (using the gpio pins).=0A=
>     >=0A=
>     > Signed-off-by: Andy Fleming <afleming@gmail.com <javascript:;>>=0A=
>     > ---=0A=
>     >  arch/powerpc/Makefile                      | 5 +++++=0A=
>     >  arch/powerpc/configs/cyrus_basic_defconfig | 9 +++++++++=0A=
>     >  2 files changed, 14 insertions(+)=0A=
>     >  create mode 100644 arch/powerpc/configs/cyrus_basic_defconfig=0A=
> =0A=
>     Why does cyrus need its own defconfig?  Just enable the power/reset=
=0A=
>     stuff in 85xx-hw.config.=0A=
> =0A=
> =0A=
> =0A=
>     Ok.=0A=
=0A=
Please send non-HTML mail with proper quote markers.  It's hard to read=0A=
when it looks like someone is talking to themself.=0A=
=0A=
>     > +CONFIG_EXT3_FS=3Dy=0A=
> =0A=
>     This has nothing to do with power/reset, and is already present in=0A=
>     fsl-emb-nonhw.config.=0A=
> =0A=
> =0A=
>     Ok, weird. Are you sure? I see:=0A=
> =0A=
> =0A=
>         # CONFIG_EXT3_FS is not set=0A=
> =0A=
>         CONFIG_EXT4_FS=3Dy=0A=
=0A=
Apparently it was just removed by commit=0A=
bdd910017c6a4 ("powerpc/configs: Remove old symbols from defconfigs").=0A=
=0A=
Andrew Donnellan, why was ext3 support removed?=0A=
=0A=
-Scott=0A=
=0A=
