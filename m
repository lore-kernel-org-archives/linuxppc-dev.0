Message-Id: <200111262204.RAA20995@missioncriticallinux.com>
From: mod+linuxppc-embedded@MissionCriticalLinux.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: VT82C686B IDE and Linux/PPC woes 
In-Reply-To: Your message of "Mon, 26 Nov 1901 13:26:00 PST."
             <0111262126.AA22174@ivan.Harhan.ORG>
Date: Mon, 26 Nov 2001 17:04:51 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 26 Nov 1901 13:26:00 PST msokolov wrote:
>Has anyone here other than us with the Adirondack ever designed
>a PPC board with a VT82C686B south bridge and put Linux/PPC on
>it?  If anyone has done this, what magic did you do for the IDE?


I'd also be interested in responses to that question
since the PPC box I'm porting to has that same VIA
south bridge chip in it and I can't figure out how
to access the IDE command/status registers therein.

It's infuriating since it's clear that a lot of
the pieces are working: I can read/write all the
Config registers (all seven functions worth) and I
have the RS232 controller running and the interrupt
controller routing interrupts, etc, etc.  But the
IDE command/status registers just seem to contain
junk and the driver consequently gives up on it...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
