Message-Id: <v04003a01b32af0ff96d1@[205.161.35.44]>
In-Reply-To: <9904021711.AA35268@marc.watson.ibm.com>
References: Message from Holger Bettag <hobold@informatik.uni-bremen.de>  
  of "02 Apr 1999 14:11:16 +0200."
 <8x677fp6hn.fsf@s52.informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 2 Apr 1999 17:19:57 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Douglas Godfrey <dvdoug@tiac.net>
Subject: Re: Apple Job Posting and Good News for LinuxPPC developers
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Reoly to David Edelsohn, 4/2/99 12:11 PM -0500: Re: Apple Job Posting and
Good News for LinuxPPC devel
>>>>>> Holger Bettag writes:
>
>Holger> I have heard rumours that the "Max" core has provisions to
>physically address
>Holger> more than 4GB of memory (via the MMU's segment registers).
>Processes would
>Holger> still be limited to a 4GB logical address space, though.
>
>	The PowerPC architecture always has been able to address more than
>32-bits of "logical" address space.  That is the reason for the PowerPC
>terminology of "effective address", "virtual address", and "real address".
>The intermediate "virtual address" space of a 32-bit PowerPC
>implementation is 52 bits.
>
>	Pointers still are 32-bits, but a cooperating operating system and
>compiler can allow an application to address more virtual memory through
>runtime modifications to the virtual segments mapped by the segment
>registers, like memory overlays.  That was the original reason for the
>design of the MMU in the POWER (predecessor of PowerPC) architecture.  I
>do not believe that any compiler / OS combination takes advantage of this
>facility.
>
Only the IBM Mainframe and the AS/400 use windowed virtual storage to
access more than 32 bits of address with 32 bit pointers. The IBM Mainframe
can access a 44bit address range by using a 32 bit pointer as a base address
for a 4k page boundry contiguous storage segment with a window size of
up to 16meg. The old AS/400 did something similar to access it's virtual
storage mapped database while the new AS/400 just switches to the PPC 64bit
addressing mode and uses full 64bit pointers.


Thanx...
  Doug



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
