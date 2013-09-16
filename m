Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 259EA2C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 05:43:07 +1000 (EST)
Received: from mail225-tx2 (localhost [127.0.0.1])	by
 mail225-tx2-R.bigfish.com (Postfix) with ESMTP id 582EF9600EE	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Sep 2013 19:43:02 +0000 (UTC)
Received: from TX2EHSMHS014.bigfish.com (unknown [10.9.14.254])	by
 mail225-tx2.bigfish.com (Postfix) with ESMTP id 0533520049	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Sep 2013 19:43:01 +0000 (UTC)
Message-ID: <1379360577.2536.142.camel@snotra.buserror.net>
Subject: Re: [PATCH] Powerpc/dts: Correct sdhci quirk for bsc9131
From: Scott Wood <scottwood@freescale.com>
To: Zhang Haijun <B42677@freescale.com>
Date: Mon, 16 Sep 2013 14:42:57 -0500
In-Reply-To: <5236BD62.8050604@freescale.com>
References: <1378118222-17338-1-git-send-email-Haijun.Zhang@freescale.com>
 <5236BD62.8050604@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, X.Xie@freescale.com,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-16 at 16:12 +0800, Zhang Haijun wrote:
> On 09/02/2013 06:37 PM, Haijun Zhang wrote:
> > We use property "sdhci,auto-cmd12" instead of "fsl,sdhci-auto-cmd12"
> > to distinguish if the sdhc host has quirk SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12.
> >
> > Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> > ---
> >   arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi b/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
> > index 5180d9d..0c0efa9 100644
> > --- a/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
> > @@ -130,7 +130,7 @@ usb@22000 {
> >
> >   /include/ "pq3-esdhc-0.dtsi"
> >   	sdhc@2e000 {
> > -		fsl,sdhci-auto-cmd12;
> > +		sdhci,auto-cmd12;
> >   		interrupts = <41 0x2 0 0>;
> >   	};
> >
> >
> 
> 
> Hi, scott
> 
> Could you help review this patch?

I process patches in periodic batches.  There's no need for a reminder
when it's only been two weeks, as long as it's still marked "new" or
"under review" in patchwork (and you should include a patchwork link in
any such reminder e-mail).  Especially for a trivial patch such as this,
no comment often means I looked at it and saw no problems and will take
it in the next batch.

Though if you want a comment, don't capitalize "powerpc" in the
subject. :-)

-Scott
