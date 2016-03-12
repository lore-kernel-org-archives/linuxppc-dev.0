Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F0901A004B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Mar 2016 12:59:41 +1100 (AEDT)
Date: Fri, 11 Mar 2016 19:59:34 -0600
From: Scott Wood <oss@buserror.net>
To: "Igal.Liberman" <igal.liberman@freescale.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 scottwood@freescale.com, linux-kernel@vger.kernel.org,
 Shaohui.Xie@freescale.com, madalin.bucur@freescale.com
Message-ID: <20160312015934.GA3286@home.buserror.net>
References: <1438589651-15007-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438589651-15007-1-git-send-email-igal.liberman@freescale.com>
Subject: Re: [v5] powerpc/mpc85xx: Add MDIO bus muxing support to the board
 device tree(s)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 03, 2015 at 11:14:10AM +0300, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> Describe the PHY topology for all configurations supported by each board
> 
> Based on prior work by Andy Fleming <afleming@freescale.com>
> 
> Signed-off-by: Shruti Kanetkar <Shruti@freescale.com>
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> ---
> 
> Depends on the following patch set:
> 	https://patchwork.ozlabs.org/patch/503107/
> 	https://patchwork.ozlabs.org/patch/503108/
> 
> v4 ---> v5:
> 	- Correct "Signed-off-by" order
> 
> v3 ---> v4:
> 	- Added T1024 support
> 
> v2 ---> v3:
> 	- Fixed incorrect E-Mail address (signed-off-by)
> 
> v1 ---> v2
> 	- Remove 'Change-Id'
> 
>  arch/powerpc/boot/dts/fsl/b4860qds.dts    |   60 ++++-
>  arch/powerpc/boot/dts/fsl/b4qds.dtsi      |   51 ++++-
>  arch/powerpc/boot/dts/fsl/p1023rdb.dts    |   24 +-
>  arch/powerpc/boot/dts/fsl/p2041rdb.dts    |   92 +++++++-
>  arch/powerpc/boot/dts/fsl/p3041ds.dts     |  112 ++++++++-
>  arch/powerpc/boot/dts/fsl/p4080ds.dts     |  184 ++++++++++++++-
>  arch/powerpc/boot/dts/fsl/p5020ds.dts     |  112 ++++++++-
>  arch/powerpc/boot/dts/fsl/p5040ds.dts     |  234 ++++++++++++++++++-
>  arch/powerpc/boot/dts/fsl/t1023rdb.dts    |   41 ++++
>  arch/powerpc/boot/dts/fsl/t1024rdb.dts    |   45 ++++
>  arch/powerpc/boot/dts/fsl/t1040rdb.dts    |   32 ++-
>  arch/powerpc/boot/dts/fsl/t1042rdb.dts    |   30 ++-
>  arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts |   18 +-
>  arch/powerpc/boot/dts/fsl/t104xqds.dtsi   |  178 ++++++++++++++-
>  arch/powerpc/boot/dts/fsl/t104xrdb.dtsi   |   33 ++-
>  arch/powerpc/boot/dts/fsl/t2080qds.dts    |  158 ++++++++++++-
>  arch/powerpc/boot/dts/fsl/t2080rdb.dts    |   67 +++++-
>  arch/powerpc/boot/dts/fsl/t2081qds.dts    |  221 +++++++++++++++++-
>  arch/powerpc/boot/dts/fsl/t4240qds.dts    |  400 ++++++++++++++++++++++++++++++++-
>  arch/powerpc/boot/dts/fsl/t4240rdb.dts    |  149 +++++++++++-
>  20 files changed, 2221 insertions(+), 20 deletions(-)

p1023rdb removed when applying, as it has dtc errors due to missing base
fman support.

-SCott
