Date: Sun, 25 Jul 1999 19:57:29 -0600 (CST)
From: Kamran Karimi <karimi@cs.uregina.ca>
To: Paul Mackerras <paulus@cs.anu.edu.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: DIPC for PowerPC
In-Reply-To: <199907260021.KAA01971@tango.anu.edu.au>
Message-ID: <Pine.SGI.3.91.990725195009.22777A-100000@MERCURY.CS.UREGINA.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul,

On Mon, 26 Jul 1999, Paul Mackerras wrote:

> I tried it on the weekend.  I had to make a couple of small changes to
> get the kernel to compile: asm-ppc/ipc.h didn't define DIPC, and PPC
> systems (at least the vast majority of the systems that Linux will run
> on) are 32-bit, not 64-bit.  I have appended below the diffs for
> include/asm-ppc (ipc.h and dipc.h).

 Thanks. I'll incorporate your changes ASAP. Is there a way to determine 
at kernel compile time whether the machine is 32 bit or 64 bit?
 
> I had to hack the userland stuff a bit to get it to compile, due to
> the fact that we use glibc-2.1 which doesn't define union semun.  It
> seems to work fine on one machine, but when I tried using two, dipcd
> on the second machine wasn't creating the ~dipcd/referee_backdoor
> socket which seems to be necessary.  I haven't figured out why yet.

 Please inform me of the needed changes. Do you know if the changes will 
affect the compilation of the programs in other architectures? 

 It is normal for that UNIX socket to exist only in one machine, as only one 
computer in a DIPC cluster is the referee, and the socket is created there.

 Have you tried the benchmark programs?

-Kamran

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
