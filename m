From: duncanp@research.canon.com.au
Date: Wed, 26 Apr 2000 19:29:52 +1000 (EST)
Subject: flash drivers
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Message-Id: <20000426082939.EC8373C960@elph.research.canon.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi all,

I'm about to go and write some software to allow us to program on-board
flash devices. I'm planing on putting all of the code in a kernel
driver - i've seen some flash drivers which put some code in the
kernel, and other code (to write the flash - I gather the algorithms
vary a fair bit between deivices) in user space.

So, before I go and do this, has anyone already done something similar
they would be happy to share with me?

I'd like to write this so it can be dropped into the standard kernels
and adapted to new 8xx based boards without much effort, so if anybody
has any comments they'd like to make, please lemme know.

Cheers,
Dunk.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
