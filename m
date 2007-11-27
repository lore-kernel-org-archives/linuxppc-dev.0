Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 92EB1DDE18
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 00:51:00 +1100 (EST)
Date: 27 Nov 2007 06:50:51 -0700
Message-ID: <20071127135051.32227.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: 85xx software reset problems from paulus.git
References: <f87675ee0711160700m17122edcv51b55f4a0cbe38b1@mail.gmail.com>
	<473DB6DF.9010804@anagramm.de>
	<f87675ee0711161244h46c23d8byadaf1abb923b3971@mail.gmail.com>
	<f87675ee0711161328u3127de3bjdd6341cdf11cd626@mail.gmail.com>
	<0B4C1069-9D89-44E8-89F7-9E7CE07B03DF@kernel.crashing.org>
	<f87675ee0711161401k600b658ao3d6ae572fb367c47@mail.gmail.com>
	<7C2ED552-6644-4FB3-A97B-05FC3E2141FF@kernel.crashing.org>
	<f87675ee0711260941w25e5ed81v7322be1500fd5611@mail.gmail.com>
	<474B2A7F.5090607@anagramm.de>
	<2F57AC6E-EE1B-4B8D-8AB5-AAF5B2DC4C06@kernel.crashing.org>
Cc: 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> >> Yes. The symptoms in 2.6.24RC2 are that during a kernel panic or when
> >> calling 'reboot' in the shell, it just hangs. Using the same dts and
> >> resets in 2.6.23.1 reboots fine. I don't have a cds reference, but
> >> someone who does should be able to confirm whether the issue exists  
> >> or
> >> not by just attempting to reboot via bash.
> 
> Can someone do a git-bisect and find the patch that breaks things?

I'll see if I can reproduce it on my 8548cds.  If so, I'll then git-bisect.

-Dale
