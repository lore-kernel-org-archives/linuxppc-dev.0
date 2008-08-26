Return-Path: <skepper@chara.vm.bytemark.co.uk>
Received: from chara.vm.bytemark.co.uk (chara.vm.bytemark.co.uk [80.68.89.253])
	by ozlabs.org (Postfix) with ESMTP id 1CB54DE420
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 21:18:20 +1000 (EST)
Date: Tue, 26 Aug 2008 12:17:58 +0100 (BST)
From: Chris Skepper <skepper@ukf.net>
To: Artur Barkhudaryan <Artur.Barkhudaryan@epygiarm.am>
Subject: Re: Early boot problem with MPC8247 and Linux 2.6.26
In-Reply-To: <1732780698.20080825104615@epygiarm.am>
Message-ID: <Pine.LNX.4.62.0808261117140.2935@chara.vm.bytemark.co.uk>
References: <Pine.LNX.4.62.0808221515450.31216@chara.vm.bytemark.co.uk>
	<1732780698.20080825104615@epygiarm.am>
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

>> I have a custom MPC8247 based board which has been running U-boot 1.3.5
>> and Linux 2.6.26.  It has been working fine with ARCH=ppc, but I now want
>> to make it work using ARCH=powerpc.
>
>> However, using ARCH=powerpc I have encountered a problem.  Whatever I do
>> it always appears to reset in the very early stages of booting the kernel.
>
> could this be the hardware watchdog resetting the CPU ? Do you disable
> it in u-boot ?

Thanks for the suggestion, but I've just double-checked and the watchdog 
is disabled in U-boot.  In any case, I have been using an infinite loop 
flashing an LED to trace where execution gets to, and it never resets once 
it has started doing that.

Any other ideas?

Cheers,

Chris.
