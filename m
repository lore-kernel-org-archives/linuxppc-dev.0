Message-ID: <3C06B4E3.8000203@humboldt.co.uk>
Date: Thu, 29 Nov 2001 22:21:23 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: mod+linuxppc-dev@MissionCriticalLinux.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_init_hwif_ports
References: <200111292142.QAA30752@missioncriticallinux.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


mod+linuxppc-dev@MissionCriticalLinux.com wrote:


> Not to quibble with your painfully accurate
> description of the VT82C686B, but might it be
> possible (using the IDE Interrupt Routing register
> at offset 0x4a in function 1) to arrange for both
> channels to use the same interrupt routing?
> Like force both to IRQ14?  Just a thought...


Tried that on my 686A board. As far as I can tell that register does
nothing at all, and the physical wiring on the board is the only thing
that influences the interrupts. I think that register may  be useful on
an i386 with IO-APIC, but I'm not sure.

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
