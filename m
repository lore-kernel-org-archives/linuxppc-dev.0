Date: Fri, 23 Jul 1999 19:48:31 -0600 (CST)
From: Kamran Karimi <karimi@cs.uregina.ca>
To: linuxppc-announce@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
Subject: DIPC for PowerPC
Message-ID: <Pine.SGI.3.91.990723194451.18857P-100000@MERCURY.CS.UREGINA.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

 I did a blind port of DIPC (http://wallybox.cei.net/dipc) to PowerPC
processors. Here blind means that due to the lack of equipment, I have not
done any tests, not even a kernel compile. I would be grateful if
someone of this list could test the patch, available by anonymous FTP
from orion.cs.uregina.ca /pub/dipc. More adventurous people can test the
whole system (available from the same place). The following is the readme
file accompanying the new patch.

The file dipc-patch-1.1d.gz was prepared against a 2.2.10 linux
kernel. It is based on the DIPC 1.1c kernel patch and has the following
additions:
 
 *) The port to MIPS by Ralf Baechle (not tested in a cluster)
 *) The port to SPARC (blind, not compiled on target machine)
 *) The port to PowerPC (blind, not compiled on target machine)
 *) Some memory management modifications as proposed by David Miller (This
    might have introduced bugs into DIPC's shared memory subsystem)

 The rest of the package, including the user-space dameon dipcd, some tools
and example programs, and also the documentation of DIPC, can be found in
the file dipc-1.1c.tgz.

 Please test the patch, and if possible the whole system in a cluster, and
report the results to me or to linux-dipc@wallybox.cei.net.

-Kamran Karimi

 

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
