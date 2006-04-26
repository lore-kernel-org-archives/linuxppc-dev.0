Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 4757B679F7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 21:47:37 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org, chandrasekhar_n@math.net
Subject: Re: Linux 2.6 sources for MPC852T processor
Date: Wed, 26 Apr 2006 13:50:04 +0200
References: <20060426025008.C8A7D773@resin02.mta.everyone.net>
In-Reply-To: <20060426025008.C8A7D773@resin02.mta.everyone.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200604261350.05295.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 26 April 2006 11:50, Chandrasekhar Nagaraj wrote:
> <DIV style="font-family:Arial,sans-serif;"><DIV>Hi,</DIV>
> <DIV>I have a customized board based on the MPC852T based processor.</DIV>
> <DIV>I intend to develop a BSP for this board.</DIV>
> <DIV>&nbsp;</DIV>
> <DIV>Does 2.6.16 from the kernel.org support this processor?</DIV>

First of all, please avoid HTML in e-mail messages. It is hard to read, and 
normally banned on mailing list such as this one.

Yes, MPC852T is supported, although I might add that I have been using 2.6.14 
and 2.6.15 sucessfully with our own MPC852T-based board, but 2.6.16 did not 
boot and as of today I don't know why, or whether this is an issue at all 
with boards other than ours.

> <DIV>&nbsp;</DIV>
> <DIV>In the 2.6.16 sources I found support for CONFIG_8xx. Does this mean
> that 852T processor is also supported?</DIV> <DIV>&nbsp;</DIV>

Yes. Look at BSP stuff for other 8xx boards to learn how to port yours. Keep 
an eye on the new platform_bus stuff, that's currently being implemented for 
different drivers and subsystmes for powerpc (this could be the reason, our 
own BSP stuff stopped working with 2.6.16, btw).
Also a transition from /arch/ppc and /arch/ppc64 towards the 
common /arch/powerpc is in progress, and therefore some things might be in a 
state of flux between released versions of the kernel. As of today (kernel 
2.6.16) the architecture you need to use is still /arch/ppc.
Good luck!

Greetings,

-- 
David Jander
