Subject: Journeyman configure/build options for gcc & glibc?
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Tue, 15 Aug 2000 17:37:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000815073750.58C33274@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I thought I had the whole soft-float thing on 8xx worked out long ago, until I
upgraded our root filesystem to the one from MontaVista's Journeyman kit, and
found that my glibc-2.1.3.so (which my binaries work when linked against)
doesn't work in place of the Journeyman glibc-2.1.2.so.  It's the usual
symptom: A simple floating-point printf gives the wrong answer.

So, my question: what configure options were used to build the gcc-2.95.2 &
glibc-2.1.2 in Journeyman?  In particular:

- Did the gcc configure include "-with-cpu=860" (or one of the other cpus's
  to make -msoft-float the default).

- Has the gcc specs file been hacked to pass -D_SOFT_FLOAT in the absence of
  -mhard-float (note that -mcpu=860 won't do this by default in gcc-2.95.2)

- Was CFLAGS set to include -msoft-float before building glibc?

- Any other suggestions :-(

Thanks!
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
