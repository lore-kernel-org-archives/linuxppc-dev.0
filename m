Message-Id: <9903042352.AA37658@marc.watson.ibm.com>
To: Randy Gobbel <gobbel@andrew.cmu.edu>
Cc: kbhend@business.wm.edu, gdt@linuxppc.org, sbb@gnu.org,
        linuxppc-dev@lists.linuxppc.org, egcs@egcs.cygnus.com
Subject: Re: Problem with egcs and denormalized constants? 
In-Reply-To: Message from Randy Gobbel <gobbel@andrew.cmu.edu>
   of "Thu, 04 Mar 1999 17:29:52 EST." <36DF0960.404624C0@andrew.cmu.edu>
Date: Thu, 04 Mar 1999 18:52:28 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Randy Gobbel writes:

Randy> P.S.: I just said the flMin problem was an egcs bug.  It's actually an
Randy> asm bug, because the constant is correct in the .s file:

Randy> .LC8:
Randy> .float 0d1.40129846432481707092e-45

	If I understand correctly, the bug actually is in glibc.  I
presume that the GNU assembler is not receiving the correct value when it
calls upon glibc to parse the constant for it to emit into the object
file.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
