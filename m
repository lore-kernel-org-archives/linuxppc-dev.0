Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BA063DDE07
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 07:23:13 +1100 (EST)
Date: Wed, 14 Feb 2007 21:23:11 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
In-Reply-To: <45D316CD.9070901@freescale.com>
Message-ID: <Pine.LNX.4.60.0702142118200.8621@poirot.grange>
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
	<1171430877.20192.133.camel@localhost.localdomain>
	<45D29EB1.5060801@freescale.com>
	<1171431334.20192.138.camel@localhost.localdomain>
	<45D316CD.9070901@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: paulus@samba.org, Stuart Yoder <stuart.yoder@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 14 Feb 2007, Timur Tabi wrote:

> Benjamin Herrenschmidt wrote:
> 
> >> I just don't understand why it's okay to leave it there.
> > 
> > To make sure there is one. I suspect kernel bits might get upset if it's
> > absent.
> 
> That's not what I meant.  What I don't understand is: what's so special 
> about the 8272 that its DTS should have a 'chosen' section, but no other 
> DTS needs one?
> 
> Obviously, the kernel needs a 'chosen' section, and that's why U-Boot 
> adds one.  And since U-Boot adds one, the DTS itself doesn't need one. 
> Does the 8272 never use U-Boot?

Is that dts also for u-boot? maybe they have another bootloader? I know 
u-boot creates "chosen" itself, but not all possible bootloaders?

(as a matter of fact, the more I think about those .dts's, the more it 
seems to me like they belong to bootloaders, not in the kernel... Just 
one word - information duplication...)

Another thing, Timur, if you respin your patch, could you do it against 
the current powerpc.git? There's at least one more .dts there that also 
would need boot-cpu removed - kuroboxHD.dts.

Thanks
Guennadi
---
Guennadi Liakhovetski
