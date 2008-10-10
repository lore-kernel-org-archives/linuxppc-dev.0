Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD92EDDF1A
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 14:01:48 +1100 (EST)
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <68168CE9-D17F-4C55-BF0B-0FAFC3672398@kernel.crashing.org>
References: <1223495845-14149-1-git-send-email-timur@freescale.com>
	<1223496186.8157.82.camel@pasglop>
	<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>
	<1223498380.8157.86.camel@pasglop> <48ED1B9E.3020907@freescale.com>
	<48EE2A49.10405@genesi-usa.com>
	<ed82fe3e0810090920t25442258gcd5cedabf686fe2d@mail.gmail.com>
	<18670.42312.827841.167852@cargo.ozlabs.ibm.com>
	<68168CE9-D17F-4C55-BF0B-0FAFC3672398@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 14:01:37 +1100
Message-Id: <1223607697.8157.123.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Timur Tabi <timur@freescale.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-09 at 20:22 -0500, Kumar Gala wrote:
> > Historically they have been the most important 32-bit platforms, along
> > with PReP.
> >
> > The problem with making all platforms default to N is that if you take
> > the default values for all config options you end up with a config
> > that won't build.  So we want at least one platform to default to Y,
> > and pmac has been as good a choice as any for that (and probably still
> > is).
> 
> I've got no issue w/grandfathering CHRP or PMAC as default Y.  However  
> I DO NOT think we should default other platforms to 'Y' as that means  
> updating configs will pick up platforms they dont want.

Ok. So Timur, please send a new patch on top of your previous one since
I already merged it, that explicitely sets PMAC and CHRP to "n" in your
defconfigs.

Ben.
