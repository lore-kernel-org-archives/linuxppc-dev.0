Date: Fri, 18 Jul 2003 15:37:02 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: Brian Padalino <bpadalino@perigee.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ebony and Ethernet
In-Reply-To: <DGEEIPOFGGPOACEFBGGCKEHNCAAA.bpadalino@perigee.com>
Message-ID: <Pine.LNX.4.56.0307181531030.18849@mag.devdep.sysgo.de>
References: <DGEEIPOFGGPOACEFBGGCKEHNCAAA.bpadalino@perigee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 18 Jul 2003, Brian Padalino wrote:

> I was able to create a linuxppc-2_4_devel kernel grabbed using bk
> for my Ebony board.  I am using
> arch/ppc/boot/images/zImage.initrd.ebony to boot using the board's
> bootp over ethernet, but for some reason I can't get ethernet to
> configure properly on the board.
..
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set

You don't seem to have BOOTP configured in your kernel. Is the problem
on firmware or kernel level?

I also strongly recommend to use u-boot as firmware instead of OpenBIOS.
U-Boot has a much nicer user interface and it integrates a lot smoother with
Linux.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.de>
Software Engineering

SYSGO Real-Time Solutions AG | Embedded and Real-Time Software
Am Pfaffenstein 14
55270 Klein-Winternheim, Germany

Voice: +49-6136-9948-0 | FAX: +49-6136-9948-10
www.sysgo.de | www.elinos.com | www.osek.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
