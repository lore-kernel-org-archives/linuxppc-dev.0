Date: Wed, 13 Jan 1999 20:09:07 -0800 (PST)
Message-Id: <199901140409.UAA08871@saul7.u.washington.edu>
From: a sun <asun@saul7.u.washington.edu>
To: marsmail@globegate.utm.edu
CC: linuxppc-dev@lists.linuxppc.org, bh40@calva.net
In-reply-to: <Pine.LNX.3.96.990113132556.9506A-100000@globegate.utm.edu>
	(marsmail@globegate.utm.edu)
Subject: Re: Porting to NuBus PowerMacs
References: <Pine.LNX.3.96.990113132556.9506A-100000@globegate.utm.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   Actually, on looking at it, there is the use of memory barriers.  The real
   change is in the code for the memory barriers (and possibly in other
   places, too... not certain).  See 

   .../osfmk/src/mach_kernel/ppc/proc_reg.h:440

   in the MkLinux sources.  :-)

oh my. i hadn't noticed that. thanks for pointing it out to me. i
guess a plain eieio() is sometimes not good enough... no doubt, the
designers of certain unmentionable devices were being directed by some
cosmic purpose that we, the uninitiated, can only vaguely envision and
hope to understand.

luckily, my trusty g3 upgrade card handily curtails my pursuit into
the ineffable nature of such visionaries. i guess i'll have to add a
CONFIG_601 to deal with certain "third-party" devices though. that
way, we can have just as much fun as the other architectures with
processor-specific tweaks.

-a
asun@u.washington.edu


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
