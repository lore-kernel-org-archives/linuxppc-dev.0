Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BDB15B6F7A
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 21:28:57 +1000 (EST)
Received: from mail12-va3 (localhost.localdomain [127.0.0.1])	by
	mail12-va3-R.bigfish.com (Postfix) with ESMTP id 7FB12AE0064	for
	<linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 11:28:52 +0000 (UTC)
Received: from VA3EHSMHS016.bigfish.com (unknown [10.7.14.241])	by
	mail12-va3.bigfish.com (Postfix) with ESMTP id 62B35194004E	for
	<linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 11:28:52 +0000 (UTC)
Subject: Re: [PATCH] [v2] powerpc/p1022ds: fix audio-related properties in the
	device tree
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1307559785-11007-1-git-send-email-timur@freescale.com>
Date: Wed, 22 Jun 2011 06:28:38 -0500
Message-ID: <003F1DCD-06E3-4F15-8861-D80FF683648D@freescale.com>
References: <1307559785-11007-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 8, 2011, at 2:03 PM, Timur Tabi wrote:

> On the Freescale P1022DS reference board, the SSI audio controller is
> connected in "asynchronous" mode to the codec's clocks, so the device tree
> needs an "fsl,ssi-asynchronous" property.
> 
> Also remove the clock-frequency property from the wm8776 node, because
> the clock is enabled only if U-Boot enables it, and U-Boot will set the
> property if the clock is enabled.  A future version of the P1022DS audio
> driver will configure the clock itself, but for now, the driver should
> not be told that the clock is running when it isn't.
> 
> Also fix the FIFO depth to 15, instead of 16.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/p1022ds.dts |    9 ++++++---
> 1 files changed, 6 insertions(+), 3 deletions(-)

applied to merge

- k
