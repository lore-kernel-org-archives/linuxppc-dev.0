Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Mark Chambers <markc@mail.com>
Reply-To: markc@mail.com
Subject: Control-C in bash ???
Date: Mon, 13 Jan 2003 14:09:00 -0500
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <200301131409.00113.markc@mail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On a PC, I can, for instance, enter "ping 192.168.1.4", then hit Control-C
and stop the ping.  For the life of me, I can't figure out how to do the
same on my MPC860 system!!!

I have an MPC860 running 2.4.19, with a mostly unmodified eldk distribution
from Wolfgang Denx.  I did modify the init script to use /dev/console instead
of /ttyx (standard driver using SMC1).  I'd not only like a solution, I want
to undertand how cancelling a shell command is supposed to work  - I've poked
around and I can't figure out what's supposed to happen - Does the shell
generate a SIGINT, or the uart driver, or what?  Any enlightenment will be
greatly appreciated...

Mark Chambers
markc@mail.com

-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
