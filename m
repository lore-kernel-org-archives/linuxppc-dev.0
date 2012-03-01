Return-Path: <afleming@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 51085B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2012 09:06:51 +1100 (EST)
Subject: Re: [PATCH] mpc836x: fix failed phy detection for ucc ethernet on MDS
MIME-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset="us-ascii"
From: Andy Fleming <afleming@freescale.com>
In-Reply-To: <1330345501-24949-1-git-send-email-paul.gortmaker@windriver.com>
Date: Thu, 1 Mar 2012 16:06:35 -0600
Message-ID: <0CFFA9FB-E2D0-4CC3-A430-10692B62B9B0@freescale.com>
References: <1330345501-24949-1-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 27, 2012, at 6:25 AM, Paul Gortmaker wrote:

> The mpc836x_mds platform has been broken since the commit
> 6fe3264945ee63292cdfb27b6e95bc52c603bb09
>=20
> [...]

> ---
>=20
> [Andy: There may be other boards that could be having this problem
>  git grep -l enet.*ucc arch/powerpc/boot/dts/|xargs grep -L tbi
> shows four possible candidates -- but I've only got the 8360MDS. ]


Shoot. I will go look for those. I suspect I neglected all the =
UCC-having SOCs in my patch.=
