Date: Wed, 19 May 1999 22:15:35 -0400 (EDT)
From: Anirudh Joshi <ajoshi@Glue.umd.edu>
To: Corey Minyard <minyard@acm.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and egcs developer releases
In-Reply-To: <m2d7zwrfxz.fsf@wf-rch.cirr.com>
Message-ID: <Pine.GSO.3.95q.990519221354.10496A-100000@y.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



	this is a bug in binutils, get an early snapshot of binutils and
you should be fine:

linuxppc.slackers.cx/pub/rawhide/ppc/RedHat/RPMS/binutils-2.9.1.0.990418-1c.ppc.rpm



ani



On 19 May 1999, Corey Minyard wrote:

> 
> Is anyone tracking the egcs developer releases on LinuxPPC?  I'm
> trying to build the newest developer release (19990517) and I have
> tried to build earlier ones, but they all get a SEGV compiling
> SYSCALLS.c with the stage1 compiler.  This is on linux 2.1.127 with
> the egcs-1.02 prerelease compiler.
> 
> Thanks,
> 
> -- 
> Corey Minyard                   Internet:  minyard@acm.org
>   Work: minyard@nortelnetworks.com  UUCP:  minyard@wf-rch.cirr.com
> 
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
