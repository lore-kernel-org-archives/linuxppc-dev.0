Return-Path: <zch@az84smr01.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D393F2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 12:29:24 +1000 (EST)
Received: from mail131-ch1 (localhost [127.0.0.1])	by
 mail131-ch1-R.bigfish.com (Postfix) with ESMTP id 48269100322	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 02:29:18 +0000 (UTC)
Received: from CH1EHSMHS018.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.239])	by mail131-ch1.bigfish.com (Postfix) with ESMTP id
 CE797160045	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 02:29:16
 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q6O2T2LI022007	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 19:29:03 -0700
Date: Tue, 24 Jul 2012 10:30:44 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] mpc85xx_defconfig: add IDE support for MPC85xxCDS
Message-ID: <20120724023044.GA30275@localhost.localdomain>
References: <1342788325-27609-1-git-send-email-chenhui.zhao@freescale.com>
 <20120720150900.082afc7c@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20120720150900.082afc7c@pyramind.ukuu.org.uk>
Sender: <zch@az84smr01.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 20, 2012 at 03:09:00PM +0100, Alan Cox wrote:
> On Fri, 20 Jul 2012 20:45:25 +0800
> Zhao Chenhui <chenhui.zhao@freescale.com> wrote:
> 
> > Add IDE support for MPC85xxCDS.
> > 
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > ---
> >  arch/powerpc/configs/mpc85xx_defconfig |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
> > index 03ee911..45eda33 100644
> > --- a/arch/powerpc/configs/mpc85xx_defconfig
> > +++ b/arch/powerpc/configs/mpc85xx_defconfig
> > @@ -105,6 +105,8 @@ CONFIG_BLK_DEV_RAM=y
> >  CONFIG_BLK_DEV_RAM_SIZE=131072
> >  CONFIG_MISC_DEVICES=y
> >  CONFIG_EEPROM_LEGACY=y
> > +CONFIG_IDE=y
> > +CONFIG_BLK_DEV_VIA82CXXX=y
> 
> CONFIG_IDE is obsolete we shouldn't be adding it to anything as it will
> eventually go away. Please use the ATA drivers.
> 

Thanks. I will replace it with the ATA driver.

-Chenhui
