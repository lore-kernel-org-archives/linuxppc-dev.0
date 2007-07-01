Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 540D5DE06A
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Jul 2007 12:04:21 +1000 (EST)
Subject: Re: ARCH=ppc or ARCH=powerpc
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <2DD9CF30-5127-4EC1-8D8E-BC6552A832AE@kernel.crashing.org>
References: <F795765B112E7344AF36AA911279641502D1A42C@xmb-sjc-212.amer.cisco.com>
	<2DD9CF30-5127-4EC1-8D8E-BC6552A832AE@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 30 Jun 2007 20:07:06 -0500
Message-Id: <1183252026.10368.8.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: Bizhan Gholikhamseh <bgholikh@cisco.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-27 at 20:20 -0500, Kumar Gala wrote:
> On Jun 27, 2007, at 4:41 PM, Bizhan Gholikhamseh ((bgholikh)) wrote:
> 
> > Hi All,
> > Sorry for asking this question again, I am still not clear on some  
> > of the issues.
> > Background:
> > We have developed a custom board based on Freescale reference  
> > board: MPC8555_CDS with MPC8541E processor running Linux 2.6.11 and  
> > uboot 1.1.2 version.
> >
> > I would like to update the Linux kernel to the latest available  
> > kernel 2.6.21.
> > Here are my questions:
> > 1- Should I use ARCH=ppc or ARCH=powerpc to build the kernel?
> 
> Move to ARCH=powerpc.
> 
> > 2- I have seen similar filenames under arch/ppc and arch/powerpc,  
> > which one applies to MPC8541E?
> 
> There is support for MPC8541e in both arch/ppc & arch/powerpc.

Why?  Shouldn't the arch/ppc support be killed if it's in arch/powerpc?

josh
