Date: Mon, 29 Apr 2002 18:02:02 -0400 (EDT)
From: brad allison <jackal@aol.net>
To: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-general@lists.terrasoftsolutions.com>
Subject: What video driver should I use?
Message-ID: <Pine.LNX.4.30.0204291754430.2830-100000@horus.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to get my r128 to go to 1600x1024 for my monitor.  I have a
blue/white G3.

When I look in /proc/pci I see I have a "Rage 128" card.

[root@isis drivers]# grep -i vga /proc/pci
    VGA compatible controller: ATI Technologies Inc Rage 128 RE (rev 0).


So I changed the Driver line in /etc/X11/XF86Config-4 to use "r128" yet
when I tried start X I got "No devices detected":


	(II) ATI: ATI driver (version 6.4.8) for chipsets: ati
	(II) R128: Driver for ATI Rage 128 chipsets: ATI Rage 128 RE (PCI),
	        ATI Rage 128 RF (AGP), ATI Rage 128 RG (AGP), ATI Rage 128 RK
	(PCI),
	        ATI Rage 128 RL (AGP), ATI Rage 128 SM (AGP),
	        ATI Rage 128 Pro PD (PCI), ATI Rage 128 Pro PF (AGP),
	        ATI Rage 128 Pro PP (PCI), ATI Rage 128 Pro PR (PCI),
	        ATI Rage 128 Pro ULTRA TF (AGP), ATI Rage 128 Pro ULTRA TL (AGP),
	        ATI Rage 128 Pro ULTRA TR (AGP), ATI Rage 128 Mobility LE (PCI),
	        ATI Rage 128 Mobility LF (AGP), ATI Rage 128 Mobility MF (AGP),
	        ATI Rage 128 Mobility ML (AGP)
	(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	        ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	        ATI Radeon VE QY (AGP), ATI Radeon VE QZ (AGP),
		        ATI Radeon Mobility LW (AGP), ATI Radeon Mobility LY (AGP),
	        ATI Radeon Mobility LZ (AGP), ATI Radeon 8500 QL (AGP),
	        ATI Radeon 8500 QN (AGP), ATI Radeon 8500 QO (AGP),
	        ATI Radeon 8500 Ql (AGP), ATI Radeon 8500 BB (AGP),
	        ATI Radeon 7500 QW (AGP)
	(WW) R128: No matching Device section for instance (BusID PCI:0:16:0) found
	(EE) No devices detected.


Yet in /proc/pci I see:

  Bus  0, device  16, function  0:
    VGA compatible controller: ATI Technologies Inc Rage 128 RE (rev 0).
      IRQ 22.
      Master Capable.  Latency=16.  Min Gnt=8.
      Prefetchable 32 bit memory at 0x84000000 [0x87ffffff].
      I/O at 0x2000 [0x20ff].
      Non-prefetchable 32 bit memory at 0x82000000 [0x82003fff].

-b

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
