Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 0DEC167A87
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Feb 2005 02:56:26 +1100 (EST)
Date: Fri, 18 Feb 2005 08:56:24 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>,
	linuxppc-embedded@ozlabs.org, Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050218085624.A11439@cox.net>
References: <45ABD2373C33C4459D42B40EC4F346F205E1A4F0@FTWMLVEM03.e2k.ad.ge.com>
	<20050217225414.GA32623@gate.ebshome.net>
	<20050217233605.GA10915@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050217233605.GA10915@gate.ebshome.net>;
	from ebs@ebshome.net on Thu, Feb 17, 2005 at 03:36:05PM -0800
Subject: Re: 440GX interrupt
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 17, 2005 at 03:36:05PM -0800, Eugene Surovegin wrote:
> On Thu, Feb 17, 2005 at 02:54:14PM -0800, Eugene Surovegin wrote:
> > Probably it's a race which cannot be avoided anyway because external 
> > IRQs are completely async, and your version of ppc4xx_pic.c just has a 
> > bug. I'll think about it a little more.
> 
> Uhh, yes, I think it's a bug in 4xx version of disable_irq.
> 
> We have to ACK parent UIC after disabling IRQ to prevent false 
> triggering in case this IRQ was already pending during disable_irq 
> call.
> 
> Here is a patch against current 2.6, so you can get an idea what I'm 
> talking about :):

Gah, yes. Please add the sign off line and it can go in the mainline.

-Matt
