Date: Thu, 10 Jun 1999 13:13:51 -0500 (CDT)
From: Joseph Palani Garcia <jpgarcia@execpc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: EM86 port for LinuxPPC?
Message-ID: <Pine.GSO.3.95.990610130308.9290A-100000@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Some may have noticed the EM86 x86 "emulator" for alpha/linux to run
x86/linux binaries.  I recently added the define to my kernel compile and
it compiled the binary support (the em86 program gets help from the
kernel, so theres a kernel define in the alpha kernel config).  Anyway,
I downloaded all the source from digital's site, and tried compiling it.
It all compiled fine except for one thing, the thing i am doubious about.
a source file that is only about 25 lines of assembly.  What i think it
does is reroute the syscalls to the friend in the kernel.  It seems to me
that because of this, it may be bound to the alpha architecure.  Is there
a way to port this to ppc?  or is there just too many dissimilarities
between alpha and ppc archs?  ( i haven't tried doing it yet because i
don't know if its worth the time in learning alpha and ppc assm/arch just
to get x86/linux bins to run... or im just lazy)

Thanks.

--

Joseph Garcia
Madison, WI
jpgarcia@execpc.com


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
