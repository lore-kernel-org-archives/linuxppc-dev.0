Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C6C368732
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 09:27:55 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122145.38409.mbuesch@freenet.de>
	<Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Sun, 13 Nov 2005 09:24:14 +1100
Message-Id: <1131834254.7406.43.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Buesch <mbuesch@freenet.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-11-12 at 13:00 -0800, Linus Torvalds wrote:
> 
> On Sat, 12 Nov 2005, Michael Buesch wrote:
> > 
> > Latest GIT tree does not boot on my G4 PowerBook.
> 
> What happens if you do
> 
> 	make ARCH=powerpc
> 
> and build everything that way (including the "config" phase)?
> 
> So far ppc32 is still a valid architecture, and your config file makes it 
> clear that you've used that. But I suspect most of the active testing has 
> been done with the "powerpc" architecture compiled for 32-bit.
> 
> That said, the ppc32 tree should still work. BenH? Paul?

Ìt should still work. I'm running -rc1 with "powerpc" on mine so that at
least works, it's possible that we broke "ppc", I'll have a look and
send a fix.

Ben.
