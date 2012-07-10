Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 948082C0876
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 22:26:30 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Xu Jiucheng-B37781 <B37781@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: Create dts of each core in CAMP mode
 for P1021RDB-PC
Date: Tue, 10 Jul 2012 12:25:48 +0000
Message-ID: <CAOZdJXX1+=p3GMccLvCwFpei2igidXuo_U1gSVy56cBAkKxoHg@mail.gmail.com>
References: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
 <1341909561-6591-2-git-send-email-Jiucheng.Xu@freescale.com>
In-Reply-To: <1341909561-6591-2-git-send-email-Jiucheng.Xu@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 10, 2012 at 3:39 AM, Xu Jiucheng <Jiucheng.Xu@freescale.com> wr=
ote:
> Create the dts files for each core and splits the devices between
> the two cores for P1021RDB-PC.
>
> Core0 has l2, serial0, i2c, spi, gpio, tdm,dma, usb, eth0, eth1,
> sdhc, crypto, global-util, message, pci0, pci1, msi, crypto.
> Core1 has l2, serial1, eth2.
>
> Signed-off-by: Xu Jiucheng <Jiucheng.Xu@freescale.com>
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---

Do we really want AMP device trees upstream?  They're very
application-specific, and AMP support has always been a hack.  If
anything, I think we should be deleting AMP device trees from
upstream, not adding more.

--=20
Timur Tabi
Linux kernel developer at Freescale=
