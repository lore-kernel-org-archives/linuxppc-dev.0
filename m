Date: Thu, 13 May 1999 08:25:31 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: compile troubles in 2.2.8
In-Reply-To: <Pine.LNX.4.04.9905131041210.12269-100000@fachschaft.cup.uni-muenchen.de>
Message-ID: <Pine.LNX.3.96.990513082304.20083A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 13 May 1999, Oliver Neukum wrote:
> Hello,
> 
> i had troubles getting 2.2.8(vanilla) to compile. It took the following
> patch. There seams to be at least one genuine bug.

I just needed to include file.h since fget is now used in sys_mmap.  Don't
know why you had problems with the ISA support.

> PS: Is there really a PPC-machine with an isa-bus?

Sure, all the PowerStacks and MTX's.  I have an ISA modem in one of our
blackhawk systems which works fine.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
