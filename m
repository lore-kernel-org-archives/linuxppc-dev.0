Date: Sat, 7 Aug 1999 17:57:13 -0600 (CST)
From: Kamran Karimi <karimi@cs.uregina.ca>
To: linuxppc-announce@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
Subject: Distributed Programming under Linux/PowerPC
Message-ID: <Pine.SGI.3.91.990807173836.12629A-100000@MERCURY.CS.UREGINA.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

 People interested in distributed programming are invited to try DIPC 
(Distributed Inter-Process Communication). It allows you to transparently 
use System V IPC's semaphores, messages and shared memories over a 
network of computers. Its Transparent Distributed Shared Memory (DSM) 
puts it in a different class from other systems like PVM or MPI. Using DIPC, 
you can easily write distributed program even if you have only one machine. 
The same code can later be used in a real cluster, or a multi-processor, 
without any changes.

 DIPC has been tested under Linux/PowerPC by Hugo Delchini and Paul 
Mackerras. You can download the file dipc-2.0-pre3.tgz from 
orion.cs.uregina.ca /pub/dipc (It also patches i386, Alpha, MIPS and 
SPARC code in the kernel). Please try it and let me know the positive 
and negative results. 

 Recommendations and wish lists for the final package are welcome. 

Kamran

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
