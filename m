Date: Wed, 1 Sep 1999 10:07:05 +1000
Message-Id: <199909010007.KAA17780@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: costabel@wanadoo.fr
CC: ddkilzer@computer.org, linuxppc-dev@lists.linuxppc.org
In-reply-to: <37CBFD6B.DB0182B6@wanadoo.fr> (message from Martin Costabel on
	Tue, 31 Aug 1999 18:06:03 +0200)
Subject: Re: SMP support for Daystar 604e 200MHz dual-processor card
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <v03130301b3f116a864e2@[192.168.1.1]> <v03130300b3f1774818a8@[192.168.1.1]> <37CBFD6B.DB0182B6@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel <costabel@wanadoo.fr> wrote:

> (On the other hand, I see that Paul M. has CONFIG_SERIAL=m in his
> standard config files. Does this mean that the serial.c stuff is
> supposed to work on the PPC?)

Only with some awful hacks to disable the probing of I/O ports and to
make it start at ttyS2 instead of ttyS0.  This hack is in my rsync
trees and in the precompiled kernels I've done.  (I could post a patch
if necessary.)

It's not a good long-term solution but I needed something so I could
use the PC-card modem on my 3400. :-)

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
