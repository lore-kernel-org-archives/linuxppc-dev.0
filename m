Message-ID: <3E2911AE.4090602@sjtu.edu.cn>
Date: Sat, 18 Jan 2003 16:34:54 +0800
From: Laudney Ren <bren@sjtu.edu.cn>
Reply-To: laudney@acm.org
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: MCR question
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all:

  From MPC860 User Manual, MCR has a field named "OP". when its value is
10, the operation is "RUN". The description for "RUN" in the manual is:

"... the AMX bits of the UPM RAM word in this software initiatede
pattern must all be set to 0b11. Thus, the address for this pattern is
the value written to MAR. The data bus is not driven."

My question is, what does the "pattern" mean? What's its use? What is
the "address for the pattern"? Is this address a RAM address and the
pattern will be read from this location? What is MAR for?

Thanks.

Laudney Ren

--
An expert is one who knows more and more about less and less
until he knows absolutely everything about nothing.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
