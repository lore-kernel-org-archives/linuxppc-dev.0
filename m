Message-ID: <3714B863.5904DEE7@brightstareng.com>
Date: Wed, 14 Apr 1999 11:46:43 -0400
From: Stuart Adams <sja@brightstareng.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: TLB miss rate on MPC823/850 processors ???
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


With only 8 instruction TLB's and 8 data TLB's isn't the MPC823/850
going to spend an excesive amount servicing TLB faults ???
(With a 4K page size you only have access to 64K of memory without
 faulting)

Simply typing "cat /proc/ppc_htab" successively on the console shows
900-2000 misses just for execting that cat command.

-- Stuart

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
