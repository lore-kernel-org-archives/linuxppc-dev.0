Date: Thu, 16 Aug 2001 10:18:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Anyone using an IBM RISCWatch ICE?
Message-ID: <20010816101834.A14201@zax>
References: <FF6CF34C346E724596A2FB5CAAB2C49750C3C1@voyager.ops.infiniswitch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FF6CF34C346E724596A2FB5CAAB2C49750C3C1@voyager.ops.infiniswitch.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 15, 2001 at 11:12:17AM -0400, Wright, David wrote:
>
> Hi,
>
> I've been attempting to use an IBM RISCWatch ICE on a Walnut system
> and I'm having problems.  (Spare me any lectures about how I should
> be using a BDI.  I'm just trying to find out how usable the IBM is,
> since it's already here.)
>
> The specific problem I'm trying to solve is this:  how do I set a
> breakpoint early in kernel startup, say at start_kernel (just as
> the MMU is enabled)?  I've tried booting the Walnut so that it
> comes up into its ROM monitor, then stopping it with the ICE, and
> setting a hardware breakpoint at the start_kernel virtual address.
> Problem is, when I start the CPU running again, the Walnut is no
> longer responding to the keyboard (serial line).  Can't do anything
> except reset it at that point.  Using the ICE reveals that the CPU
> is still running, but I have no real idea what it's doing.  It sure
> isn't responding to the serial port.

I've encountered the same problem on a Walnut here, but not reliably -
I generally find that it works for a few times, then I try another
breakpoint in just the same way and the board stops responding to
serial.  I've found that resetting the board and the processor probe
and restarting the RISCWatch software tends to help, in the sense that
it will then work again for a reasonable while.

> As an alternative, I tried setting a hardware breakpoint at the
> physical address of "start_here".  That doesn't hang, but the
> breakpoint is never hit, either.
>
> Any ideas gratefully accepted.  I've tried this kind of thing with
> a BDI and had no problems.

--
David Gibson			| Microsoft: Making the easy things hard
david@gibson.dropbear.id.au	| and the hard things buggy
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
