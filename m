From: Markus Froeschle <mfro@ibm.net>
Reply-To: mfro@ibm.net
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Powerbook G3 Problems
Date: Sun, 13 Feb 2000 13:17:30 +0100
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00021313182503.02707@patsch.potzblitz.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I have a (brand new) Powerbook G3 (bronze keyboard) with LinuxPPC 1999 installed
(pretty much following the instructions found at www.linuxppc.com: BootX 1.2b3
and the 'USB Lombard 2.2.12' kernel).

While everything works as desired, I have one annoying problem that I'm unable
to solve although I'm quite familiar with PPC Linux (I have a 9500 running for
years now):

Every now and then (not exactly reproducable) after a clean shutdown, the system
refuses to boot. On power up, I then just get the flashing question mark icon
indicating no boot device was found. Indeed, the disk obviously does not spin
up (silence...) and OF reports the disk as unavailable when I try to enforce
startup by "boot hd:". Resetting the PRAM does not change anything.

The first time this happened, I took the Powerbook back to the store in the
clear assumption that the disk was defect. The technican checked the system,
confirmed a broken disk and sent the system to warrenty repair.
When I received it a few days later, I was just stunned that my Linux
installation was still there and booting (obviously, they did not change the
disk).

Since then, I repeatedly see the same symptoms now and then. I have found (I
think) one way to reanimate the system: when I change the boot device in OF to
something impossible, restart once and set boot device back to hd:,\\:tbxi
(the default setting) the disk spins up eventually and the system boots
(sometimes I have to repeat this sequence several times until it works).

The problem only happens when I do a clean shutdown from Linux (and not every
time). Shutting down from MacOS (which I rarely use) did not lead to those
problems yet. I'm pretty sure its not a hardware defect.

The only reason for the problem which I can think of is that Linux changes some
hardware settings (possibly some power saving settings ?) when running which
prevent the disk from spinning up.

Has anybody seen this behaviour ?
Could somebody imagine what the Apple repair folks have done when I had the
computer "repaired" ?

Thanks for any ideas,
Markus
--

**********************************
* Markus Froeschle (mfro@ibm.net *
**********************************

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
