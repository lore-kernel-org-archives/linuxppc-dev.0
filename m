Date: Thu, 6 Dec 2001 18:42:31 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: HIGHMEM + serial console + SMP + 2GB freeze on pmac
Message-ID: <20011206184231.C23942@altus.drgw.net>
References: <20011206180754.A23942@altus.drgw.net> <20011206182524.B23942@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011206182524.B23942@altus.drgw.net>; from hozer@drgw.net on Thu, Dec 06, 2001 at 06:25:24PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 06, 2001 at 06:25:24PM -0600, Troy Benjegerdes wrote:
>
> > I'm going to try several other combinations of things, including taking
> > one memory stick out since this could actually be that the hardware
> > doesn't like that much memory.
>
> There is at least one problem with serial console on pmac.. I removed the
> memory (except for 1 512mb dimm)
>
>
> If I turn serial console on, I get a machine check in
> serial_console_write during the PCI probing.
>
> This only shows up if Xmon is NOT compiled in.. since xmon tries to use
> the port (and presumably dies also)

Another note: The serial works fine after the machine is booted up.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
