Subject: Re: On-Chip-Debugging for MPC 860 ?
To: dan@netx4.com (Dan Malek)
Date: Tue, 29 Feb 2000 16:45:21 +1100 (EST)
Cc: greyham@research.canon.com.au (Graham Stoney),
        Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de (Tobias Otto-Adamczak),
        linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <38A75E46.B89491B8@netx4.com> from "Dan Malek" at Feb 13, 2000 08:45:42 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000229054521.6C2385064E@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Graham Stoney wrote:
> > GDB support for PowerPC BDM under Linux isn't yet available.....

Dan Malek writes:
> The HMI BMDs for 8xx/5xx/4xx series work just fine with GDB on any
> host platform.  There are many others supported as well, just
> take a look at all of the remote-* devices in the GDB sources.

Which remote device do the HMI BMDs interface to?  I can't see any mention
of them in the latest gdb snapshots on sourceware.  The only remote- device
I can see which supports PowerPC BDM is the Macraigor one in ppc-bdm.c. This
uses ocd.c, which which relies on Macraigor's WIGGLERS.DLL and hence will
only run under Windows. I'm getting desperate though, so if anyone knows of a
pre-built gdb which supports the Macraigor Raven, please let me know, even if
it only does runs under Windoze.

Thanks,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
