Date: Wed, 18 Aug 1999 18:50:42 -0500 (CDT)
From: Grant Erickson <erick205@tc.umn.edu>
To: linuxppc-dev@lists.linuxppc.org
cc: Cort Dougan <cort@cs.nmt.edu>, paulus@cs.anu.edu.au
Subject: Xmon vs. KGDB vs. KDB
In-Reply-To: <Pine.SOL.4.05.9908081802010.4056-100000@garnet.tc.umn.edu>
Message-Id: <Pine.SOL.4.05.9908181722290.24856-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am currently working with the Linux 2.2.10 kernel sources from
ftp.kernel.org and during the course of development have come to realize
that I need a kernel debugger aside from running GDB over a serial
console.

I'd seen mention of both 'XMON' and 'KGDB' from the 'make config' process;
however, from the 2.2.10 kernel sources, enabling either of these results
in a broken build because the source code to compile these just is not in
the 2.2.10 archive from ftp.kernel.org.

Did parts of XMON make the 2.2.10 cut and others did not or was this just
a build oversight?

Recently, SGI released, as a patch, KDB for i386 architectures which seems
similar in spirit to KGDB and XMON. A small chunk of KDB seems specific to
i386 and the rest is fairly architecture neutral, so perhaps it's a good
candidate for a unified debugger?

Are there any feelings with regard to the desire to strive for a unified
kernel debugger? Are any of these candidates more qualified than another?

It looks like Paul Mackerras and Cort Dougan have done most of the work on
XMON. Any opinion Paul or Cort on what direction you'd like to see things
go?

Regards,

Grant Erickson


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
