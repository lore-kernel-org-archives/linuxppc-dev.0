From: v.sudeep@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E578602B6D6DF@ap-bang-m02.india.tek.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCI daughter card with USB on a 405GP
Date: Mon, 23 Feb 2004 08:11:23 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3FA27.AE8EFF20"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3FA27.AE8EFF20
Content-Type: text/plain;
	charset="iso-8859-1"

Hi Everyone !!!

I am finding it a bit difficult to overcome a problem related to the PCI
daughter card with USB on my 405GP IBM Walnut board. If anyone can help me,
I would be greatful to them.

My problem is as follows....
I want to install a USB printer on my 405GP board. Unfortunately the 405GP
does not have a USB port. So I am trying to use a PCI daughter card with
USB. I tried using two different cards  - OPTi 82c861 and ALi M5273. In both
cases it seems to have some problems in booting up. i.e when the kernel is
probing the pci bus, some errors seem to happen. I snooped the kernel code
and identified as to when the error is being thrown out but am not sure what
exactly is wrong and how I can set it right.

This error occurs in :
	file 	- ./drivers/pci/setup-res.c
	function - pci_assign_bus_resource
	line 	- if ((res->flags ^ r->flags) & type_mask)
			continue;

This results in a kernel panic.  I am not sure of how I could go around this
problem. Any suggestions on how to get the USB card up will be greatly
appreciated.

And thanks in advance.


Note:

1.	Our setup over here is as follows:
		Host Machine : Intel x86 having Red Hat 9 installed
		Target Board : IBM Walnut board - 405GP with PowerPC
processor
		Cross-Compiler: MonteVista Hard Hat Linux 2.0  for the
ibm-walnut board

2. 	Also attaching a file containing all the messages that the kernel
pattered out.

 <<booting-up-messages>>

- S u d e e p    V
Don't change horses in mid stream.




 <<booting-up.messages>>

------_=_NextPart_000_01C3FA27.AE8EFF20
Content-Type: application/octet-stream;
	name="booting-up-messages"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="booting-up-messages"

Entry point at 0x400000 ...=0A=
----------  progress:  0x200 id mach(): done=0A=
Linux version 2.4.2_hhl20 (root@cosmos) (gcc version 2.95.3 20010315 =
(release/MontaVista)) #34=0A=
----------  progress:  0x3eab setup_arch: enter=0A=
----------  progress:  0x3eab setup_arch: bootmem=0A=
----------  progress:  0x3eab arch: exit=0A=
On node 0 totalpages: 8192=0A=
zone(0): 8192 pages.=0A=
zone(1): 0 pages.=0A=
zone(2): 0 pages.=0A=
Kernel command line: =0A=
Calibrating delay loop... 199.47 BogoMIPS=0A=
Memory: 30420k available (1124k kernel code, 440k data, 176k init, 0k =
highmem)=0A=
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)=0A=
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)=0A=
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)=0A=
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)=0A=
POSIX conformance testing by UNIFIX=0A=
PCI: Probing PCI hardware=0A=
PCI:pci_assign_resource: type_mask must match<3>PCI: Error while =
updating region 00:04.0/0 (1)=0A=
----------  progress:  0xffff              =0A=
Linux NET4.0 for Linux 2.4=0A=
Based upon Swansea University Computer Society NET3.039=0A=
Starting kswapd v1.8=0A=
pty: 256 Unix98 ptys configured=0A=
block: queued sectors max/low 20117kB/6705kB, 64 slots per queue=0A=
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 =
blocksize=0A=
phy speed read failed =0A=
phy duplex read failed =0A=
<5>eth0: PPC405 EMAC 10 Mbs Half duplex MAC 00:04:ac:e3:10:92=0A=
loop: loaded (max 8 devices)=0A=
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI enabled=0A=
ttyS00 at 0x0000 (irq =3D 0) is a 16550A=0A=
ttyS01 at 0x0000 (irq =3D 1) is a 16550A=0A=
PPP generic driver version 2.4.1=0A=
usb.c: registered new driver usbdevfs=0A=
usb.c: registered new driver hub=0A=
PCI: Enabling device 00:04.0 (0000 -> 0002)=0A=
usb-ohci.c: USB OHCI at membase 0xc3000000, IRQ 31=0A=
usb-ohci.c: usb-00:04.0, OPTi Inc. 82C861=0A=
Machine Check: PLB0        bear=3D 0x10000004 acr=3D   0x00000000 =
besr=3D  0x0c000000=0A=
Machine Check: PLB0 to OPB bear=3D 0x02000020 besr0=3D 0x00000000 =
besr1=3D 0x00000000=0A=
Data Machine Check in kernel mode.=0A=
Oops: machine check, sig: 7=0A=
NIP: C00C5598 XER: 20000000 LR: C016C518 SP: C0279DF0 REGS: c0279d30 =
TRAP: 0200=0A=
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
TASK =3D c0278000[1] 'swapper' Last syscall: 120 =0A=
last math 00000000 last altivec 00000000=0A=
PLB0: bear=3D 0x02000020 acr=3D   0x00000000 besr=3D  0x0c000000=0A=
PLB0 to OPB: bear=3D 0x10000004 besr0=3D 0x00000000 besr1=3D =
0x00000000=0A=
=0A=
GPR00: 00000000 C0279DF0 C0278000 C02EA000 00001030 00000000 C02EE908 =
00000000 =0A=
GPR08: C02EE040 EEC00000 C01C0000 C3000000 84000022 30000000 000C0804 =
00000000 =0A=
GPR16: 00000000 FFFE21AD 00000000 00000000 00001032 00279D20 00000000 =
C0002980 =0A=
GPR24: 00000000 0000001E 0000001F C02EA000 C0270400 C3000000 00000032 =
C02EA000 =0A=
Call backtrace: =0A=
C00B5280 C016C518 C016C708 C00B47F0 C00B4884 C016C750 C0161810 =0A=
C01618B4 C00024F8 C0005064 =0A=
Kernel panic: Attempted to kill init!=0A=
Rebooting in 180 seconds..=0A=
=0A=

