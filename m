Message-ID: <383BBD40.E79582B4@switchboard.ericsson.se>
Date: Wed, 24 Nov 1999 11:26:08 +0100
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: LiuTao <tliu@ict.ac.cn>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: need suggestions
References: <3839F122.3BF6FEDF@ict.ac.cn> <383A0E2D.CFACF894@jlc.net> <383A0E2E.9A261E81@ict.ac.cn> <383A30B7.37700779@jlc.net> <383BA2FD.E894EC61@ict.ac.cn>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



> I have a ADS8xx board and I downloaded kernel source mpc8xx-2.2.13.tgz
> from ppc.kernel.org. Can you tell me how to port it to ADS8xx board and
> make a bootrom of Linux?
> I am a newbie, so please tell something in detail.

First of all: Check the revision of the board and the cpu.
If you have a 860, find a cpu with revision C or later.
If you have a ADS with rev. ENG, PILOT or A you will have some trouble.

I have had linux up and running on a ADS board.
A good starting point is to read the manual and check what differs from the FADS. 

I have bootcode that is based on fadsrom by Dan Malek.
It is kind of a mess right now, but it should support both 
the ADS and the FADS board using 860(t).
It loads a zImage or vmlinux from a ATA-FLASH or the onboard flash-simm.
It understands ext2 and dos.
No network support, though.

I can mail the source to anyone who is interested.
You will need a linux source tree and a (cross)compiler.

But I have no time for answers.

Good luck /

magnus damm

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
