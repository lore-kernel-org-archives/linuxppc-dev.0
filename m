Message-Id: <199905200007.RAA07219@soda.CSUA.Berkeley.EDU>
To: minyard@acm.org
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and egcs developer releases 
In-Reply-To: Your message of "19 May 1999 14:56:56 CDT."
             <m2d7zwrfxz.fsf@wf-rch.cirr.com>
Date: Wed, 19 May 1999 17:07:36 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 
> Is anyone tracking the egcs developer releases on LinuxPPC?  I'm
> trying to build the newest developer release (19990517) and I have
> tried to build earlier ones, but they all get a SEGV compiling
> SYSCALLS.c with the stage1 compiler.  This is on linux 2.1.127 with
> the egcs-1.02 prerelease compiler.
 
I built the snapshot from 1990512 without any problems on LinuxPPC
R4.1. The c compiler appears to work correctly (built a kernel with
it), but the java compiler has problems with classes that use
java.net.*.

----ranga <ranga@soda.berkeley.edu>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