------_=_NextPart_000_01C3FA27.AE8EFF20
Content-Type: application/octet-stream;
	name="booting-up.messages"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="booting-up.messages"

Entry point at 0x400000 ...=0A=
----------  progress:  0x200 id mach(): done=0A=
Linux version 2.4.2_hhl20 (root@cosmos) (gcc version 2.95.3 20010315 =
(release/MontaVista)) #34=0A=
----------  progress:  0x3eab setup_arch: enter=0A=
----------  progress:  0x3eab setup_arch: bootmem=0A=
----------  progress:  0x3eab arch: exit=0A=
On node 0 totalpages: 8192=0A=
zone(0): 8192 pages.=0A=
zone(1): 0 pages.=0A=
zone(2): 0 pages.=0A=
Kernel command line: =0A=
Calibrating delay loop... 199.47 BogoMIPS=0A=
Memory: 30420k available (1124k kernel code, 440k data, 176k init, 0k =
highmem)=0A=
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)=0A=
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)=0A=
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)=0A=
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)=0A=
POSIX conformance testing by UNIFIX=0A=
PCI: Probing PCI hardware=0A=
PCI:pci_assign_resource: type_mask must match<3>PCI: Error while =
updating region 00:04.0/0 (1)=0A=
----------  progress:  0xffff              =0A=
Linux NET4.0 for Linux 2.4=0A=
Based upon Swansea University Computer Society NET3.039=0A=
Starting kswapd v1.8=0A=
pty: 256 Unix98 ptys configured=0A=
block: queued sectors max/low 20117kB/6705kB, 64 slots per queue=0A=
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 =
blocksize=0A=
phy speed read failed =0A=
phy duplex read failed =0A=
<5>eth0: PPC405 EMAC 10 Mbs Half duplex MAC 00:04:ac:e3:10:92=0A=
loop: loaded (max 8 devices)=0A=
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI enabled=0A=
ttyS00 at 0x0000 (irq =3D 0) is a 16550A=0A=
ttyS01 at 0x0000 (irq =3D 1) is a 16550A=0A=
PPP generic driver version 2.4.1=0A=
usb.c: registered new driver usbdevfs=0A=
usb.c: registered new driver hub=0A=
PCI: Enabling device 00:04.0 (0000 -> 0002)=0A=
usb-ohci.c: USB OHCI at membase 0xc3000000, IRQ 31=0A=
usb-ohci.c: usb-00:04.0, OPTi Inc. 82C861=0A=
Machine Check: PLB0        bear=3D 0x10000004 acr=3D   0x00000000 =
besr=3D  0x0c000000=0A=
Machine Check: PLB0 to OPB bear=3D 0x02000020 besr0=3D 0x00000000 =
besr1=3D 0x00000000=0A=
Data Machine Check in kernel mode.=0A=
Oops: machine check, sig: 7=0A=
NIP: C00C5598 XER: 20000000 LR: C016C518 SP: C0279DF0 REGS: c0279d30 =
TRAP: 0200=0A=
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
TASK =3D c0278000[1] 'swapper' Last syscall: 120 =0A=
last math 00000000 last altivec 00000000=0A=
PLB0: bear=3D 0x02000020 acr=3D   0x00000000 besr=3D  0x0c000000=0A=
PLB0 to OPB: bear=3D 0x10000004 besr0=3D 0x00000000 besr1=3D =
0x00000000=0A=
=0A=
GPR00: 00000000 C0279DF0 C0278000 C02EA000 00001030 00000000 C02EE908 =
00000000 =0A=
GPR08: C02EE040 EEC00000 C01C0000 C3000000 84000022 30000000 000C0804 =
00000000 =0A=
GPR16: 00000000 FFFE21AD 00000000 00000000 00001032 00279D20 00000000 =
C0002980 =0A=
GPR24: 00000000 0000001E 0000001F C02EA000 C0270400 C3000000 00000032 =
C02EA000 =0A=
Call backtrace: =0A=
C00B5280 C016C518 C016C708 C00B47F0 C00B4884 C016C750 C0161810 =0A=
C01618B4 C00024F8 C0005064 =0A=
Kernel panic: Attempted to kill init!=0A=
Rebooting in 180 seconds..=0A=
=0A=

------_=_NextPart_000_01C3FA27.AE8EFF20--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
