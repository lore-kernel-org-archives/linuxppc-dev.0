Message-Id: <200009222036.QAA26082@mal-ach.watson.ibm.com>
To: Ryan T Boder <rboder@grn.georet.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC simulator 
In-Reply-To: Message from Ryan T Boder <rboder@grn.georet.net>
   of "Thu, 21 Sep 2000 21:33:34 EDT." <39CAB6ED.B7D4A3E0@mail.georet.net>
Date: Fri, 22 Sep 2000 16:36:38 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Ryan T Boder writes:

Ryan> What's available to use for playing with assembly language on my G4? I
Ryan> am familiar with MIPS and IA/32 but not PowerPC. Is there a simulator
Ryan> for LinuxPPC? I have used SPIM on Solaris before but that's about it.

	PSIM, written by Andrew Cagney, is distributed with GDB.  A number
of architecture simulators are distributed in the gdb "sim" subdirectory.

	There also is a PowerPC version of Stanford's SimOS simulator
developed by IBM's Austin Research Lab which we are working to get
released.

David
===============================================================================
David Edelsohn                                      T.J. Watson Research Center
dje@watson.ibm.com                                  P.O. Box 218
+1 914 945 4364 (TL 862)                            Yorktown Heights, NY 10598

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
