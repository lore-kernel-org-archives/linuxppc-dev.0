Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 8013ADE113
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 19:21:46 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LrqS7-0000Ax-LZ
	for linuxppc-dev@ozlabs.org; Thu, 09 Apr 2009 02:21:43 -0700
Message-ID: <22967294.post@talk.nabble.com>
Date: Thu, 9 Apr 2009 02:21:43 -0700 (PDT)
From: rizwan ahmad <rizwanamu@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: problem with yellowstone
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


I am using VIA VT6421 pci chipset..     
    when i am connecting my 250GB SATA drive i am getting this dump it seems
that interrupt from UIC0(interrupt 25) wich is hooked to PCI_INTA is not
getting cleared and because of this interrupt is not getting cleared it is
calling interrupt handler 100000 times and then give up.

    so please mail me if there is any way to clear the interrupt or anything
which could help.

    I IBM/AMCC PowerPC 440 GR Rev. B
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
    => tftp 200000 ij4
    Waiting for PHY auto negotiation to complete.. done
    Using ppc_440x_eth0 device
    TFTP from server 192.168.0.100; our IP address is 192.168.0.101
    Filename 'ij4'.
    Load address: 0x200000
    Loading: T
#################################################################
           
#################################################################
           
#################################################################
           
#################################################################
            ################
    done
    Bytes transferred = 1408179 (157cb3 hex)
    => bootm
    ## Booting image at 00200000 ...
      Image Name:   Linux-2.6.26.8
      Created:      2009-04-01  10:33:56 UTC
      Image Type:   PowerPC Linux Kernel Image (gzip compressed)
      Data Size:    1408115 Bytes =  1.3 MB
      Load Address: 00000000
      Entry Point:  00000000
      Verifying Checksum ... OK
      Uncompressing Kernel Image ... OK
    Linux version 2.6.26.8 (root@debian) (gcc version 4.2.2) #24 Wed Apr 1
03:32:139AMCC PowerPC 440GR Yellowstone Platform
    Zone PFN ranges:
     DMA             0 ->    65536
     Normal      65536 ->    65536
    Movable zone start PFN for each node
    early_node_map[1] active PFN ranges
       0:        0 ->    65536
    Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
65024
    Kernel command line: root=/dev/nfs rw
nfsroot=192.168.0.100:/opt/eldk4.2/ppc_4xlMisrouted IRQ fixup and polling
support enabled
    This may significantly impact system performance
    PID hash table entries: 1024 (order: 10, 4096 bytes)
    console [ttyS0] enabled
    Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
    Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
    Memory: 256768k available (2120k kernel code, 716k data, 156k init, 0k
highmem)
    Mount-cache hash table entries: 512
    net_namespace: 480 bytes
    NET: Registered protocol family 16
    PCI: Probing PCI hardware
    SCSI subsystem initialized
    NET: Registered protocol family 2
    IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
    TCP established hash table entries: 8192 (order: 4, 65536 bytes)
    TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
    TCP: Hash tables configured (established 8192 bind 8192)
    TCP reno registered
    NET: Registered protocol family 1
    msgmni has been set to 501
    io scheduler noop registered
    io scheduler anticipatory registered (default)
    io scheduler deadline registered
    io scheduler cfq registered
    Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
    serial8250: ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
    serial8250: ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
    brd: module loaded
    PPC 4xx OCP EMAC driver, version 3.54
    mal0: initialized, 4 TX channels, 2 RX channels
    zmii0: bridge in RMII mode
    eth0: emac0, MAC 00:10:ec:00:89:89
    eth0: found Generic MII PHY (0x01)
    eth1: emac1, MAC 00:10:ec:80:89:89
    eth1: found Generic MII PHY (0x03)
    Uniform Multi-Platform E-IDE driver
    ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
    ide_generic: please use "probe_mask=0x3f" module parameter for probing
all legasDriver 'sd' needs updating - please use bus_type methods
    
    sata_via 0000:00:0c.3: routed to hard irq line 9
   
    irq 25: nobody cared (try booting with the "irqpoll" option)
    Call Trace:
    [cfc21ac0] [c0008344] show_stack+0x44/0x1ac (unreliable)
    [cfc21b00] [c003ec14] __report_bad_irq+0x34/0xb8
    [cfc21b20] [c003ef20] note_interrupt+0x288/0x2f0
    [cfc21b50] [c003e1b4] __do_IRQ+0x100/0x118
    [cfc21b70] [c0006784] do_IRQ+0xbc/0xc0
    [cfc21b80] [c0001c64] ret_from_except+0x0/0x18
    [cfc21c40] [00000000] 0x0
    [cfc21c60] [c000650c] do_softirq+0x54/0x58
    [cfc21c70] [c001e97c] irq_exit+0x48/0x58
    [cfc21c80] [c0006734] do_IRQ+0x6c/0xc0
    [cfc21c90] [c0001c64] ret_from_except+0x0/0x18
    [cfc21d50] [c003e900] setup_irq+0x1c0/0x238
    [cfc21d70] [c003ea3c] request_irq+0xc4/0xd8
    [cfc21da0] [c003fe6c] devm_request_irq+0x60/0xb4
    [cfc21dd0] [c0175ac8] ata_host_activate+0x60/0x124
    [cfc21e00] [c0185384] svia_init_one+0x328/0x5ac
    [cfc21e50] [c011c17c] pci_device_probe+0x84/0xbc
    [cfc21e70] [c0137000] driver_probe_device+0xb8/0x1e8
    [cfc21e90] [c01371b4] __driver_attach+0x84/0x88
    [cfc21eb0] [c01365c0] bus_for_each_dev+0x5c/0x98
    [cfc21ee0] [c0136e08] driver_attach+0x24/0x34
    [cfc21ef0] [c0136a7c] bus_add_driver+0xb4/0x20c
    [cfc21f10] [c01373c4] driver_register+0x5c/0x158
    [cfc21f30] [c011c218] __pci_register_driver+0x40/0x50
    [cfc21f40] [c02bb910] svia_init+0x24/0x34
    [cfc21f50] [c02a61b0] kernel_init+0xa8/0x28c
    [cfc21ff0] [c0003a3c] kernel_thread+0x48/0x64
    handlers:
    [<c0183034>] (ata_sff_interrupt+0x0/0x234)
    Disabling IRQ #25
    scsi0 : sata_via
    scsi1 : sata_via
    scsi2 : sata_via
    ata1: SATA max UDMA/133 port i16@0xffb0 bmdma 0xff60 irq 25
    ata2: SATA max UDMA/133 port i16@0xffa0 bmdma 0xff68 irq 25
    ata3: PATA max UDMA/133 port i16@0xff90 bmdma 0xff70 irq 25
    ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
    ata1.00: qc timeout (cmd 0x27)
    ata1.00: failed to read native max address (err_mask=0x4)
    ata1.00: HPA support seems broken, skipping HPA handling
    ata1: failed to recover some devices, retrying in 5 secs
    ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
    ata1.00: configured for UDMA/133
    ata2: SATA link down (SStatus 0 SControl 310)
    scsi 0:0:0:0: Direct-Access     ATA      ST3250410AS      3.AA PQ: 0
