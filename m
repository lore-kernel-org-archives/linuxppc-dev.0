Mime-Version: 1.0
Message-Id: <v04210105b3eca263e30c@[209.239.164.156]>
In-Reply-To: <l03130307b3ec7ec8030d@[192.168.10.2]>
References: <l03130307b3ec7ec8030d@[192.168.10.2]>
Date: Fri, 27 Aug 1999 13:18:55 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Peter Chang <weasel@cs.stanford.edu>
Subject: Re: Xfree86 support for Voodoo 3 acceleration
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >After looking at www.xfree86.org and the source for Xfree-3.3.4,
> >it seems that support for the Voodoo 3 card's 2-d acceleration
> >is already in Xfree86!  But, (and I'm just guessing here, I do a lot
> >of programming but none of it is system or GUI programming)
> >this support appears to run only on x86 systems currently.  There doesn't
> >appear to be any asm code or anything, though, so shouldn't it be
> >possible to port this to the linuxppc side of things?

At 11:45 -0600 08.27.1999, Stephen Edie wrote:
>Is the full source code to the driver available?  Or is it written using
>the Glide libraries?

glide is 3d only, and would probably use some sort of ioctl to talk 
to this driver to get board mappings etc. At least, this is how we 
did it on mac/w32 platforms.

Anyway, the 2d core is basically separate from 3d so this driver 
should probably 'just work'. Does anyone know if it uses the full 2d 
core, or the open spec that 3dfx was going to release?

\p

---
We all enter this world in the same way:
naked; screaming; soaked in blood.
But if you live your life right, that kind of
thing doesn't have to stop there. -- Dana Gould

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
