Message-ID: <3C03E2EC.5020102@humboldt.co.uk>
Date: Tue, 27 Nov 2001 19:01:00 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: VT82C686B IDE and Linux/PPC woes
References: <0111271827.AA24645@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

> Adrian Cox <adrian@humboldt.co.uk> wrote:



> P.S. When I took the pciauto_bus_scan() calls out, it saw the drive, but hung
> on the partition check. Disabling the VIA82CXXX support .config and leaving
> only the generic PCI IDE support made it really work. I guess the VIA82CXXX
> fast modes code still has issues to be worked out. Maybe it's because it
> assumes there is a BIOS and in my case there isn't one. (My minimalist firmware
> does not touch any VT82C686B IDE stuff at all, and yet if I want I can pull the
> IDE register addresses out of the BARs and see the drive there using ancient
> WD100x code.)


The driver assumes that the BIOS has correctly probed for cable types. I
believe this is because the board designer gets to choose which GPIO on
the 686B they wire the cable detection to. You'll need to check the
layout, and study that section of the 686B manual.



--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
