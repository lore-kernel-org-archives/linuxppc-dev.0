Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Elan Feingold" <elan@nxnetworks.com>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Driver question
Date: Sun, 26 Aug 2001 14:53:47 -0500
Message-ID: <NDBBLJKOJGKDOFBHNPGEGEIKCEAA.elan@nxnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Thanks to all those who helped me get my custom 860 board up and running!
My next question is about mapping some physical memory to user space.  I
have some devices with memory mapped registers.  One of them lives at
0x84000800 (above 2Gb!).  I have been trying to mmap() this into user space
memory, without success (the kernel doesn't like the >2Gb).

>From what I understand, there are usually a few options.  Usually one can
use mmap() -- although I don't know if I can -- or one can write a device
driver to work with kmalloc and friends.

What would be the easiest way to gain access to that physical memory
(non-cached, of course) from user space?  Obviously, it would be nice to map
it in at that very address in user space, but I don't think that's going to
happen.  Any tips would be greatly appreciated, as I'm new to this game.

Best regards,

-elan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
