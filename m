Message-ID: <36E93596.A055D7BB@mitre.org>
Date: Fri, 12 Mar 1999 10:41:10 -0500
From: Charles Lepple <clepple@mitre.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: sync problem in arch/ppc/kernel/misc.S?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone have any recollection of writing the comment "some chip revs
have problems here..." in arch/ppc/kernel/misc.S? It's in the
enable_interrupts subroutine, and on a DY4 603e board, I do seem to have
problems :-) It doesn't seem to be getting past this sync instruction,
and I'm a little confused as to why not. Anyone with insights into this?
(FWIW, the PVR is 0x60400, implying that it's not the 2.5V core chip...)

Thanks,

Charles Lepple
clepple@mitre.org

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
