Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0106.outbound.protection.outlook.com [157.56.110.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C96761A019A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 02:41:55 +1100 (AEDT)
Message-ID: <54F484DE.30204@Freescale.com>
Date: Mon, 2 Mar 2015 09:42:22 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: <scottwood@Freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH] powerpc/mpc85xx: Add MDIO bus muxing support to the board
 device tree(s)
References: <1425310332-21744-1-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1425310332-21744-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="windows-1252"
Cc: Shruti Kanetkar <Kanetkar.Shruti@gmail.com>,
 Igal Liberman <Igal.Liberman@Freescale.com>, afleming@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 03/02/2015 09:32 AM, Emil Medve wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> Describe the PHY topology for all configurations supported by each board
> 
> Based on prior work by Andy Fleming <afleming@gmail.com>
> 
> Change-Id: I4fbcc5df9ee7c4f784afae9dab5d1e78cdc24f0f

Bah, I'll remove this...

> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> Signed-off-by: Shruti Kanetkar <Kanetkar.Shruti@gmail.com>
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>  arch/powerpc/boot/dts/b4860qds.dts    |  60 ++++-
>  arch/powerpc/boot/dts/b4qds.dtsi      |  51 ++++-
>  arch/powerpc/boot/dts/p1023rdb.dts    |  24 +-
>  arch/powerpc/boot/dts/p2041rdb.dts    |  92 +++++++-
>  arch/powerpc/boot/dts/p3041ds.dts     | 112 +++++++++-
>  arch/powerpc/boot/dts/p4080ds.dts     | 184 +++++++++++++++-
>  arch/powerpc/boot/dts/p5020ds.dts     | 112 +++++++++-
>  arch/powerpc/boot/dts/p5040ds.dts     | 234 +++++++++++++++++++-
>  arch/powerpc/boot/dts/t1040rdb.dts    |  32 ++-
>  arch/powerpc/boot/dts/t1042rdb.dts    |  30 ++-
>  arch/powerpc/boot/dts/t1042rdb_pi.dts |  18 +-
>  arch/powerpc/boot/dts/t104xqds.dtsi   | 178 ++++++++++++++-
>  arch/powerpc/boot/dts/t104xrdb.dtsi   |  33 ++-
>  arch/powerpc/boot/dts/t2080qds.dts    | 158 +++++++++++++-
>  arch/powerpc/boot/dts/t2080rdb.dts    |  67 +++++-
>  arch/powerpc/boot/dts/t2081qds.dts    | 221 ++++++++++++++++++-
>  arch/powerpc/boot/dts/t4240qds.dts    | 400 +++++++++++++++++++++++++++++++++-
>  arch/powerpc/boot/dts/t4240rdb.dts    | 149 ++++++++++++-
>  18 files changed, 2135 insertions(+), 20 deletions(-)


Cheers,
