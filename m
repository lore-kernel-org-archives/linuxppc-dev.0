Message-ID: <36DF0960.404624C0@andrew.cmu.edu>
Date: Thu, 04 Mar 1999 17:29:52 -0500
From: Randy Gobbel <gobbel@andrew.cmu.edu>
MIME-Version: 1.0
To: kbhend@business.wm.edu
CC: gdt@linuxppc.org, sbb@gnu.org, linuxppc-dev@lists.linuxppc.org,
        egcs@egcs.cygnus.com
Subject: Re: Problem with egcs and denormalized constants?
References: <36DEBCB0.7A98EB80@business.wm.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


P.S.: I just said the flMin problem was an egcs bug.  It's actually an
asm bug, because the constant is correct in the .s file:

.LC8:
	.float 0d1.40129846432481707092e-45

-Randy
-- 
http://www.cnbc.cmu.edu/~gobbel/
PGP fingerprint: 32 8A E8 24 A1 46 26 BC  F9 9D 0E B6 81 A9 02 0C

NOTICE: I DO NOT ACCEPT UNSOLICITED COMMERCIAL EMAIL MESSAGES OF ANY
KIND.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
