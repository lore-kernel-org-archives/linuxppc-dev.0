Return-Path: <judith@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 84B18679F0
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Sep 2006 03:48:31 +1000 (EST)
Date: Tue, 12 Sep 2006 10:48:14 -0700
From: Judith Lebzelter <judith@osdl.org>
To: Christian <evilninja@gmx.net>
Subject: Re: 'make ARCH=ppc defconfig' failing for cross-compile
Message-ID: <20060912174814.GA29226@shell0.pdx.osdl.net>
References: <20060909000512.GF9335@shell0.pdx.osdl.net>
	<Pine.LNX.4.64.0609100652160.16347@sheep.housecafe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0609100652160.16347@sheep.housecafe.de>
Cc: linuxppc-dev@ozlabs.org, Judith Lebzelter <judith@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 12, 2006 at 10:21:46AM -0700, Christian wrote:
> On Fri, 8 Sep 2006, Judith Lebzelter wrote:
> > I have been doing cross-compiles for ppc and powerpc on my i686 system.
> > In order to do this I generate the .config file like this:
> >
> > make ARCH=ppc defconfig
> > (or make ARCH=powerpc defconfig)
> 
> Seems like defconfig has been removed, because there are so many 
> sub-platforms for ppc:

I build these in OSDL's cross compile build farm (PLM) as a code check.
Our scripts are generalized to work for various architectures, so it is
disappointing that 'defconfig' no longer works for ppc the way it does 
in other achitectures.  Are there plans to make plain 'defconfig' work 
again, at least in the new 'powerpc' directory?  (The 'ppc64_defconfig' 
target looks good to me.:)

> 
> $ ls arch/ppc/configs/*defconfig | wc -l
> 56
> 
> Just pick the defonfig for your platform, for my PReP that'd be:

I will do this as a work-around.

TFYR,
Judith

> 
> $ make ARCH=ppc CROSS_COMPILE=powerpc-604-linux-gnu- prep_defconfig
> 
> 
> HTH,
> Christian.
> -- 
> BOFH excuse #383:
> 
> Your processor has taken a ride to Heaven's Gate on the UFO behind Hale-Bopp's comet.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
