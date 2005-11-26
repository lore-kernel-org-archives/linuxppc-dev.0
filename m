Return-Path: <walt.wimer@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id E0E4C6883E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Nov 2005 16:17:23 +1100 (EST)
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
In-Reply-To: <438732FD.7090201@ru.mvista.com>
References: <20051125153126.0385ddef.ajz@cambridgebroadband.com>
	<438732FD.7090201@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 23:46:31 -0500
Message-Id: <1132980391.8000.2.camel@excalibur.timesys.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8272ADS stability issues
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Alex,

We've had increasing difficulty with our MPC8272ADS board as well.  It
will often hang or reboot while just sitting at the U-Boot prompt, or
while running Linux.  I've pretty much given up trying to use our board.
One of these days we'll get around to shipping it back to Freescale....

In a perverse sort of way, I'm glad I'm not the only one seeing this
problem, but it's unfortunate that any of us are...


Walt


On Fri, 2005-11-25 at 18:51 +0300, Vitaly Bordug wrote:
> Alex Zeffertt wrote:
> > I am using an MPC8272ADS development board.  I was wondering if
> > anybody on this list experienced hardware reliability problems with
> > this platform.
> > 
> Unfortunately, low stability occasionally follows this boards. I have
> the same symptoms, and it is relative to something wrong with memory.
