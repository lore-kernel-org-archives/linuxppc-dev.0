Message-Id: <199904211245.OAA03567@kieraycl01.kieraydom>
Date: Wed, 21 Apr 1999 14:45:38 +0200 (MET DST)
From: Magnus Damm <eramdam@kieray1.p.y.ki.era.ericsson.se>
Reply-To: Magnus Damm <eramdam@kieray1.p.y.ki.era.ericsson.se>
Subject: FADS860
To: tharvan@ellemedia.com
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi there!

Has someone _ever_ run linux on a FADS860 with success?

I've exchanged some mail with Helmut <helmut.buchsbaum@siemens.at> 
and he has linux running on a FADS823.

I have the same problem as Thomas <tharvan@ellemedia.com> with my board.
Even with Helmuts workaround that resevers one tlb as #31.

I mean, what is the difference between the MBX and the FADS?
Except all crap around the processor - nothing.
It is the same processor with yes, i know, diffrent pinusage.
 
I suspect the MBX boot does something with the MMU at boot-time. 

It seems like the FADS is the only board with homebuilt boot-code.

The boot-code for the brightstar boards, is it open source?

What is going on when the memoryarea 0x300-0x1200 (ISRs) is trashed?

Is someone at least a bit worried ?

TIA /

Magnus


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
