Date: Wed, 16 Jul 2003 10:50:55 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Peter Dennett <pdennett@padsoft.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: IBM PPC750L vs Motorola MPC7410
Message-ID: <20030716155055.GA31463@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <0b8e01c34ba7$41fb8490$8202a8c0@pit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0b8e01c34ba7$41fb8490$8202a8c0@pit>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 16, 2003 at 09:33:37AM -0500, Peter Dennett wrote:
> When I use the same boot image on the PPC750L
> the system hangs during the bootstrap process.
> (transfers to common routine to decompress the
> kernel, reports successful decompress, then no
> more serial output).
>
> I don't come from the PPC world and do not know
> the lineage of these chips - in fact don't know the difference
> between G3 and G4...
>
> Is there someone on this list that can be so kind as to give
> me a technical summary of the differences between the
> PPC750L (G3) and Motorola MPC7410 (G4) so far as
> LINUX operation.

I would suggest you get an architecture manual for both.  You
may be able to find a working kernel image for the 750, but
the PPC family isn't quite as nuclear as the x86 for example.
At least from a low level perspective, what works on one PPC chip
may not necessarily work on another.

If you want the simple answer, just build a kernel image that's
appropriate for your board and processor and use that.

> I assume some portions of the low level setup (cache,
> memory, serial port, ...) are different between the two
> chips.  I can ferret out and fix it, but I would rather like
> to avoid becoming a complete expert on both parts...

Cache setup is going to be different.  Some parts of memory setup,
but most SDRAM setup is done in the host bridge anyway.  The
serial port code has nothing to do with the CPU.

--Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
