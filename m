Return-Path: <lists@petig-baender.de>
Received: from e.frontend.um.mediaways.net (e.frontend.um.mediaways.net
	[62.53.231.247]) by ozlabs.org (Postfix) with SMTP id 3BBB12BDF2
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Nov 2004 21:35:54 +1100 (EST)
Message-ID: <41A70567.8050000@petig-baender.de>
Date: Fri, 26 Nov 2004 11:28:55 +0100
From: Christof Petig <lists@petig-baender.de>
MIME-Version: 1.0
To: Frank Murphy <murphyf+xfree86@f-m.fm>
References: <200411232008.16854.murphyf+xfree86@f-m.fm>
In-Reply-To: <200411232008.16854.murphyf+xfree86@f-m.fm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, debian-x@lists.debian.org
Subject: Re: G3 iBook LCD brightness in X under kernel 2.4.25 and 2.6.8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Frank Murphy schrieb:
> I'm trying to migrate from a 2.4 to a 2.6 kernel, but I have one last problem 
> keeping me with 2.4.25. There's a problem with adjusting screen brightness 
> under X (4.3.0.dfsg.1-8).
> 
> I'm running pbbuttonsd 0.6.6-2 with gtkpbbuttons 0.6.4-3 (which are tools that 
> enable the LCD to be dimmed and brightened with keyboard pressed). When I'm 
> running the Debian kernel-image 2.4.25-8 and I press the brightness up or 
> down keys, I get the on-screen indication from gtkpbbuttons and the LCD dims 
> or brightens as expected in both X and on the console. However, when I boot 
> into kernel-image 2.6.8-6 or 2.6.9-1 and press the brightness keys, I get the 
> on-screen indication in X, but the LCD doesn't change brightness. However, if 
> I switch to a VT with a console, the brightness changes to what I tried to 
> change it to. Also, pressing the brightness buttons works fine when I press 
> them while in the console.
> 
> My video card is a Mach64, and I'm using the 'ati' driver for X. One guess I 
> have is that in 2.6, lots more things are built as kernel modules. I'd like 
> to try build any needed video stuff in, but I don't know what it could be. 
> Does anyone here have an idea what controls screen brightness in X?

Your mouse pointer might get some noisy spots on brightness change, ever 
noticed? I would blame the kernel first (since 2.4 works well).

> The reason this is important for me is that the LCD is not dimmed when I close 
> the lid for sleep, which kind of ruins the point of sleep.
> 
> Does anyone have an idea of what else I need to do to get screen dimming to 
> work under X with Linux 2.6?

Try to ask on the ppc-kernel list (CCed). I suspect that nobody has 
reimplemented power management for mach64 in 2.6. The fact that lid 
closing does not put the display to sleep keeps me locked in 2.4, too 
(though I experienced that 2.6 is way faster).

I played with the thought of fixing it myself (like I plan to fix DRI 
DMA some time) but was unable to allocate ressources (and enough motivation)

So take this as a "I have the problem, too" posting
    Christof
