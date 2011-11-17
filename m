Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B8A2FB7209
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 03:04:08 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][v2] powerpc/85xx: Rework P1022DS device tree
Date: Thu, 17 Nov 2011 16:04:00 +0000
Message-ID: <CAOZdJXW9Ygz9nMmXgV_GaTPEQHi0zHB7d7uBAPV4fN7-p+ST-Q@mail.gmail.com>
References: <1321540377-3672-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1321540377-3672-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 8:32 AM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
> Utilize new split between board & SoC, and new SoC device trees split
> into pre & post utilizing 'template' includes for SoC IP blocks.
>
> Other changes include:
>
> * Reworked PCIe nodes to allow supportin IRQs for controller (errors)
> =A0and moved PCI device IRQs down to virtual bridge level
> * Changed GPIO compatiable from 'fsl,mpc8572-gpio' to 'fsl,pq3-gpio' as t=
he
> =A0'mpc8572' compatiable is to deal with a 'mpc8572' specific to an errat=
um
> * Updated spi node to new espi binding specification
> * Renamed SDHC node from 'sdhci' to 'sdhc'
> * Added usb node for 2nd usb controller
> * Dropping "fsl,p1022-IP..." from compatibles for standard blocks
> * Fixed bug in local bus range node for CS2, was maping to
> =A00x0 0x0xffa00000 instead of 0xf 0xffa00000
> * Fixed localbus reg property should have been 0xf 0xffe05000
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> v2: fixed localbus reg property

Acked-by: Timur Tabi <timur@freescale.com>

--=20
Timur Tabi
Linux kernel developer at Freescale=
