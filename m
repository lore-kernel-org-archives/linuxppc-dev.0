Message-ID: <47EE8DCFB8C6D311A23700508B8BAD5903DAF7@THEBRAIN2>
From: "Karaaslan, Utku" <UKaraasl@drs.ca>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: A Question on Physical Memory Access from Applications
Date: Wed, 8 Aug 2001 09:38:02 -0400 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,

I have ported the Linux bootloader/kernel to our home-made boards
(Motorola 860) and they have been running well up to now. However,
I have a problem: we've got a number of ADA applications which are
using direct memory access to certain hardware registers. Under
VxWorks, this is not a problem as it lacks kernelspace/userspace
separation. Under Linux, I know I can do direct memory access (through
/dev/mem), but in this case I want to use the applications as they are,
with no change to the ADA code. Is there any way to do physical memory
access transparently wrt the application? Many thanks in advance.

Regards,

Utku

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
