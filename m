Message-ID: <007e01c1a994$3a7e1540$74b0f8cb@bluecafe>
From: "ChangYl Lee" <bluecafe@sgi21.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Debugging start_here: on IBM405GP
Date: Wed, 30 Jan 2002 22:44:24 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all.
I'm using IBM405GP(not walnut, custom board) and linux-2.4.18-pre7 from BK Tree.
And I made bootloader myself and use it.

Attempting to debug, I can't see my debug character at "start_here:" (arch/ppc/kernel/head_4xx.S) and It seems to hang.
I have ported linux-2.4.2_hhl20 to my board and it now runs well.
But I don't know why new version of kernel doesn't work in my board.
Is anybody knows the reason?
Any help is greatly appreciated.

PS:
1) In my humble opinion, there are no board specific dependency before "start_here:".
So I think that any 405GP should runs well at "start_here:". Am I wrong?

2) is any dependency to processor revision? revision of my processor is E.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
