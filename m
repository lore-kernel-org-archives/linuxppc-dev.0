Message-ID: <01C0691A.F7322A20@NB1>
From: torsten.rissel@t-online.de (Torsten Rissel)
To: "'Gabriel Paubert'" <paubert@iram.es>, Matt Porter <mporter@mvista.com>
Cc: "Linuxppc-Embedded (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: MVME 5100
Date: Mon, 18 Dec 2000 17:50:09 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-----Ursprungliche Nachricht-----
Von:	Gabriel Paubert [SMTP:paubert@iram.es]
Gesendet am:	Montag, 18. Dezember 2000 16:35
An:	Matt Porter
Cc:	Torsten Rissel; Linuxppc-Embedded (E-Mail)
Betreff:	Re: MVME 5100


On the MVME2400 (and older Raven/Falcon based boards) the config space by
default is at 0x80000cf8 and 0x8000cfc. Does it mean that on the MVME5100,
the Hawk is reprogrammed by PPCBUG to look like a CHRP system ?

	Regards,
	Gabriel.

[Torsten Rissel]  As I said, this is my first adventure in the wonderful world of PowerPC's,
but you can judge yourself by a listing of the residual data, as passed over by PPCBUG:

PPC6-Bug>nbo
Network Booting from: I82559, Controller 0, Device 0
Device Name: /pci@fe000000/pci8086,1209@e,0:0,0
Loading: /tftpboot/zImage

Client IP Address      = 192.168.169.2
Server IP Address      = 192.168.169.1
Gateway IP Address     = 192.168.169.1
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = /tftpboot/zImage
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&684130, Bytes Loaded =&684130
Bytes/Second   =&684130, Elapsed Time =1 Second(s)

Residual-Data Located at: $03F9077C
loaded at:     00005400 0001C220
relocated to:  00800000 00816E20
board data at: 03F9077C 03F97188
relocated to:  00810314 00816D20
zimage at:     00010400 000AA3BF
relocated to:  00817000 008B0FBF
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/nfs ip=192.168.169.2:192.168.169.1:192.168.169.1:255.255.255.0:mvme5100:eth0
Uncompressing Linux...done.
Now booting the kernel
PReP architecture
Total memory = 64MB; using 256kB for hash table (at c01c0000)
Linux version 2.2.18pre23 (root@linux) (gcc version 2.95.2 19991024 (release)) #319 Mon Dec 18 17:34:25 CET 2000
Boot arguments: console=ttyS0,9600 console=tty0 root=/dev/nfs ip=192.168.169.2:192.168.169.1:192.168.169.1:255.255.255.0:mvme5100:eth0
Residual: 13 devices
ProcBus Device, Bus 0, BUID 0:  IBM000A, MemoryController, RAM, GeneralRAM
  No packets describing possible resources.
  No packets describing compatible resources.
ProcBus Device, Bus 0, BUID 0:  IBM0007, SystemPeripheral, L2Cache, StoreInEnabled
  Packets describing allocated resources:
    0 K CopyBack DirectMapped L2 cache, 32/32 bytes line/sector size
  No packets describing possible resources.
  No packets describing compatible resources.
ProcBus Device, Bus 0, BUID 0:  PNP0A03, BridgeController, PCIBridge, PCIBridgeIndirect
  Packets describing allocated resources:
    I/O address (16 bits), at 0xcf8 size 0x8 bytes
    Chip identification: MOT3131
    PCI Bridge parameters
      ConfigBaseAddress fe000cf8
      ConfigBaseData fe000cfc
      Bus number 0
      PCI Slot 1 DevFunc 0x80 interrupt line(s) A/B/C/D routed to MPIC line(s) 9(L)/10(L)/11(L)/12(L)
      PCI Slot 2 DevFunc 0x88 interrupt line(s) A/B/C/D routed to MPIC line(s) 12(L)/9(L)/10(L)/11(L)
      Integrated PCI device DevFunc 0x68 interrupt line(s) A/B/C/D routed to MPIC line(s) 5(L)/6(L)/7(L)/8(L)
    Bus speed 33333036 Hz, 2 slot(s)
    Bridge address translation, positive decoding:
      Processor  Bus        Size       Conversion Translation
      0x80000000 0x80000000 0x3d000000 Bus Memory direct
    Bridge address translation, positive decoding:
      Processor  Bus        Size       Conversion Translation
      0xfe000000 0x00000000 0x00010000 Bus I/O direct
    Bridge address translation, positive decoding:
      Processor  Bus        Size       Conversion Translation
      0xfe010000 0x00800000 0x007f0000 Bus I/O direct
    Bridge address translation, positive decoding:
      Processor  Bus        Size       Conversion Translation
      0x00000000 0x00000000 0x80000000 DMA direct
  No packets describing possible resources.
  No packets describing compatible resources.
PCI Device, Bus 0, DevFunc 0x0: IBM000D, SystemPeripheral, ProgrammableInterruptController, MPIC
  Packets describing allocated resources:
    Memory address (32 bits), at 0xf3f80000 size 0x40000 bytes
  No packets describing possible resources.
  No packets describing compatible resources.
PCI Device, Bus 0, DevFunc 0x68: MOT3101, BridgeController, VMEBridge, GeneralVMEBridge
  Packets describing allocated resources:
    Chip identification: MOT3101
    Bus speed 33333036 Hz, 255 slot(s)
  No packets describing possible resources.
  No packets describing compatible resources.
PCI Device, Bus 0, DevFunc 0x70: DPI8086, NetworkInterfaceController, EthernetController, GeneralEther
  No packets describing allocated resources.
  No packets describing possible resources.
  No packets describing compatible resources.
