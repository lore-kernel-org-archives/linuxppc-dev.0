Message-ID: <A0899AFEE588D411A4930008C7094B990F7E62@postoffice2.teltronics.com>
From: Tom Miles <tmiles@teltronics.com>
To: "'Daniel Furse'" <daniel.furse@iptest.com>
Cc: "'Linux Embedded List (E-mail)'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Embedded planet CLLF boards
Date: Thu, 5 Oct 2000 11:30:13 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

I have recently gone through the same exercise as you.  We obtained a CLLF
860T board and got the Hardhat Linux CDK from Montavista
http://www.mvista.com.  I had Linux booting via TFTP in pretty short order.
However, as you've already discovered Embedded Planet boards are not
reference designs (i.e. they will not release schematics, etc. for any
price).  They would rather sell you lots of their little boards.

We've subsequently decided to go to the 8260 instead of the 860.  Have
recently obtained a SBC8260 board which is a reference design from EST (now
Windriver HSI).  I'm just getting started with it, but Montavista CDK has
support for this board as well.

Good luck with your efforts.

Tom Miles, Staff Engineer
Teltronics, Inc.
4275 Kellway Circle, Suite 166
Addison, TX 75001-4213
214-346-2216
tmiles@teltronics.com
http://www.teltronics.com




-----Original Message-----
From: Daniel Furse [mailto:daniel.furse@iptest.com]
Sent: Thursday, October 05, 2000 3:47 AM
To: Linux Embedded List (E-mail)
Subject: Embedded planet CLLF boards



Hi all,

I am currently assessing the options for a real-time embedded linux
controller, based on a PowerPC 860T chip.

Initially, we purchased a FADS860T boards, but we had little success
with this target. Can anyone recommend an 860T-based board, which has
both a fast ethernet and a PCMCIA interface? So far, the board that gets
closest to this spec is the embedded planet CLLF board. However, this is
a production-ready board, and we are looking to design our own product
once we have proven the technology can do the task.

Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
