Message-ID: <3975B697.63313411@ccrl.mot.com>
Date: Wed, 19 Jul 2000 09:09:27 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: clark@esteem.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Do I shoot myself in the foot first or HEAD.S?
References: <1.5.4.32.20000719011945.006845c0@pop.esteem.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


clark@esteem.com wrote:

>
> 4. Has any one managed to get an EST VisionICE in circuit emulator to work
> with linuxPPc? If so How? Would I be better off using the GNU Debuger?
>

We did use EST's VisionICE box to download linux kernel images to our target
hardware before we had a rom monitor with network loading. It was also helpful
to debug the early boot stuff when we were porting to custom hardware - before
the memory management is enabled. Once the memory manager is enabled, the
VisionICE becomes mostly useless, because as has been said many times on this
list - most BDM debuggers don't understand virtual addresses. Nevertheless the
VisionICE did offer some utility to us.
I wrote a little app that slaps an EST .bin file header on a linux image
(zvmlinux or zvmlinux.inird). I can send that to you if you want it. Then I use
Download to Target from VisionClick and that sticks the whole image in RAM. You
do need to disable VisionICE's interception of software breakpoint emulation
interrupts - do 'cf sbe special'. That should be it.

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
