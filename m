Date: Mon, 5 Apr 1999 18:11:14 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Apple Job Posting and Good News for LinuxPPC developers
In-Reply-To: <8xbth5siqq.fsf@s52.informatik.uni-bremen.de>
Message-ID: <Pine.HPP.3.96.990405180816.1043O-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On 3 Apr 1999, Holger Bettag wrote:

> > compiler can allow an application to address more virtual memory through
> > runtime modifications to the virtual segments mapped by the segment
> > registers, like memory overlays.  That was the original reason for the
> > design of the MMU in the POWER (predecessor of PowerPC) architecture.  I
> > do not believe that any compiler / OS combination takes advantage of this
> > facility. 
> >
> Well, so far there are no 32bit PowerPCs that can handle more than 4GB of
> RAM. The rumours I heard indicate that "Max" might be able to handle more.
> That would make messing with segments worth the effort (and would generate
> all the neat problems of segmented addressing schemes).

There is no reasonable way a 32 bit PPC will handle more than 4Gb of
physical RAM. However, with relatively simple patches, Linux could handle
4 Gb per process virtual address space and 3 Gb physical RAM on a 32 bit
PPC.

	Gabriel.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
