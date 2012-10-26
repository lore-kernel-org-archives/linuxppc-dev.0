Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C6682C008C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2012 04:27:14 +1100 (EST)
Date: Fri, 26 Oct 2012 12:26:50 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [PATCH v2] powerpc: book3e: WSP: Add Chroma as a new WSP/PowerEN
 platform.
Message-ID: <20121026172649.GA24322@buserror.net>
References: <DD04A5E8-2850-4DDC-9E7A-B899B0EEEF11@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <DD04A5E8-2850-4DDC-9E7A-B899B0EEEF11@pobox.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 11, 2011 at 09:47:36AM -0500, Jimi Xenidis wrote:
> On Tue Oct 4 05:02:41 EST 2011, Scott Wood wrote:
> 
> Looking at your comments below, will the following be acceptable
> 
> > On 09/29/2011 09:27 PM, Jimi Xenidis wrote:
> > > diff --git a/arch/powerpc/platforms/wsp/Kconfig b/arch/powerpc/platforms/wsp/Kconfig
> > > index ea2811c..a3eef8e 100644
> > > --- a/arch/powerpc/platforms/wsp/Kconfig
> > > +++ b/arch/powerpc/platforms/wsp/Kconfig
> > > @@ -1,6 +1,7 @@
> > >  config PPC_WSP
> > >  	bool
> > >  	select PPC_A2
> > > +	select GENERIC_TBSYNC
> > >  	select PPC_ICSWX
> > >  	select PPC_SCOM
> > >  	select PPC_XICS
> > > @@ -8,14 +9,20 @@ config PPC_WSP
> > >  	select PCI
> > >  	select PPC_IO_WORKAROUNDS if PCI
> > >  	select PPC_INDIRECT_PIO if PCI
> > > +	select PPC_WSP_COPRO
> > >  	default n
> > >  
> > >  menu "WSP platform selection"
> > >  	depends on PPC_BOOK3E_64
> 
> add "&& SMP"
> 
> > >  
> > >  config PPC_PSR2
> > > -	bool "PSR-2 platform"
> > > -	select GENERIC_TBSYNC
> > > +	bool "PowerEN System Reference Platform 2"
> > > +	select EPAPR_BOOT
> > > +	select PPC_WSP
> > > +	default y
> 
> Make these "default n"
> 
> Will that address everything?
> -jx

Did a patch ever get submitted for this?

-Scott
