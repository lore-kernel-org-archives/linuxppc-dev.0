Date: Mon, 15 Jan 2001 08:15:17 +0000
Subject: bk 2.4.1pre2 Lombard PCI allocation fails.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010115081732.43695DB9FD@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

as the title says...
The machine boots and (seems) OK.

FWIW: I boot this machine with BootX [1.2.2] (and always have, without
problem, until this time).

relevant DMESG below.
ciao,
Iain.

========

Linux version 2.4.1-pre2 (iain-s@athena) (gcc version 2.95.2 19991024
(release/franzo)) #1 Mon Jan 15 05:27:33 GMT 2001
Registered 1 feature controller(s)
PMU driver initialized for 1999 PowerBook G3
Found Grackle (MPC106) PCI host bridge at 0x80000000. Firmware bus number:
0->0
[...]
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Fixup mem res, dev: 0.e, res_start: 80882000->80882000
Fixup mem res, dev: 0.10, res_start: 80800000->80800000
Fixup mem res, dev: 0.11, res_start: 81000000->81000000
Fixup mem res, dev: 0.11, res_start: 81fff000->81fff000
Fixup mem res, dev: 0.13, res_start: 80880000->80880000
PCI: Resource 80882000-80882fff (f=200, d=0, p=0)
PCI: Resource 00000c00-00000cff (f=101, d=0, p=0)
PCI: Resource 80800000-8087ffff (f=200, d=0, p=0)
PCI: Resource 81000000-81ffffff (f=200, d=0, p=0)
PCI: Resource 81fff000-81ffffff (f=200, d=0, p=0)
PCI: Cannot allocate resource region 2 of device 00:11.0
PCI: Resource 80880000-80880fff (f=200, d=0, p=0)
PCI: Resource 00000c00-00000cff (f=101, d=1, p=1)
PCI: Cannot allocate resource region 1 of device 00:11.0
  got res[10000000:10000fff] for resource 2 of ATI Technologies Inc 3D Rage
LT Pro
Registered "pmu" backlight controller, level: 1/15
======

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
