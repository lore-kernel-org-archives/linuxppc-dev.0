Date: Thu, 14 Oct 1999 15:25:10 -0700 (PDT)
From: Brad Midgley <brad@turbolinux.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: dgatwood@mvista.com, bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: multihead (Re: ADB probing)
In-Reply-To: <199910111228.OAA06049@simul.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.9910141515380.15598-100000@web1.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > How does all this discussion fit in with the work being done on the input
> > system which will allow multiple independent keyboards, etc.?
> Huh? What work is being done there? Kernel level or user space? 

it's happening in the kernel because it would be impossible to work around
the kernel's "one keyboard, one active console" assumptions.

http://www.suse.cz/development/input/

but i see there isn't any work on ppc-specific devices.

the ggi project group has kernel changes along the same lines (kgi). they
also have little participation from ppc developers.

the first effort is more likely to get in an official kernel, but not
in time for 2.4.

Brad
brad@pht.com | http://www.pht.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
