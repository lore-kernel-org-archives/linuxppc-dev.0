Date: Tue, 4 Feb 2003 09:08:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marcel Wattinger <marcel.wattinger@elektrobit.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Latest kernel running on EmbeddedPlanet CLLF
Message-ID: <20030204160807.GC30936@ip68-0-152-218.tc.ph.cox.net>
References: <3E3FA6EC.7744EAE3@elektrobit.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E3FA6EC.7744EAE3@elektrobit.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Feb 04, 2003 at 12:41:33PM +0100, Marcel Wattinger wrote:

> Building kernel 2.4.19 did not work at all?!? Now I've tried kernel
> 2.4.7 which
> seems to have a problem with the on-board FEC. Mounting rootfs over eth0
> works fine,
> using eth1 (FEC) stops (see below). After a few minutes I get "eth1: tx
> queue full!".
> The onboard LED's for FEC do not flash at all!

Can you define 'did not work' ?

> My questions:
> Which is the latest version combination which works for that board?
> (version gcc, version kernel)
> Do you have a hint how I get FEC running and mounting rootfs?
> Starting the 2.4.19 kernel on the CLLF hangs just after the go command
> of the cllf bootloader What could be wrong?

Did you strip off the ELF header before uploading to the board?  Or
'go'ing around it?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
