Message-Id: <9904201705.AA28388@marc.watson.ibm.com>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Current egcs, binutils and kernel (fwd) 
In-Reply-To: Message from Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
   of "Tue, 20 Apr 1999 13:39:39 +0200." <Pine.LNX.4.10.9904201339320.26859-100000@mercator.cs.kuleuven.ac.be>
Date: Tue, 20 Apr 1999 13:05:21 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	The original POWER architecture with the MQ register allowed a
short sequence to provide this 64-bit functionality.  The PowerPC
instruction set does not provide the necessary building blocks, so GCC
falls back to the C implementation in libgcc2.c producing the assembly
code shown in the later posting.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
