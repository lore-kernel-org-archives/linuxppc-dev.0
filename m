Message-ID: <3DE3EF0B.F3204162@synergymicro.com>
Date: Tue, 26 Nov 2002 14:00:43 -0800
From: Dave Wilhardt <wilhardt@synergymicro.com>
Reply-To: wilhardt@synergymicro.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: MPC7455 and lwarx
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

Is anyone using the MPC745x series and performing lwarx/stwcx. in non
cached
space?  The 7410 didn't seem to care but the MPC7455 take a DSI
exception
on non cached regions.  Is there a work-around?

- Dave
--
Dave Wilhardt
Synergy Microsystems
9605 Scranton Road, Suite 700
San Diego, CA 92121
858 452-0020 x164


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
