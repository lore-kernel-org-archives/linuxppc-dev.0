Message-ID: <40EA6940.7000705@246tNt.com>
Date: Tue, 06 Jul 2004 10:56:32 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Question about PCI subsystem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

After documenting myself about PCI, I still have some unanswered
questions :

 - The bootloader either don't initialize allocate resources for PCI
or allocate them at a different address than me. So at boot I see
"warnings" that linux could not allocate the resources, then it resets
them and allocate them Ok. Is there a way to tell linux that he
doesn't have to try to keep the current mapping and that he can remap
all the devices ? (I mean change their BAR )

 - The mpc5200 sees itself on the PCI bus, and it's BAR defines two
regions : One for IO that maps to the config registers. And one that
maps to the SDRAM. The problem is that I can define the size of those
( fixed in hardware ) and the SDRAM region is fixed to 1Gb ... So when
linux tries to allocates resources for it it can't and display an
error. It works but it's not pretty to see the error at boot. Is there
a way to tell linux not to try to allocate resource for itself ? Can
this have impact during master write by other devices ?


Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
