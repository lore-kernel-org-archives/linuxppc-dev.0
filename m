Message-Id: <s83c1bbf.061@a-hgwd3.harwell.aeat.co.uk>
Date: Wed, 24 Nov 1999 17:09:09 +0000
From: "Frank Smith" <frank.smith@aeat.co.uk>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: All
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All

Forgive me as a mostly silent interested party...

Please believe me their are people out here desperately wanting Linux on PPC MVME cards.
Our problems are that we cannot necessarily afford to input to ports etc but even on such 
relatively luxurious cards space and speed can and will be a problem.  We have code which 
when running native takes up most of a card with 32 M Byte RAM and must run in less then 20 ms.

If you don't do it we will be stuck with Motorola some time next century and I gave up on one
of their OSes before we started with Lynx OS which is now driving us *!?%*! mad! 

Good Luck

Frank

>>> Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se> 24/11/99 10:26:08 >>>


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

***********************************************************************
This transmission contains information which may be confidential and  
which may also be privileged.  It is intended for the named addressee  
only.  Unless you are the named addressee, or authorised to receive it 
on behalf of the addressee you may not copy or use it, or disclose it 
to anyone else.  If you have received this transmission in error please 
contact the sender.  Thank you for your cooperation. 
***********************************************************************

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
