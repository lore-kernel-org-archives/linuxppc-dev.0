Date: Wed, 26 Nov 2003 13:48:14 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Felix Domke <tmbinc@elitedvb.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 Critical Interrupts
Message-ID: <20031126134814.A9704@home.com>
References: <3FC4D4B5.2030901@elitedvb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FC4D4B5.2030901@elitedvb.net>; from tmbinc@elitedvb.net on Wed, Nov 26, 2003 at 05:28:37PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Nov 26, 2003 at 05:28:37PM +0100, Felix Domke wrote:
> I thought about routing the CriticalInterrupt pretty much the same way
> as the HardwareInterrupt, but with disabling MSR_CE. MSR_CE would be
> enabled then even in (normal) interrupts, we probably have to add a
> __crit_cli and __save_and_crit_cli as someone already suggested.
>
> Does CRIT_EXCEPTION work? Is do_IRQ reentrant? Should i use the same
> interrupt processing as a normal hardware interrupt, with the exception
> that only "critical"-flagged interrupts are processed?
>
> Any suggestions?

You could backport the critical exception handling code from 2.6.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
