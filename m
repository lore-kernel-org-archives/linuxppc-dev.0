Message-Id: <9904021711.AA35268@marc.watson.ibm.com>
To: Holger Bettag <hobold@informatik.uni-bremen.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Apple Job Posting and Good News for LinuxPPC developers 
In-Reply-To: Message from Holger Bettag <hobold@informatik.uni-bremen.de>
   of "02 Apr 1999 14:11:16 +0200." <8x677fp6hn.fsf@s52.informatik.uni-bremen.de>
Date: Fri, 02 Apr 1999 12:11:12 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Holger Bettag writes:

Holger> I have heard rumours that the "Max" core has provisions to physically address
Holger> more than 4GB of memory (via the MMU's segment registers). Processes would
Holger> still be limited to a 4GB logical address space, though.

	The PowerPC architecture always has been able to address more than
32-bits of "logical" address space.  That is the reason for the PowerPC
terminology of "effective address", "virtual address", and "real address".
The intermediate "virtual address" space of a 32-bit PowerPC
implementation is 52 bits.

	Pointers still are 32-bits, but a cooperating operating system and
compiler can allow an application to address more virtual memory through
runtime modifications to the virtual segments mapped by the segment
registers, like memory overlays.  That was the original reason for the
design of the MMU in the POWER (predecessor of PowerPC) architecture.  I
do not believe that any compiler / OS combination takes advantage of this
facility. 

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
