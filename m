Date: Thu, 24 Apr 2003 12:33:13 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: boot/simple in ROM?
Message-ID: <20030424123313.A8490@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The boot loader thingie in arch/ppc/boot/simple is nifty.  So why
isn't there a provision for putting it on ROM?  (Or is there and I
missed it?)  Because boot/simple decompresses to RAM at 0x0, it seems
obvious that it might be decompressing from ROM.

What is the right way to do this?  (Or, pointers on how to make it
ROMable would be appreciated.)


Thanks,

-kb, the Kent who got as far as Linux booting most of the way but not
finding initrd because he has it messed up.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
