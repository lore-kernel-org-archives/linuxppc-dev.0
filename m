Message-ID: <391A15CE.41488C9D@charter.net>
Date: Wed, 10 May 2000 21:07:10 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>,
        cort@fsmlabs.com
Subject: NO_RELOAD_HTAB
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cort (or anyone else),
can you tell me what NO_RELOAD_HTAB does in more detail?
I see it says its an optimization for the 603.  Currently
in the source that I'm using, its set to 1 (so it *is* defined).

Some of the mmu code changes depending on whether it is
defined or not, and I'm having problems with the the first
InstructionTLBMiss.  I have an MPC850SAR on a FADS board.
(Yes, I've heard all about the lowly fads...)

So, I was wondering what NO_RELOAD_HTAB is for before I go
delving into 860 & 850 mmu differences and the linux code
for them.

If anyone else is reading this, can you verify that your
linux code runs on both an 860 and 850 with no changes?

Thanks.
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