PCI Device, Bus 0, DevFunc 0x98: DPI8086, NetworkInterfaceController, EthernetController, GeneralEther
  No packets describing allocated resources.
  No packets describing possible resources.
  No packets describing compatible resources.
ProcBus Device, Bus 0, BUID 0:  MOT3F00, SystemPeripheral, SystemPlanar, GeneralSystemPlanar
  Packets describing allocated resources:
    Chip identification: MOT3F0E
  No packets describing possible resources.
  No packets describing compatible resources.
ISA Device, Slot 0, LogicalDev 0: IBM0008, SystemPeripheral, NVRAM, IndirectNVRAM
  Packets describing allocated resources:
    Variable (16 decoded bits) I/O port
      from 0x80c8 to 0x80c8, alignment 1, 2 ports
    Variable (16 decoded bits) I/O port
      from 0x80d8 to 0x80d8, alignment 1, 1 ports
  No packets describing possible resources.
  No packets describing compatible resources.
ISA Device, Slot 0, LogicalDev 0: PNP0B00, SystemPeripheral, RealTimeClock, interface 129
  Packets describing allocated resources:
    Variable (16 decoded bits) I/O port
      from 0x80c8 to 0x80c8, alignment 1, 2 ports
    Variable (16 decoded bits) I/O port
      from 0x80d8 to 0x80d8, alignment 1, 1 ports
    Chip identification: MOT3040
    Small vendor item type 0x00, data (hex): 01 f8 1f 00 00
  No packets describing possible resources.
  No packets describing compatible resources.
ProcBus Device, Bus 0, BUID 0:  IBM000B, SystemPeripheral, OperatorPanel, interface 129
  Packets describing allocated resources:
    System address (32 bits), at 0xfe0008c0 size 0x2 bytes
    Chip identification: MOT3000
  No packets describing possible resources.
  No packets describing compatible resources.
ISA Device, Slot 0, LogicalDev 0: PNP0501, CommunicationsDevice, RS232Device, NS398SerPort
  Packets describing allocated resources:
    IRQ Mask 0x0010, high edge sensitive
    I/O address (11 bits), at 0x3f8 size 0x8 bytes
  Packets describing possible resources:
    IRQ Mask 0x0010, high edge sensitive
    I/O address (11 bits), at 0x3f8 size 0x8 bytes
    IRQ Mask 0x0008, high edge sensitive
    I/O address (11 bits), at 0x2f8 size 0x8 bytes
    IRQ Mask 0x0010, high edge sensitive
    I/O address (11 bits), at 0x220 size 0x8 bytes
    IRQ Mask 0x0010, high edge sensitive
    I/O address (11 bits), at 0x2e8 size 0x8 bytes
    IRQ Mask 0x0010, high edge sensitive
    I/O address (11 bits), at 0x338 size 0x8 bytes
    IRQ Mask 0x0010, high edge sensitive
    I/O address (11 bits), at 0x3e8 size 0x8 bytes
    IRQ Mask 0x0008, high edge sensitive
    I/O address (11 bits), at 0x2e8 size 0x8 bytes
    IRQ Mask 0x0008, high edge sensitive
    I/O address (11 bits), at 0x238 size 0x8 bytes
    IRQ Mask 0x0008, high edge sensitive
    I/O address (11 bits), at 0x2e0 size 0x8 bytes
    IRQ Mask 0x0008, high edge sensitive
    I/O address (11 bits), at 0x228 size 0x8 bytes
  No packets describing compatible resources.
ISA Device, Slot 0, LogicalDev 0: IBM000B, SystemPeripheral, OperatorPanel, interface 131
  Packets describing allocated resources:
    IRQ Mask 0x0100, low edge sensitive
    Chip identification: MOT3001
  No packets describing possible resources.
  No packets describing compatible resources.
OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at f3f80000
OpenPIC timer frequency is 4166640 Hz
time_init: decrementer frequency = 1044544800/60 (16MHz)
Memory: 62828k available (1076k kernel code, 1564k data, 68k init) [c0000000,c4000000]
Dentry hash table entries: 8192 (order 4, 64k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 65536 bhash 65536)
Starting kswapd v 1.5
Serial driver version 4.27 with no serial options enabled
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
scsi : 0 hosts.
scsi : detected total.
Found Intel i82557 PCI Speedo at I/O 0x77efc0, IRQ 0.
  PCI latency timer (CFLT) is 0x80.
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
eth0: Intel PCI EtherExpress Pro100 82559ER, 00:01:AF:01:7A:1D, I/O at 0x77efc0, IRQ 0.
  Board assembly 000000-000, Physical connectors present:
  Primary interface chip None PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x1d68d8db).
  Receiver lock-up workaround activated.
Found Intel i82557 PCI Speedo at I/O 0x77ef80, IRQ 0.
  PCI latency timer (CFLT) is 0x80.
eth1: Intel PCI EtherExpress Pro100 82559ER, 00:01:AF:01:7A:1E, I/O at 0x77ef80, IRQ 0.
  Board assembly 000000-000, Physical connectors present:
  Primary interface chip None PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x1d68d8db).
  Receiver lock-up workaround activated.
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
IP-Config: Complete:
     if=eth0, addr=192.168.169.2, mask=255.255.255.0, gw=192.168.169.1,
     host=mvme5100, domain=, nis-domain=(none),
     bootserver=192.168.169.1, rootserver=192.168.169.1, rootpath=
Looking up port of RPC 100003/2 on 192.168.169.1
neighbour table overflow

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
