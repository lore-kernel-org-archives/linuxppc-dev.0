Message-ID: <00933BFA237CD2119B3400409543582704A2B8@MEV01>
From: Ian Abbott <abbotti@mev.co.uk>
To: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: WaitQueues.
Date: Wed, 14 Feb 2001 10:56:53 -0000
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tuesday, February 13, 2001 3:13 PM, Ralph Blach wrote:

> Is there anyway to contionally initialize a wait queue. I
> want to test a
> wait queue to see if has been initialized not initialize it.  If not,
> how do I serialize an access to a set location so that I can
> atomically
> test and increment that location?

Can't you just initialize it on driver startup or via a C initialiser
(for a statically allocated wait queue) or when you create it (for a
dynamically allocated wait queue)?

Look in <asm/atomic.h> for atomic operations.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
