Message-Id: <199901142259.QAA28915@lists.linuxppc.org>
Date: Thu, 14 Jan 1999 17:59:27 -0500 (EST)
From: "Jim Somerville" <somer@nortelnetworks.com>
Reply-To: "Jim Somerville" <somer@nortelnetworks.com>
Subject: MCP750 and CPX2000 System Scsi Woes
To: linuxppc-dev@lists.linuxppc.org
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

We've tried booting 2.2 linux on two CPX2000 systems with the same result
ie. scsi failures.  The led on the cdrom flashes while it's being tested, if
that helps anyone recognize the problem.  Has anyone out there been successful
booting the CPX2000?  It is MCP750 based compact PCI.  The console follows:

PPC1-Bug>nbo
Network Booting from: DEC21140, Controller 0, Device 0
Device Name: /pci@80000000/pci1011,9@e,0:0,0
Loading: ppc/linux/zImage.prep

Client IP Address      = 47.157.96.65
Server IP Address      = 47.157.96.39
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.240.0
Boot File Name         = ppc/linux/zImage.prep
Argument File Name     = 

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&621843, Bytes Loaded =&621843
Bytes/Second   =&310921, Elapsed Time =2 Second(s)

Residual-Data Located at: $01F78000
loaded at:     00005400 0001AFD0
relocated to:  00600000 00615BD0
board data at: 01F78000 01F7EA0C
relocated to:  0060F0C0 00615ACC
zimage at:     0000F400 0009B20A
relocated to:  01EEC000 01F77E0A
avail ram:     00400000 00600000

Linux/PPC load: console=tty0 console=ttyS0,9600n8
Uncompressing Linux...done.
Now booting the kernel
Total memory = 32MB; using 128kB for hash table (at c0180000)
Linux version 2.2.0-pre4a (minyard@crchy960.us.nortel.com) (gcc version 2.8.1) #15 Mon Jan 11 17:20:59 CST 1999
Boot arguments: 'console=tty0 console=ttyS0,9600n8'
time_init: decrementer frequency = 999938040/60 (15MHz)
Calibrating delay loop... 465.31 BogoMIPS
Memory: 30792k available (976k kernel code, 928k data, 72k init) [c0000000,c2000000]
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Swansea University Computer Society NET3.039 for Linux 2.1
NET3: Unix domain sockets 0.16 for Linux NET3.038.
Swansea University Computer Society TCP/IP for NET3.037
IP Protocols: ICMP, UDP, TCP, IGMP
Starting kswapd v 1.5 
initialize_kbd: Keyboard reset failed, no ACK
Serial driver version 4.27 with<4>Keyboard timeout[2]
Keyboard timeout[2]
 no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
ncr53c8xx: at PCI bus 0, device 16, function 0
ncr53c8xx: 53c825a detected 
ncr53c825a-0: rev=0x13, base=0x3bfffe00, io_port=0xffffe00, irq=0
ncr53c825a-0: ID 7, Fast-10, Parity Checking
ncr53c825a-0: on-chip RAM at 0x3bffe000
ncr53c825a-0: restart (scsi reset).
ncr53c825a-0: Downloading SCSI SCRIPTS.
scsi0 : ncr53c8xx - revision 3.1d
scsi : 1 host.
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
ncr53c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
