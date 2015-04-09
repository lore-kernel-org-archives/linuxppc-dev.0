Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1ED71A10A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 08:31:26 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0114.outbound.protection.outlook.com [207.46.100.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2D1FA14007F
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2015 08:31:25 +1000 (AEST)
Message-ID: <1428618671.22867.551.camel@freescale.com>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
From: Scott Wood <scottwood@freescale.com>
To: Pan Lijun-B44306 <Lijun.Pan@freescale.com>
Date: Thu, 9 Apr 2015 17:31:11 -0500
In-Reply-To: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
References: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Schmitt
 Richard-B43082 <richard.schmitt@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-09 at 16:52 -0500, Pan Lijun-B44306 wrote:
> Hi Maintainers,
> 
> We have a proposal for writing the defconfigs for freescale's powperpc platforms in a new way.
> Can you take a look and provide some feedback?
> 
> You know currently we have mpc85xx_defconfig, corenet32_defconfig, bsc913x_defconfig, *fman*_defconfig, etc.
> We are going to extract some common parts from the existing defconfigs, and name it, say, fsl_basic_defconfig.
> Then, we could create some defconfigs targeting specific features or specific platforms.
> Say, features specific: kvm_defconfig, fman_defconfig, etc.
> Platforms specific: p1_defconfig, p2_defcongfig, p4_defconfig, t1_defconfig, t2_defconfig, t2_defconfig, b4_defconfig, etc
> When we want to make a kernel image for p1 platform,
> Using the following steps:
> 
> make ./scripts/kconfig/merge_config.sh arch/powerpc/configs/fsl_basic_config p1_defconfig
> make
> 
> What do you think of this new approach?
> Will you accept this approach?

I'm OK with a merge_config approach.

I'm not OK with having separate builds for p1/p2/p4/t1/t2/b4.

-Scott
