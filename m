Date: Wed, 7 Apr 1999 10:27:40 -0700 (PDT)
Message-Id: <199904071727.KAA07766@saul1.u.washington.edu>
From: a sun <asun@saul1.u.washington.edu>
To: jskov@cygnus.co.uk
CC: linuxppc-dev@lists.linuxppc.org, roy@centricsystems.ca,
        marsmail@globegate.utm.edu, djweis@plconline.com, bh40@calva.net
In-reply-to: <ooyak4ikj4.fsf@lassi.cygnus.co.uk> (message from Jesper Skov on
	07 Apr 1999 15:15:42 +0100)
Subject: Re: Resurrecting mkLinux
References: <199904070826.BAA23922@saul9.u.washington.edu> <ooyak4ikj4.fsf@lassi.cygnus.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



   My top priority is to get away from having an Amiga directory under
   arch/ppc (or arch/ppc/mach_m68k). I would prefer to move all mach
   drivers into a new mach hierarchy (so there would be e.g. mach/amiga
   in the root of the kernel sources just as we now have arch/m68k).

yep. actually, we probably should call it "machine" as that has less
of a chance of getting confused with the mach microkernel given that
arch/mach has the possibility to show up in 2.3.x as well.

   Also, the files that do not look like that are so because Jes (m68k
   maintainer) didn't like '#ifdef __powerpc__' or CONFIG_APUS in
   arch/m68k specific files... Which I agree with (kind of). With the
   mach hierarchy, though, both arguments becomes moot and I'll fix up
   the sources to my liking ;)

heh. luckily, most of the nubus stuff can be done by adding more
gestalt values. hmm, i do have wonderful things like #ifdef
__powerpc__ in the via_write/via_read code to do deal with memory
barriers and such.

-a

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
