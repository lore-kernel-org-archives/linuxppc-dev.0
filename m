Message-ID: <003401bfc10f$d9cca180$d2d3470a@mike>
From: "Mike Hudson" <Exoray@isys.ca>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: BMAC+ & Full Duplex
Date: Thu, 18 May 2000 17:27:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone looked into the problem with a BMAC+ not being able to do
 full-duplex 100baseTX? I currently use BootX scripted in the MacOS,
since this allows me to use Apple's Duplexer tool to set Full-Duplex
100BaseTX.
I'd like to move to yaboot/ybin, since about half the time BootX hangs
when I need to remotely reboot.

I've looked at the BMAC/BMAC+ Driver, and some Darwin Code and
there is a register in the darwin code"

#define kTxFullDuplex   0x0200

But I'm wary to add to the code, seeing that it will probably break
compatiblity with the original BMAC (which can't do 100Mbps).
Also, I'm not sure of this will do the trick if the BMAC+ isn't advertising
 100FD, so therefore somehow one would have to access whatever
circutry handles the autonegotiation (MII layer or actual transceiver?)

FYI, I'm running a B&W G3 450 Server, 128MB, 18GB. All my PCI
slots are full (U2SCSI + two serial port boards), so I'm stuck with the
BMAC+
for my network connectivity.

Also, anyone look at implementing 'server mode' on the macs? This is a
nother reason I still use BootX, I can set server mode in MacOS first
before switching to Linux. (Sever mode is Apple's way of rebooting if A
C power lost, crucial if a UPS is used) I've done some background reasearch
on doing this with the CUDA (Power Chip on Pre-G4 desktops), and I'd love
 to discuss this with someone. Too bad this is a non-persistent software
setting,
on my PC it's nice little BIOS option which I can set and forget.

Mike Hudson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
