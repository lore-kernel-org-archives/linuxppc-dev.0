Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-8.online-age.net (Ext-cn0ut-8.online-age.net
	[63.210.253.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6283ADDF82
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 23:31:28 +1100 (EST)
Received: from int-cn0ut-3.online-age.net (int-cn0ut-3.online-age.net
	[3.159.252.72])
	by ext-cn0ut-8.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id n0UCRGHg002987
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 07:27:16 -0500
Received: from alpmlip01.e2k.ad.ge.com (int-cn0ut-3.online-age.net
	[3.159.252.72])
	by int-cn0ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id n0UCVNfG004028
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 07:31:23 -0500
Message-ID: <4982F311.4050507@gefanuc.com>
Date: Fri, 30 Jan 2009 12:31:13 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Booting 2.6.29-rc3 on mpc8661d_hpcn failing
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Guys,

It seems that 2.6.29-rc3 is not booting on the MPC8641 HPCN. I have just updated u-boot to the latest git to see if that improved matters, however I get stuck at the following. Any ideas?

Using MPC86xx HPCN machine description                                          
Total memory = 1024MB; using 2048kB for hash table (at cf400000)                
Linux version 2.6.29-rc3-00014-g4cd6797 (welchma@ubuntu8041) (gcc version 4.1.29
Found initrd at 0xcf783000:0xcfe8ab7e                                           
CPU maps initialized for 1 thread per core                                      
console [udbg0] enabled                                                         
setup_arch: bootmem                                                             
mpc86xx_hpcn_setup_arch()                                                       
Found FSL PCI host bridge at 0x00000000ffe08000. Firmware bus number: 0->2      
PCI host bridge /pcie@ffe08000 (primary) ranges:                                
 MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000               
  IO 0x00000000ffc00000..0x00000000ffc0ffff -> 0x0000000000000000               
Found FSL PCI host bridge at 0x00000000ffe09000. Firmware bus number: 0->0      
PCI host bridge /pcie@ffe09000  ranges:                                         
 MEM 0x00000000a0000000..0x00000000bfffffff -> 0x00000000a0000000               
  IO 0x00000000ffc10000..0x00000000ffc1ffff -> 0x0000000000000000               
MPC86xx HPCN board from Freescale Semiconductor                                 
arch: exit                                                                      
Zone PFN ranges:                                                                
  DMA      0x00000000 -> 0x00030000                                             
  Normal   0x00030000 -> 0x00030000                                             
  HighMem  0x00030000 -> 0x00040000                                             
Movable zone start PFN for each node                                            
early_node_map[1] active PFN ranges                                             
    0: 0x00000000 -> 0x00040000                                                 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096     
Kernel command line:                                                            
mpic: Setting up MPIC " MPIC     " version 1.2 at ffe40000, max 2 CPUs          
mpic: ISU size: 256, shift: 8, mask: ff                                         
mpic: Initializing for 256 sources                                              
i8259 legacy interrupt controller initialized                                   
PID hash table entries: 4096 (order: 12, 16384 bytes)                           
clocksource: timebase mult[2800000] shift[22] registered                        
Console: colour dummy device 80x25                                              
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)                
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)                  
Memory: 1023696k/1048576k available (4968k kernel code, 23968k reserved, 160k d)
SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1         
Calibrating delay loop... 199.68 BogoMIPS (lpj=99840)                           
Mount-cache hash table entries: 512                                             
mpic: requesting IPIs ...                                                       
Processor 1 found.                                                              


Martyn
-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
