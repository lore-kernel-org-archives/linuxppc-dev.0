Return-Path: <skepper@chara.vm.bytemark.co.uk>
Received: from chara.vm.bytemark.co.uk (chara.vm.bytemark.co.uk [80.68.89.253])
	by ozlabs.org (Postfix) with ESMTP id 801F9DDF95
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 03:13:21 +1000 (EST)
Date: Tue, 26 Aug 2008 18:09:23 +0100 (BST)
From: Chris Skepper <skepper@ukf.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Early boot problem with MPC8247 and Linux 2.6.26
In-Reply-To: <20080826140324.GB3783@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.62.0808261742270.5064@chara.vm.bytemark.co.uk>
References: <Pine.LNX.4.62.0808221515450.31216@chara.vm.bytemark.co.uk>
	<48AEF220.7080506@freescale.com>
	<Pine.LNX.4.62.0808261219210.3327@chara.vm.bytemark.co.uk>
	<20080826140324.GB3783@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: Chris Skepper <skepper@chara.vm.bytemark.co.uk>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: skepper@ukf.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 26 Aug 2008, Scott Wood wrote:

> On Tue, Aug 26, 2008 at 01:00:05PM +0100, Chris Skepper wrote:
>
>> I'm triggering an LED which is connected to port A.  Are you saying that
>> wouldn't work once the caching is enabled?
>
> It's quite possible.  What other registers are in the same cache line as
> the LED, and are any of them non-memory-like?

There are some ethernet signals, a compact flash card detect, other LEDs 
and a push button also on port A.  Are those what you'd call 
non-memory-like?

> It's usually easiest to just trust that that part of the code works (in
> my experience, that's rarely where a hang actually occurs when bringing
> up a new board), and resume tracing after the MMU is on and you've
> inserted a caching-inhibited BAT entry.

Where can I find out how to do that?  Since I have this board working with 
the old ARCH=ppc, can I copy anything from there?

Also, where would be a good place in the code to resume tracing?

Thanks for your help so far.  I see now it's probably not the code for 
enabling the cache that's causing the problem, it just masks my attempts 
at tracing using the LED.

Cheers,

Chris.
