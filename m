Date: Sat, 3 Aug 2002 15:58:15 -0500
From: Raymond Waldrop <rwaldrop@sbcglobal.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.19 vs Adaptec card
Message-ID: <20020803155815.A976@adsl-64-217-135-177.dsl.wchtks.swbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Howdy,

   I have a dual G4 450 (AGP graphics) with the Apple-installed Adaptec
SCSI card.  The last kernel I was able to build that works with this
card was a linuxppc_2_4 2.4.19-rc1 kernel.  Anything more recent seems
to have resource allocation problems during the boot sequence.  I have
experienced this with kernels from the linuxppc_2_4_devel and
linuxppc_2_4_benh trees as well.  The most recent messages from
a linuxppc_2_4_devel 2.4.19 kernel are:

Aug  3 11:48:56 localhost kernel: PCI: Probing PCI hardware
Aug  3 11:48:56 localhost kernel: Bridge 01:0d.0 resource 0 was deactivated by f
irmware
Aug  3 11:48:56 localhost kernel: Bridge 01:0d.0 resource 2 was deactivated by f
irmware
Aug  3 11:48:56 localhost kernel: PCI: Failed to allocate resource 0(0-ff) for 0
2:02.0
Aug  3 11:48:56 localhost kernel: PCI: Device 02:02.0 not available because of r
esource collisions

The messages from a successful boot with the linuxppc_2_4 2.4.19-rca
kernel are:

Aug  3 11:52:07 localhost kernel: PCI: Probing PCI hardware
Aug  3 11:52:07 localhost kernel: Fixup res 1 (101) of dev 00:10.0: 400 -> 80240
0
Aug  3 11:52:07 localhost kernel: Unknown bridge resource 0: assuming transparen
t
Aug  3 11:52:07 localhost kernel: Unknown bridge resource 2: assuming transparen
t
Aug  3 11:52:07 localhost kernel: PCI->OF bus map:
Aug  3 11:52:07 localhost kernel: 0 -> 0
Aug  3 11:52:08 localhost kernel: 1 -> 0
Aug  3 11:52:08 localhost kernel: 2 -> 1
Aug  3 11:52:08 localhost kernel: 3 -> 0
Aug  3 11:52:08 localhost kernel: PCI:00:10.0: Resource 0: 98000000-9fffffff (f=
1208)
Aug  3 11:52:08 localhost kernel: PCI:00:10.0: Resource 2: 90080000-900fffff (f=
200)
Aug  3 11:52:08 localhost kernel: PCI:02:07.0: Resource 0: 80000000-8007ffff (f=
200)
Aug  3 11:52:08 localhost kernel: PCI:03:0f.0: Resource 0: f5200000-f53fffff (f=
200)
Aug  3 11:52:08 localhost kernel: PCI:00:10.0: Resource 1: 00802400-008024ff (f=
101)
Aug  3 11:52:08 localhost kernel: PCI:02:02.0: Resource 1: 80083000-80083fff (f=
200)
Aug  3 11:52:08 localhost kernel: PCI:02:08.0: Resource 0: 80082000-80082fff (f=
200)
Aug  3 11:52:08 localhost kernel: PCI:02:09.0: Resource 0: 80081000-80081fff (f=
200)
Aug  3 11:52:08 localhost kernel: PCI:02:0a.0: Resource 0: 80080000-800807ff (f=
200)
Aug  3 11:52:08 localhost kernel: PCI:02:0a.0: Resource 1: 80084000-80087fff (f=
200)
Aug  3 11:52:08 localhost kernel: PCI: Enabling device 02:02.0 (0014 -> 0017)


These kernels were compiled with gcc-2.95.4.

Thanks in advance for any hints/suggestions/fixes.

Raymond

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