ANSI: 5
    sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
    sd 0:0:0:0: [sda] Write Protect is off
    sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPAsd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
    sd 0:0:0:0: [sda] Write Protect is off
    sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPA
    ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
    ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
            res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
    ata1.00: status: { DRDY }
    ata1: hard resetting link
    ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
    ata1.00: configured for UDMA/133ata1: SATA link up 1.5 Gbps (SStatus 113
SControl 310)ata1.00: configured for UDMA/100
    ata1: EH complete
    ata1.00: limiting speed to UDMA/33:PIO4
    ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
    ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
            res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
    ata1.00: status: { DRDY }
    ata1: hard resetting link
    ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
    ata1.00: configured for UDMA/100
    ata1: EH complete
    ata1.00: limiting speed to UDMA/33:PIO4
    ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
    ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
            res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
    ata1.00: status: { DRDY }
    ata1: hard resetting link
    ata1: EH complete
    ata1.00: limiting speed to UDMA/100:PIO4
    ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
    ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
            res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
    ata1.00: status: { DRDY }
    ata1: hard resetting link
    ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
    ata1.00: configured for UDMA/33
    sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
    sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
    Descriptor sense data with sense descriptors (in hex):
           72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
           00 00 00 00
    sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
    end_request: I/O error, dev sda, sector 0
    Buffer I/O error on device sda, logical block 0
    ata1: EH complete
    ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
    ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
            res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
    ata1.00: status: { DRDY }
    ata1: hard resetting link
    ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
    ata1.00: configured for UDMA/33
    ata1: EH complete
    ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
    ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
            res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
    ata1.00: status: { DRDY }
    ata1: hard resetting link
    ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
    ata1.00: configured for UDMA/33
    sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
    sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
    Descriptor sense data with sense descriptors (in hex):
           72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
           00 00 00 00
    sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
    end_request: I/O error, dev sda, sector 0
    Buffer I/O error on device sda, logical block 0
    ata1: EH complete
     unable to read partition table
    sd 0:0:0:0: [sda] Attached SCSI disk
    TCP cubic registered
    NET: Registered protocol family 17
    RPC: Registered udp transport module.
    RPC: Registered tcp transport module.
    eth0: link is up, 100 FDX, pause enabled
    IP-Config: Complete:
        device=eth0, addr=192.168.0.101, mask=255.255.0.0, gw=192.168.0.100,
        host=ppc, domain=, nis-domain=(none),
        bootserver=192.168.0.100, rootserver=192.168.0.100, rootpath=
    Looking up port of RPC 100003/2 on 192.168.0.100
    Looking up port of RPC 100005/1 on 192.168.0.100
    VFS: Mounted root (nfs filesystem).
    Freeing unused kernel memory: 156k init
    version 2.86 
                   Welcome to DENX Embedded Linux Environment
                   Press 'I' to enter interactive startup.
    Cannot access the Hardware Clock via any known method.
    Use the --debug option to see the details of our search for an access
method.
    Setting clock : Thu Jan  1 01:07:13 CET 1970 [  OK  ]
    Building the cache [  OK  ]
    Setting hostname ppc:  [  OK  ]
    Mounting local filesystems:  [  OK  ]
    Enabling /etc/fstab swaps:  [  OK  ]
    INIT: Entering runlevel: 3
    Entering non-interactive startup
   Starting kernel logger: [  OK  ]
    Starting rpcbind: [  OK  ]
    Mounting NFS filesystems:  [  OK  ]
    Mounting other filesystems:  [  OK  ]
    Starting xinetd: [  OK  ]

    DENX ELDK version 4.2 build 2008-04-01
    Linux 2.6.26.8 on a ppc

    ppc login:


    Output of /proc/interrupts
    -bash-3.2# cat /proc/interrupts
              CPU0
     0:        177  UIC0 Level     serial
     10:       8675  UIC0 Level     MAL TX EOB
     11:      15868  UIC0 Level     MAL RX EOB
     25:     100001  UIC0 Level     sata_via
     32:          0  UIC1 Level     MAL SERR
     33:          0  UIC1 Level     MAL TX DE
     34:          0  UIC1 Level     MAL RX DE
     60:          0  UIC1 Level     EMAC
    BAD:          0
-- 
View this message in context: http://www.nabble.com/problem-with-yellowstone-tp22967294p22967294.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
