Message-ID: <C08678384BE7D311B4D70004ACA3710511194632@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'markc@mail.com'" <markc@mail.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Control-C in bash ???
Date: Mon, 13 Jan 2003 12:16:25 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This may sound silly, but:

One little gotcha that I ran into was that control-C was being
grabbed by the terminal emulator on my PC.  You might try
control-backslash & see if that works.  If so, perhaps modify
the emulator's terminal settings.


-----Original Message-----
From: Mark Chambers [mailto:markc@mail.com]
Sent: Monday, January 13, 2003 12:09 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Control-C in bash ???



On a PC, I can, for instance, enter "ping 192.168.1.4", then hit Control-C
and stop the ping.  For the life of me, I can't figure out how to do the
same on my MPC860 system!!!

I have an MPC860 running 2.4.19, with a mostly unmodified eldk distribution
from Wolfgang Denx.  I did modify the init script to use /dev/console
instead
of /ttyx (standard driver using SMC1).  I'd not only like a solution, I want
to undertand how cancelling a shell command is supposed to work  - I've
poked
around and I can't figure out what's supposed to happen - Does the shell
generate a SIGINT, or the uart driver, or what?  Any enlightenment will be
greatly appreciated...

Mark Chambers
markc@mail.com

-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
