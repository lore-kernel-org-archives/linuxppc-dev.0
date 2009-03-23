Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id D08E2DDEEF
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 19:08:01 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LlfCR-0000WM-Dc
	for linuxppc-dev@ozlabs.org; Mon, 23 Mar 2009 01:07:59 -0700
Message-ID: <22655709.post@talk.nabble.com>
Date: Mon, 23 Mar 2009 01:07:59 -0700 (PDT)
From: rizwan ahmad <rizwanamu@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: sata device failed to IDENTIFY...
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


BM/AMCC PowerPC 440 GR Rev. B
Board: AMCC YELLOWSTONE
        VCO: 1066 MHz
        CPU: 533 MHz
        PLB: 133 MHz
        OPB: 66 MHz
        PER: 66 MHz
        PCI: 33 MHz
I2C:   ready
DRAM:  256 MB
FLASH: 32 MB
PCI:   Bus Dev VenId DevId Class Int
        00  0c  1106  3038  0c03  00
        00  0c  1106  3038  0c03  00
        00  0c  1106  3104  0c03  00
        00  0c  1106  3249  0104  0e
In:    serial
Out:   serial
Err:   serial
Net:   ppc_440x_eth0, ppc_440x_eth1
Hit any key to stop autoboot:  0
=> tftp 200000 z2
Waiting for PHY auto negotiation to complete.. done
Using ppc_440x_eth0 device
TFTP from server 192.168.0.100; our IP address is 192.168.0.101
Filename 'z2'.
Load address: 0x200000
Loading: T #################################################################
         #################################################################
         #################################################################
         ########################################################
done
Bytes transferred = 1283382 (139536 hex)
=> bootm
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.19
   Created:      2009-03-22   9:52:51 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1283318 Bytes =  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.6.19 (root@debian) (gcc version 4.2.2) #10 Sun Mar 22
02:51:52 9AMCC PowerPC 440GR Yellowstone Platform
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists.  Total pages: 65024
Kernel command line: root=/dev/nfs rw
nfsroot=192.168.0.100:/opt/eldk4.2/ppc_4xlMisrouted IRQ fixup and polling
support enabled
This may significantly impact system performance
PID hash table entries: 1024 (order: 10, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 257024k available (1940k kernel code, 668k data, 148k init, 0k
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
serial8250: ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
PPC 4xx OCP EMAC driver, version 3.54
mal0: initialized, 4 TX channels, 2 RX channels
zmii0: bridge in RMII mode
eth0: emac0, MAC 00:10:ec:00:89:89
eth0: found Generic MII PHY (0x01)
eth1: emac1, MAC 00:10:ec:80:89:89
eth1: found Generic MII PHY (0x03)
in init_module
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
sata_via 0000:00:0c.3: routed to hard irq line 9
ata1: SATA max UDMA/133 cmd 0xFFB0 ctl 0xFFBA bmdma 0xFF60 irq 25
ata2: SATA max UDMA/133 cmd 0xFFA0 ctl 0xFFAA bmdma 0xFF68 irq 25
scsi0 : sata_via
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: qc timeout (cmd 0xec)
in err_mask
becoz of exec
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
scsi1 : sata_via
ata2: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0xFFA7
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: link is up, 100 FDX, pause enabled
IP-Config: Complete:
      device=eth0, addr=192.168.0.101, mask=255.255.0.0, gw=192.168.0.100,
     host=ppc, domain=, nis-domain=(none),
     bootserver=192.168.0.100, rootserver=192.168.0.100, rootpath=
Looking up port of RPC 100003/2 on 192.168.0.100
Looking up port of RPC 100005/1 on 192.168.0.100
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 148k init
INIT: version 2.86 booting
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access
method.
Setting clock : Thu Jan  1 01:01:51 CET 1970 [  OK  ]
Building the cache [  OK  ]
Setting hostname ppc:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling /etc/fstab swaps:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
FATAL: Module ipv6 not found.
Bringing up loopback interface:  [  OK  ]
FATAL: Module ipv6 not found.
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting rpcbind: [  OK  ]
Mounting NFS filesystems:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting xinetd: [  OK  ]

DENX ELDK version 4.2 build 2008-04-01
Linux 2.6.19 on a ppc



adding irqpoll, noacpi option to the bootargs is not working.
any suggestion???
-- 
View this message in context: http://www.nabble.com/sata-device-failed-to-IDENTIFY...-tp22655709p22655709.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
