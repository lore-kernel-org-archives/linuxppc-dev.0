Date: Tue, 23 Nov 1999 17:12:46 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Cort Dougan <cort@fsmlabs.com>
cc: Christian Zankel <chris@mvista.com>, linuxppc-dev@lists.linuxppc.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
In-Reply-To: <19991122165535.A13360@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.10.9911231707270.23221-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I don't think this would work in all cases, although it would be great if
> we could do it.  We can't stomp on the interrupt vectors at physical 0
> because chrp/pmac need them to do the early OF calls to setup things and
> copy the device tree before we can safely stomp on physical 0.  If the

How much of space at physical 0 do you need to leave alone? I'm thinking
about leaving a gap of some k between _start and _stext for that, and
making all boot loaders load the kernel to physical 0 (skipping the part
up to _stext), and jump to _stext. 

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
