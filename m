Message-Id: <9907081832.AA28950@marc.watson.ibm.com>
To: Charles Lepple <clepple@mitre.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC assembly question 
In-Reply-To: Message from Charles Lepple <clepple@mitre.org>
   of "Thu, 08 Jul 1999 13:39:17 EDT." <3784E245.8930A1B4@mitre.org>
Date: Thu, 08 Jul 1999 14:32:55 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Charles Lepple writes:

Charles> I've been poking around with some disassembled C code, and I'm wondering
Charles> if there is a source of documentation on register usage guidelines
Charles> (maybe an ABI? I'm just not used to this concept of passing arguments in
Charles> registers as opposed to the stack). Any help would be appreciated.

	All of this is defined in the appropriate ABI (AIX PowerOpen and
SVR4 PowerPC ABI).  The ABI specifies the uses of each register when
targeting code to the calling convention (argument passing, volatile and
non-volatile registers, etc.)

David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
