From: "Elan Feingold" <elan@nxnetworks.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: First question
Date: Fri, 27 Jul 2001 12:58:45 -0500
Message-ID: <NDBBLJKOJGKDOFBHNPGEMEFBCEAA.elan@nxnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We are trying to get Linux 2.4 booting on an EST 8260 eval board.  We are
using Limon 1.5, and we get as far as the kernel trying to decompress with
the following setup:

loaded at:     00000000 0000A27C
relocated to:  00400000 0040A27C
board data at: 001FFE00 001FFE2C
relocated to:  00200100 0020012C
zimage at:     00007000 0008B3F7
avail ram:     0040A27C 01000000

The decompression fails (e.g. "inflate() returned -3") and it seems from
looking at the numbers that we might be trying to inflate on top of the
zimage.  We haven't really tweaked any of the numbers, at least not
purposely, so we're not sure what to change.  Any advice?

Best regards,

-elan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
