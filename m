Message-ID: <37665FCD.68C61F58@fi.infn.it>
Date: Tue, 15 Jun 1999 16:14:37 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: How to boot VME from HD?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Gabriel,

today I tried to upgrade the system to 2.2.9 using your new patches, but
I had some problem when I tried to compile the kernel. I downloaded the
sources and then I applied the mvme2600.generic-patch-2.2.9 and
mvme2600.vme-patch-2.2.9.
At the make distclean command I get this error:
make[1]: Leaving directory `/usr/src/linux-2.2.9/arch/ppc/mbxboot'
make[1]: Entering directory `/usr/src/linux-2.2.9/arch/ppc/prepboot'
Makefile:74: .depend: No such file or directory
make[1]: *** No rule to make target `.depend'.  Stop.
make[1]: Leaving directory `/usr/src/linux-2.2.9/arch/ppc/prepboot'
make: *** [archclean] Error 2
I also copied also mvme2600.config.nfsroot as .config; make oldconfig
worked, but make dep gave me the same error:
make[1]: Entering directory `/usr/src/linux-2.2.9/arch/ppc/prepboot'
Makefile:74: .depend: No such file or directory
make[1]: *** No rule to make target `.depend'.  Stop.
make[1]: Leaving directory `
make: *** [archdep] Error 2
It seems that I'm missing the .depend file that does not have in the
/usr/src/linux-2.2.9/arch/ppc/prepboot directory, when I have it in the 
/usr/src/linux-2.2.6/arch/ppc/prepboot; can I use this last?

And just another question, more general; to install the system I started
from the rpm packages that I find in a LinuxPPC mirror site (they were a
pre-R5), but I had some problem with this "rough" installation: for
example I had to remove the Unix pty support otherwise I cannot login in
to the board using telnet. Now it seems impossible to use sockets to
communicate with other computer (a client program that is working
perfectly between two PC, o when stasted from the board, cannot connect
to the server on the board from an external computer). 

So there is a standard distribution to use for these board? or a
standard procedure to have a clean installation? And there is somewhere
an iso image for such a distribution (I would like to put everyting on a
CDrom)?

Bye (and thanks for the suggestion about the boot!) 

-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
