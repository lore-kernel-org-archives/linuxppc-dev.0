To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Apple Job Posting and Good News for LinuxPPC developers
References: <9904021711.AA35268@marc.watson.ibm.com>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 03 Apr 1999 19:42:53 +0200
In-Reply-To: David Edelsohn's message of Fri, 02 Apr 1999 12:11:12 -0500
Message-ID: <8xbth5siqq.fsf@s52.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn <dje@watson.ibm.com> writes:

> 
> >>>>> Holger Bettag writes:
> 
> Holger> I have heard rumours that the "Max" core has provisions to
> Holger> physically address more than 4GB of memory (via the MMU's segment
> Holger> registers). Processes would still be limited to a 4GB logical
> Holger> address space, though.
> 
> 	The PowerPC architecture always has been able to address more than
> 32-bits of "logical" address space.  That is the reason for the PowerPC
> terminology of "effective address", "virtual address", and "real address".
> The intermediate "virtual address" space of a 32-bit PowerPC
> implementation is 52 bits.
> 
OK, that's true in the usual PowerPC terminology.

> 	Pointers still are 32-bits, but a cooperating operating system and
                           ^^
That's what I meant with processes being limited to a 4GB logical address
space, because the segment registers are not accessible with only user mode
privileges.

> compiler can allow an application to address more virtual memory through
> runtime modifications to the virtual segments mapped by the segment
> registers, like memory overlays.  That was the original reason for the
> design of the MMU in the POWER (predecessor of PowerPC) architecture.  I
> do not believe that any compiler / OS combination takes advantage of this
> facility. 
>
Well, so far there are no 32bit PowerPCs that can handle more than 4GB of
RAM. The rumours I heard indicate that "Max" might be able to handle more.
That would make messing with segments worth the effort (and would generate
all the neat problems of segmented addressing schemes).

  Holger

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
