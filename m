Message-ID: <39E9F7E1.523E3693@fnc.fujitsu.com>
Date: Sun, 15 Oct 2000 14:30:57 -0400
From: Konstantin <konstantin.sabodash@fnc.fujitsu.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: mbxboot->head.S
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I try to port Kernel to custom MPC860 board.
BSEIP architecture is close to my board.
I used  pROBE   to load zvmImage on my board . ELF loader put   .text
section straight into 0x180000.
With current head.S  you lose  value of R7 which should contain zImage
length.
I fixed it  and I pass to Kernel R3 through R7 registers with valid
context.

Still, nothing  happen.  In log_buf I see that kernel  reports 0 K ( and
some negative values ) memory allocation for its buffers and pages.

The question is what else, besides R3-R7 wee need to pass to kernel  to
make it work?
I assume that MMU and  other hardware already set up.

Any idea are welcome.

Constantine.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
