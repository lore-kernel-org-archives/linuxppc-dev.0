Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) by ozlabs.org (Postfix) with ESMTP id 204D91007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 04:02:28 +1000 (EST)
Received: from mail189-va3 (localhost.localdomain [127.0.0.1])	by
	mail189-va3-R.bigfish.com (Postfix) with ESMTP id 861E6114010C	for
	<linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 18:02:24 +0000 (UTC)
Received: from VA3EHSMHS019.bigfish.com (unknown [10.7.14.248])	by
	mail189-va3.bigfish.com (Postfix) with ESMTP id 7B2791150058	for
	<linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 18:02:23 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6MI245W020823	for
	<linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 11:02:05 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6MIFHui015733	for <linuxppc-dev@ozlabs.org>;
	Thu, 22 Jul 2010 13:15:17 -0500 (CDT)
Date: Thu, 22 Jul 2010 13:02:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: Bradley Hughes <bhughes@silicontkx.com>
Subject: Re: [PATCH v2 2/2] EDAC: Remove deprecated bindings for MPC85xx
Message-ID: <20100722130202.04223b4b@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTinRf_s2gC_O3D_Fh7qJjPEMltMxIaDfin-rOV5m@mail.gmail.com>
References: <AANLkTinRf_s2gC_O3D_Fh7qJjPEMltMxIaDfin-rOV5m@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Jul 2010 18:04:10 -0400
Bradley Hughes <bhughes@silicontkx.com> wrote:

> The "fsl,85..." style bindings for the l2-cache-controller
> and memory-controller were intended to be deprected as of 2.6.30
> per comment in drivers/edac/mpc85xx_edac.c.

And yet they were only removed from the in-kernel dts files in patch
1/2.

> Previous patch in this
> series updates all DTS to use the "fsl,mpc85..." style binding
> for these two nodes, allowing us to finally deprecate said
> notation.

Please leave this around.  Once a binding is used, we try to stay
compatible with it when practical.  Not all device trees in use come
straight from arch/powerpc/boot/dts (consider custom boards, and
firmware device tree manipulation), and even those that do come
straihgt from the kernel tree are not necessarily rebuilt at the same
time as the kernel.

-Scott
