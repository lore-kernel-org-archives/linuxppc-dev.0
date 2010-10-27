Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2FF55B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Oct 2010 00:27:39 +1100 (EST)
Subject: Re: Pegasos OHCI bug (was Re: PROBLEM: memory corrupting bug,
	bisected to 6dda9d55)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: pacman@kosh.dhis.org
In-Reply-To: <20101027085738.1837.qmail@kosh.dhis.org>
References: <20101027085738.1837.qmail@kosh.dhis.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Oct 2010 00:27:24 +1100
Message-ID: <1288186044.2236.25.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Since then, the silence has been deafening.
> 
> My assumption now is that this is not ever getting fixed. I'm certainly not
> able to fix it. I'm not a even kernel programmer! I got far enough to
> diagnose the cause just with the "add more printk's and boot it again"
> technique. Hundreds of reboots trying to figure it out. I was a conscientious
> bug-reporter, I thought.

I'm happy to help you fix it but I'm travelling at the moment and won't
have much time for a couple of weeks.

Cheers,
Ben.

> I could pull the PCI card and be done with it. I never used those USB ports
> anyway. But after all the suffering I went through to find this bug... the
> crashing e2fsck's and consequent filesystem corruption... I hate the idea of
> surrendering to it. There are possibly other affected users who I'd be
> abandoning to suffer similarly in the future.
> 
> For the last week I've studied OpenFirmware as hard as I can. I read the spec
> cover to cover. And the USB annex, and the PCI annex. But I'm still lost in
> all the different address formats.
> 
> I took my best guess on how to handle this problem, and ran with it, ending
> up with a 97-line Forth script, and that was just to get a virtual address,
> not to actually do anything with it, and it used a hardcoded device path. But
> it didn't work, all I got was an "invalid pointer" error. I made another
> guess at something that wasn't documented anywhere (the fact that this stuff
> is insufficiently documented is the one thing I can state with complete
> confidence!) and out came a successful translation to a virtual address: 0.
> 
> If I'm the only one fighting this bug, the bug wins.
> 
