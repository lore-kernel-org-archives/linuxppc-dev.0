Message-Id: <9908200311.AA40852@marc.watson.ibm.com>
To: Bob Doyle <doyle@primenet.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Extended Asm 
In-Reply-To: Message from Bob Doyle <doyle@primenet.com>
   of "Fri, 20 Aug 1999 03:01:29 -0000." <37BCC509.6D857E7F@primenet.com>
Date: Thu, 19 Aug 1999 23:11:25 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	The basic syntax of GCC extended asm statements is identical on
all platforms.  The details are the syntax of instructions for a
particular architecture and assembler, and the GCC constraint letter for
the arguments that get substituted into the assembly language.  The
constraint letters specific to PowerPC are listed in the GCC manual in the
Machine Description -- Constraints -- Machine Constraints section under
IBM RS6000.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
