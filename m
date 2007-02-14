Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2EFB0DDE30
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 07:47:27 +1100 (EST)
Date: Wed, 14 Feb 2007 21:47:25 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
In-Reply-To: <45D371C0.80805@freescale.com>
Message-ID: <Pine.LNX.4.60.0702142144280.8621@poirot.grange>
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
	<1171430877.20192.133.camel@localhost.localdomain>
	<45D29EB1.5060801@freescale.com>
	<1171431334.20192.138.camel@localhost.localdomain>
	<45D316CD.9070901@freescale.com>
	<Pine.LNX.4.60.0702142118200.8621@poirot.grange>
	<45D371C0.80805@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 14 Feb 2007, Timur Tabi wrote:

> Guennadi Liakhovetski wrote:
> 
> > (as a matter of fact, the more I think about those .dts's, the more it 
> > seems to me like they belong to bootloaders, not in the kernel... Just 
> > one word - information duplication...)
> 
> Well, that's a completely separate issue altogether.

that's why I put it in brackets:-)

> I believe that they are 
> kept with the kernel as a convenience, so that we all have more control over 
> their contents.

yeah... I read a __part__ of those lengthy discussions... Not willing to 
re-start them here, just couldn't help...

> > Another thing, Timur, if you respin your patch, could you do it against 
> > the current powerpc.git? There's at least one more .dts there that also 
> > would need boot-cpu removed - kuroboxHD.dts.
> 
> My patch already removes linux,boot-cpu from kuroboxHD.dts:
> 
> diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts 

"HD" and "HG" are not the same - it's a new file in git now...

Thanks
Guennadi
---
Guennadi Liakhovetski
