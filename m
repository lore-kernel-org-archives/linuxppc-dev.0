Date: Thu, 12 Oct 2000 21:04:49 +0200 (MET DST)
From: Albrecht Dress <adress@mpifr-bonn.mpg.de>
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: 2.2.17pre20-ben3 + pmud-0.7-1: still kernel panic upon wakeup
Message-ID: <Pine.SOL.4.21.0010122102460.20095-100000@mpifr-bonn.mpg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I upgraded the pmud package to the latest version (pmud-0.7-1), but
unfortunately I still get a kernel panic when I try to wake up my Lombard
again (see message dump below). Does anyone have an idea what goes wrong
here? Or does anybody have a working pmud/2.2.17pre20-ben3 combination?

Thanks for any help,

Albrecht.

pmud: PMU version 11: 1999 G3 Lombard
pmud: pmud startup succeeded
pmud[1734]: running /etc/power/pwrctl maximum ac
[...]
pmud[1734]: initiating user requested sleep
pmud[1734]: running /etc/power/pwrctl sleep ac
pmud[1734]: going to sleep
kernel: media bay 0 contains a CD-ROM drive
kernel: keybdev.c: Removing keyboard: input1
kernel: ADB keyboard at 2, handler 1
kernel: Detected ADB keyboard, type ISO, swapping keys.
kernel: keybdev.c: Adding keyboard: input1
kernel: event1: Event device for input1
kernel: input1: ADB HID on ID 2:2.c4
kernel: event2: Event device for input2
kernel: input2: ADB HID on ID 7:7.1f
kernel: ADB mouse at 3, handler set to 4 (trackpad)
kernel: mouse1: PS/2 mouse device for input3
kernel: event3: Event device for input3
kernel: input3: ADB HID on ID 3:3.01
kernel: hda: Enabling MultiWord DMA 2
kernel: Unable to handle kernel NULL pointer dereference at virtual
address 00000024 (error 40000000)
kernel: NIP: C00B74C8 XER: 00000000 LR: C00B7C04 REGS: c92f1c80 TRAP: 0300
kernel: MSR: 00009032 [EEIRDRME]
kernel: TASK = c92f0000[1734] 'pmud' mm->pgd c9f91000 Last syscall: 54
kernel: last math d2366000
kernel: GPR00: C00B7C04 C92F1D30 C92F0000 C01CBD70 00000000 C014A490
00004000 C01C07F0
kernel: GPR08: 00000000 00000000 80800020 C0270A40 44000024 1001E8BC
00000000 100A3310
kernel: GPR16: 10040000 10040000 00000000 00000000 00009032 092F1E80
C01CC14C C01CBBE8
kernel: GPR24: C0190000 C01CC148 00000002 00418570 00000008 00000001
00000000 C01CBD70
kernel: Call backtrace:
kernel: C017E6D0 C00B7C04 C00E88A8 C01898F4 C00E8CA0 C003C178 C000392C
kernel: 0FF8D9A4 1000339C 10001610 0FF0B69C 00000000
kernel: Kernel panic: kernel access of bad area pc c00b74c8 lr c00b7c04
address 24 tsk pmud/1734


+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\ss                                     """"           |
| Max-Planck-Institut f\"ur Radioastronomie   |\       /      /o  o\          |
| Abteilung f\"ur Infrarot-Interferometrie    |  \    /      |  /   |         |
| Auf dem H\"ugel 69                          |    \ |        \ ---/          |
| D-53121 Bonn (Germany)          ------------+------+-------------------     |
| Phone (+49) 228 525 319                     |    / |                        |
| Fax   (+49) 228 525 411                     |  /  /                         |
| Mail  ad@mpifr-bonn.mpg.de                  |/   /                          |
| http://www.mpifr-bonn.mpg.de/div/iri                                        |
+-------------- electrical engineers do it with less resistance --------------+


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
