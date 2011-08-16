Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8E10B7461
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 08:41:07 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] ASoC: claim the IRQ when the fsl_ssi device is probed,
	not opened
Date: Tue, 16 Aug 2011 22:41:02 +0000
Message-ID: <4E4AF1FE.9010907@freescale.com>
References: <1313534150-6642-1-git-send-email-timur@freescale.com>
In-Reply-To: <1313534150-6642-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"broonie@opensource.wolfsonmicro.com"
	<broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> The PowerPC Freescale SSI driver is claiming the IRQ when the IRQ when
> the device is opened, which means that the /proc/interrupts entry for
> the SSI exists only during playback or capture.  This also meant that
> the user won't know that the IRQ number is wrong until he tries to use
> the device.  Instead, we should claim the IRQ when the device is probed.
>
> Signed-off-by: Timur Tabi<timur@freescale.com>

Ugh, somehow I got my patches criss-crossed.  Ignore this, please.  I'll=20
post a V2 in just a minute.=
