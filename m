Message-ID: <3816E6FD.481FA27D@263.net>
Date: Wed, 27 Oct 1999 19:50:21 +0800
From: Wang Yong <wung_y@263.net>
Reply-To: wung_y@263.net
MIME-Version: 1.0
To: linux-ppc <linuxppc-dev@lists.linuxppc.org>
CC: linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: What's MMU context?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


as the source code of linuxPPC, there is a global variable named 
next_mmu_context which is increased by one at each time of create a new
process. what does this mean and what is mmu context? it appears there
is not any mmu context in i386.

Wang


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
