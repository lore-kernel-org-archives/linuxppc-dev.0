Message-ID: <3C0BD4F1.DB6591F3@seranoa.com>
Date: Mon, 03 Dec 2001 14:39:29 -0500
From: Andrew Dixon <andrew.dixon@seranoa.com>
MIME-Version: 1.0
To: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: programming ppcboot onto an sbc8260 with a vision ice
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I'm trying to put ppcboot onto my sbc8260 board using a vision ice and I
was wondering if there is a preferred way to do this?  I've compiled
ppcboot on a native gcc-2.95 with the commands:

$make sbc8260_config
$make

and I get a binary file ppcboot.bin.  When I try to program the
ppcboot.bin onto the flash it complains that the format is not
recognized as mpc8260 code.

Any ideas on what I'm doing wrong?

Thanks,
Andy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
