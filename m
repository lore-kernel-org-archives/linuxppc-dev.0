Return-Path: <scottwood@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DCE1C2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2013 04:21:56 +1100 (EST)
Message-ID: <1384363303.1403.143.camel@snotra.buserror.net>
Subject: Re: [PATCH] Add a vga alias node for P1022
From: Scott Wood <scottwood@freescale.com>
To: Jin Zhengxiong-R64188 <Jason.Jin@freescale.com>
Date: Wed, 13 Nov 2013 11:21:43 -0600
In-Reply-To: <13F8657A829DAB49A2A937FD6FC10F790B5CF17A@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1378459957-26334-1-git-send-email-Jason.Jin@freescale.com>
 <13F8657A829DAB49A2A937FD6FC10F790B5CF17A@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-13 at 00:28 -0600, Jin Zhengxiong-R64188 wrote:
> > -----Original Message-----
> > From: Jin Zhengxiong-R64188
> > Sent: Friday, September 06, 2013 5:33 PM
> > To: Wood Scott-B07421
> > Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Jin
> > Zhengxiong-R64188
> > Subject: [PATCH] Add a vga alias node for P1022
> > 
> > From: Jason Jin <Jason.jin@freescale.com>
> > 
> > When the vga was set as the stdout and stderr in u-boot, the stdout fixup
> > code in u-boot need to find out the vga alias node in dtb.
> > 
> > Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/fsl/p1022si-post.dtsi | 2 +-
> > arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi  | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> [Jason Jin-R64188] Any comments about this patch? Thanks.

This isn't a VGA-compatible device.  If this is needed by U-Boot, please
provide a comment explaining the compatibility issue, and ideally also
provide a display alias so that no other components grow dependencies on
the vga alias.

-Scott
