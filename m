Date: Mon, 28 Feb 2000 21:15:52 -0600 (CST)
From: Kumar Gala <kumar@chaos.ph.utexas.edu>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: AltiVec enabled GCC
Message-ID: <Pine.LNX.4.10.10002282113300.24552-100000@chaos.ph.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For all of you out there waiting to get your hands on an AltiVec enabled
GCC it is now available.  Check out http://www.altivec.org/ (Tools
Section).  There is source and patches available for binutils, gdb, gcc.
These patches are due to the wonderful work of Tom Wood, and others at
Motorola.

While Motorola is working on getting them signed over the the FSF, the
quality of the GCC patches has something to be desired.  Tom's work was
more a proof of concept/get things working rather then anything else.
Therefor, the GCC patches are going to require a rework on someone's part
to get them added to the mainline gcc tree.

However, these patches have build working Linux Kernel's as well as many
other applications.  There are still some quarks to take care of.  I am
starting a site on sourceforge.net for Open Source/AltiVec related
projects.  When I get it to a point of useability I will let people know.

- kumar gala

ignorance is bliss.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
