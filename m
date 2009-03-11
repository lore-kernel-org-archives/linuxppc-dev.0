Return-Path: <alohanono@gmail.com>
Received: from mail-ew0-f165.google.com (mail-ew0-f165.google.com
	[209.85.219.165]) by ozlabs.org (Postfix) with ESMTP id A7678DDEFE
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 00:41:01 +1100 (EST)
Received: by ewy9 with SMTP id 9so8293ewy.9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 06:40:59 -0700 (PDT)
Message-ID: <49B7BF62.7050708@gmail.com>
Date: Wed, 11 Mar 2009 14:40:50 +0100
From: "A. Nolson" <alohanono@gmail.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: C67x00 reset problems
References: <49B1469B.9030609@gmail.com>	
	<1236379543.13132.10.camel@md40100b.ft>
	<49B6F513.2090304@gmail.com>
	<fa686aa40903101642l20d4d3e1qab1eac14493690f1@mail.gmail.com>
In-Reply-To: <fa686aa40903101642l20d4d3e1qab1eac14493690f1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have upgraded to the latest John Linn's stable PPC kernel (2.6.25rc9)
and I have applied the patch v11(latest) from Peter Korsgaard for the
c67x00. I get the same problem with that, plus an added "feature" of my
Xilinx Temac driver not working anymore :/

loaded at:     00400000
0056B19C                                               
board data at: 00569120
0056919C                                               
relocated to:  00404064
004040E0                                               
zimage at:     00404E50
00568B99                                               
avail ram:     0056C000
04000000                                               
                                                                               

Linux/PPC load: console=ttyUL0,57600 root=/dev/xsa2 rw
init=/sbin/init         
Uncompressing
Linux...done.                                                    
Now booting the
kernel                                                         
[    0.000000] Linux version 2.6.25-rc9-dirty (xxx@xxx) (gcc versio
n 4.2.2) #3 PREEMPT Wed Mar 11 14:04:07 CET
2009                               
[    0.000000] Xilinx Generic PowerPC board support package (Xilinx
ML403) (Virt
ex-4
FX)                                                                       
[    0.000000] Zone PFN
ranges:                                                
[    0.000000]   DMA             0 ->   
16384                                 
[    0.000000]   Normal      16384 ->   
16384                                 
[    0.000000]   HighMem     16384 ->   
16384                                 
[    0.000000] Movable zone start PFN for each
node                            
[    0.000000] early_node_map[1] active PFN
ranges                             
[    0.000000]     0:        0 ->   
16384                                     
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pag
es:
16256                                                                      
[    0.000000] Kernel command line: console=ttyUL0,57600 root=/dev/xsa2
rw init=
/sbin/init                                                                     

[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to
0xFDFFF000               
[    0.000000] PID hash table entries: 256 (order: 8, 1024
bytes)              
[    0.000164] Console: colour dummy device
80x25                              
[    0.000578] Dentry cache hash table entries: 8192 (order: 3, 32768
bytes)   
[    0.001311] Inode-cache hash table entries: 4096 (order: 2, 16384
bytes)    
[    0.013500] Memory: 61580k available (2392k kernel code, 796k data,
116k init
, 0k
highmem)                                                                  
[    0.013765] SLUB: Genslabs=12, HWalign=32, Order=0-1, MinObjects=4,
CPUs=1, N
odes=1                                                                         

[    0.035217] Mount-cache hash table entries:
512                             
[    0.040125] net_namespace: 152
bytes                                        
[    0.042375] NET: Registered protocol family
16                              
[    0.045220] Registering device
uartlite:0                                   
[    0.045919] Registering device
xsysace:0                                    
[    0.046686] Registering device
xilinx_temac:0                               
[    0.047481] Registering device
xilinx_gpio_iic:0                            
[    0.048251] Registering device
xilinx_gpio_iic:1                            
[    0.048960] Registering device
c67x00:0                                     
[    0.049773] Registering device
xilinx_spi:0                                 
[    0.073716] usbcore: registered new interface driver
usbfs                  
[    0.074525] usbcore: registered new interface driver
hub                    
[    0.075645] usbcore: registered new device driver
usb                       
[    0.090615] NET: Registered protocol family
2                               
[    0.100483] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)  
[    0.102400] TCP established hash table entries: 2048 (order: 2, 16384
bytes)
[    0.102680] TCP bind hash table entries: 2048 (order: 1, 8192
bytes)        
[    0.102837] TCP: Hash tables configured (established 2048 bind
2048)        
[    0.102866] TCP reno
registered                                             
[    0.162283] Installing knfsd (copyright (C) 1996
okir@monad.swb.de).        
[    0.165259] io scheduler noop
registered                                    
[    0.165302] io scheduler anticipatory
registered                            
[    0.165328] io scheduler deadline
registered                                
[    0.165676] io scheduler cfq registered
(default)                           
[    0.764717] Generic RTC Driver
v1.07                                        
[    0.765484] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
sharing
disabled                                                                       

[    0.773231] uartlite.0: ttyUL0 at MMIO 0x40600003 (irq = 5) is a
uartlite   
[    0.773293] console [ttyUL0]
enabled                                        
[    1.281526] brd: module
loaded                                              
[    1.292177] loop: module
loaded                                             
[    1.297447] xsysace xsa: Xilinx SystemACE revision
1.0.12                   
[    1.307231] xsysace xsa: capacity: 4001760
sectors                          
[    1.316387]  xsa: xsa1 xsa2
xsa3                                            
[    1.326864] Xilinx SystemACE device driver,
major=254                       
[    1.335692] nbd: registered device at major
43                              
[    1.359637] XTemac: using sgDMA
mode.                                       
[    1.364027] XTemac: using TxDRE
mode                                        
[    1.371101] XTemac: using RxDRE
mode                                        
[    1.378028] XTemac: buffer descriptor size: 32768
(0x8000)                  
[    1.390044] XTemac: (buffer_descriptor_init) phy: 0x3d30000, virt:
0xff100000
, size:
0x8000                                                                 
[    1.411208] eth%d: XTemac: PHY detected at address
0.                       
[    1.418020] 00:  1140 7949 0141 0cc2 01e1 0000 0004
2001                    
[    1.429021] 08:  0000 0300 0000 0000 0000 0000 0000
3000                    
[    1.439344] 10:  0078 8100 0000 0000 0c60 0000 0000
0000                    
[    1.450021] 18:  4100 0000 000a 848f 0000 0000 0000
0000                    
[    1.460429] eth0: Dropping NETIF_F_SG since no checksum
feature.            
[    1.475459] eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC5020000,
irq=2 
[    1.486078] eth0: XTemac id 1.0f, block id 5, type
8                        
[    1.498804] xilinx_spi xilinx_spi.0: at 0x40618000 mapped to
0xC5004000, irq=
4                                                                              

[    6.515214] ------------[ cut here
]------------                            
[    6.516000] Badness at
drivers/usb/c67x00/c67x00-ll-hpi.c:241               
[    6.516000] NIP: c01aa530 LR: c01aa524 CTR:
c0018a14                        
[    6.516000] REGS: c3c1bd70 TRAP: 0700   Not tainted 
(2.6.25-rc9-dirty)                                                                             

[    6.516000] MSR: 00029030 <EE,ME,IR,DR>  CR: 24000082  XER:
2000005d        
[    6.516000] TASK = c3c18000[1] 'swapper' THREAD:
c3c1a000                   
[    6.516000] GPR00: 00000001 c3c1be20 c3c18000 00000000 c02d7518
c0314730 8453
2ba7
00000001                                                                  
[    6.516000] GPR08: 00000000 00000000 c3d15e04 c3c1a000 24000082
ffffffff c029
2be0
c0292bf0                                                                  
[    6.516000] GPR16: c0292c14 c0292c1c c0292c2c c0292c58 c0292c6c
00000000 ffff
ffff
ffffffff                                                                  
[    6.516000] GPR24: c0310000 c0292bd8 c02d8a88 00000000 c3d15de8
00000000 c3d1
5de0
c02d8a6c                                                                  
[    6.516000] NIP [c01aa530]
c67x00_ll_reset+0x48/0x88                        
[    6.516000] LR [c01aa524]
c67x00_ll_reset+0x3c/0x88                         
[    6.516000] Call
Trace:                                                     
[    6.516000] [c3c1be20] [c01aa524] c67x00_ll_reset+0x3c/0x88
(unreliable)    
[    6.516000] [c3c1be40] [c02505a4]
c67x00_drv_probe+0x16c/0x2e0              
[    6.516000] [c3c1be70] [c0180e4c]
platform_drv_probe+0x20/0x30              
[    6.516000] [c3c1be80] [c017ee44]
driver_probe_device+0xec/0x194            
[    6.516000] [c3c1bea0] [c017f09c]
__driver_attach+0x88/0xf4                 
[    6.516000] [c3c1bec0] [c017df94]
bus_for_each_dev+0x58/0x98                
[    6.516000] [c3c1bef0] [c017ec40]
driver_attach+0x24/0x34                   
[    6.516000] [c3c1bf00] [c017e9b8]
bus_add_driver+0xb4/0x218                 
[    6.516000] [c3c1bf20] [c017f400]
driver_register+0x78/0x10c                
[    6.516000] [c3c1bf40] [c01811c8]
platform_driver_register+0x9c/0xac        
[    6.516000] [c3c1bf50] [c030641c]
c67x00_init+0x18/0x28                     
[    6.516000] [c3c1bf60] [c02f4204]
kernel_init+0x100/0x298                   
[    6.516000] [c3c1bff0] [c0004918]
kernel_thread+0x44/0x60                   
[    6.516000] Instruction
dump:                                               
[    6.516000] 90010024 480a89e5 38800000 7fa3eb78 6084fa50 4bffefbd
387d0020 38
801388                                                                         

[    6.516000] 480a7fd1 707dffff 7c000026 54001ffe <0f000000> 3c00ffff
7fbd00d0
60000005                                                                       

[    6.860078] c67x00 c67x00.0: Device reset
failed                            
[    6.866113] c67x00: probe of c67x00.0 failed with error
65531               
[    6.879751] usbcore: registered new interface driver
libusual               
[    6.890566] usbcore: registered new interface driver
cypress_cy7c63         
[    6.903058] i8042.c: No controller
found.                                   
[    6.912220] mice: PS/2 mouse device common for all
mice                     
[    6.923303] i2c /dev entries
driver                                         
[    6.930558] i2c-parport-light: adapter type
unspecified                     
[    6.941806] xilinx_gpio_iic.0 #0 at 0x400C0000 mapped to
0xC5040000         
[    6.953631] xilinx_gpio_iic.1 #1 at 0x400A0000 mapped to
0xC5060000         
[    7.041126] usbcore: registered new interface driver
usbhid                 
[    7.049104] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core
driver         
[    7.065981] TCP cubic
registered                                            
[    7.070135] NET: Registered protocol family
1                               
[    7.078177] NET: Registered protocol family
17                              
[    7.090737] RPC: Registered udp transport
module.                           
[    7.097122] RPC: Registered tcp transport
module.                           
[    7.123804] kjournald starting.  Commit interval 5
seconds                  
[    7.132117] EXT3-fs warning: maximal mount count reached, running
e2fsck is r
ecommended                                                                     

[    7.150770] EXT3 FS on xsa2, internal
journal                               
[    7.156016] EXT3-fs: recovery
complete.                                     
[    7.164048] EXT3-fs: mounted filesystem with ordered data
mode.             
[    7.176115] VFS: Mounted root (ext3
filesystem).                            
[    7.185289] Freeing unused kernel memory: 116k
init                         


Grant Likely wrote:
> Unfortunately, the 2.6.24-rc3 stuff in my git tree is really old.
> I've been getting all of my recent work into mainline.  The CF driver
> is in much better shape there.  The c67x00 driver is merged into
> mainline, but I haven't tested it at all in the last year so I don't
> know how well it will work.
>
> Cheers,
> g.
>
> On Tue, Mar 10, 2009 at 5:17 PM, A. Nolson <alohanono@gmail.com> wrote:
>   
>> Hi,
>>
>>  I am using 2.6.24-rc3 ( secretlabs git) in an ML403 where I want to
>> use the USB c67x00 based host with Peter Kosgaard driver. I am using it
>> together with the sysace device for CF access ( in the ML403 those two
>> share lines, but I managed to insert some logic to multiplex both
>> devices). I have been able to use the c67300 without OS, but when I try
>> to boot the kernel I am getting driver reset problems (the whole log is
>> at the end)
>>
>> [    6.882540] c67x00 c67x00.0: Device reset
>> failed
>> [    6.889278] c67x00: probe of c67x00.0 failed with error 65531
>>
>> And of course the device cannot get probed. I think this has happened to
>> other people before but I can't find the solution in the archive. My
>> virtex_devices.c initialization looks like this:
>>
>> #define XPAR_C67x00_USB(num) { \
>>  .name = "c67x00", \
>>  .id = num, \
>>  .num_resources = 2, \
>>  .resource = (struct resource[]) { \
>>         { \
>>         .start = XPAR_C67X00_USB_PRH##num##_BASEADDR, \
>>         .end = XPAR_C67X00_USB_PRH##num##_BASEADDR + 0xf, \
>>         .flags = IORESOURCE_MEM, \
>>         }, \
>>         { \
>>         .start  = XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT_INTR, \
>>         .end    = XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT_INTR, \
>>         .flags  = IORESOURCE_IRQ, \
>>          }, \
>>  }, \
>>  .dev.platform_data = &(struct c67x00_platform_data) { \
>>  .sie_config = C67X00_SIE1_HOST | C67X00_SIE2_PERIPHERAL_A, \
>>  .hpi_regstep = 0x02, /* A0 not connected on 16bit bus */ \
>>  }, \
>> }
>>
>>  /* Cypress USB C67x00 instances */
>> #if defined(XPAR_C67X00_USB_PRH0_BASEADDR)
>>  XPAR_C67x00_USB(0),
>> #endif
>>
>>
>> and my xparameters_ml403.h like this:
>>
>> /* Definitions for peripheral C67X00_USB */
>> #define XPAR_C67X00_USB_PRH0_BASEADDR 0xA5000000
>> #define XPAR_C67X00_USB_PRH0_HIGHADDR 0xA500FFFF
>> #define XPAR_C67X00_USB_PRH1_BASEADDR 0xA5010000
>> #define XPAR_C67X00_USB_PRH1_HIGHADDR 0xA501FFFF
>> #define XPAR_C67X00_USB_PRH2_BASEADDR 0xA5020000
>> #define XPAR_C67X00_USB_PRH2_HIGHADDR 0xA502FFFF
>> #define XPAR_C67X00_USB_PRH3_BASEADDR 0xA5030000
>> #define XPAR_C67X00_USB_PRH3_HIGHADDR 0xA503FFFF
>>
>> #define XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT_INTR 0
>> #define XPAR_SYSTEM_USB_HPI_INT_MASK 0X000001
>>
>> I don't know what could be wrong here. Any clues?
>>
>> /Albert
>>
>>
>>
>> loaded at:     00400000
>> 0056419C
>> board data at: 00562120
>> 0056219C
>> relocated to:  0040406C
>> 004040E8
>> zimage at:     00404E58
>> 00561F12
>> avail ram:     00565000
>> 04000000
>>
>>
>> Linux/PPC load: console=ttyUL0,57600 root=/dev/xsa2 rw
>> init=/sbin/init
>> Uncompressing
>> Linux...done.
>> Now booting the
>> kernel
>> [    0.000000] Linux version 2.6.24-rc3-dirty (xxx@xxx) (gcc vers
>> n 4.2.2) #77 PREEMPT Mon Mar 9 18:31:59 CET
>> 2009
>> [    0.000000] Xilinx ML403 Reference System (Virtex-4
>> FX)
>> [    0.000000] Zone PFN
>> ranges:
>> [    0.000000]   DMA             0 ->
>> 16384
>> [    0.000000]   Normal      16384 ->
>> 16384
>> [    0.000000]   HighMem     16384 ->
>> 16384
>> [    0.000000] Movable zone start PFN for each
>> node
>> [    0.000000] early_node_map[1] active PFN
>> ranges
>> [    0.000000]     0:        0 ->
>> 16384
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
>> Total p
>> es:
>> 16256
>> [    0.000000] Kernel command line: console=ttyUL0,57600 root=/dev/xsa2
>> rw ini
>> /sbin/init
>>
>> [    0.000000] Xilinx INTC #0 at 0x41200000 mapped to
>> 0xFDFFF000
>> [    0.000000] PID hash table entries: 256 (order: 8, 1024
>> bytes)
>> [    0.000160] Console: colour dummy device
>> 80x25
>> [    0.000569] Dentry cache hash table entries: 8192 (order: 3, 32768
>> bytes)
>> [    0.001326] Inode-cache hash table entries: 4096 (order: 2, 16384
>> bytes)
>> [    0.013549] Memory: 61628k available (2352k kernel code, 796k data,
>> 112k in
>> , 0k
>> highmem)
>> [    0.013800] SLUB: Genslabs=11, HWalign=32, Order=0-1, MinObjects=4,
>> CPUs=1,
>> odes=1
>>
>> [    0.035282] Mount-cache hash table entries:
>> 512
>> [    0.039567] net_namespace: 64
>> bytes
>> [    0.044545] NET: Registered protocol family
>> 16
>> [    0.051781] Registering
>> spi1_board_info
>> [    0.074960] usbcore: registered new interface driver
>> usbfs
>> [    0.075863] usbcore: registered new interface driver
>> hub
>> [    0.076911] usbcore: registered new device driver
>> usb
>> [    0.090812] NET: Registered protocol family
>> 2
>> [    0.100648] IP route cache hash table entries: 1024 (order: 0, 4096
>> bytes)
>> [    0.103337] TCP established hash table entries: 2048 (order: 2, 16384
>> bytes
>> [    0.103614] TCP bind hash table entries: 2048 (order: 1, 8192
>> bytes)
>> [    0.103770] TCP: Hash tables configured (established 2048 bind
>> 2048)
>> [    0.103798] TCP reno
>> registered
>> [    0.107443] sysctl table check failed: /kernel/l2cr .1.31 Missing
>> strategy
>> [    0.107511] Call
>> Trace:
>> [    0.107530] [c3c11de0] [c0008338] show_stack+0x50/0x188
>> (unreliable)
>> [    0.107606] [c3c11e30] [c003cf88]
>> set_fail+0x50/0x68
>> [    0.107675] [c3c11e50] [c003d5f8]
>> sysctl_check_table+0x658/0x6ac
>> [    0.107730] [c3c11ec0] [c003d60c]
>> sysctl_check_table+0x66c/0x6ac
>> [    0.107785] [c3c11f30] [c002907c]
>> register_sysctl_table+0x64/0xe0
>> [    0.107851] [c3c11f50] [c02ee750]
>> register_ppc_htab_sysctl+0x18/0x2c
>> [    0.107919] [c3c11f60] [c02e8230]
>> kernel_init+0x10c/0x2a4
>> [    0.107962] [c3c11ff0] [c0004c38]
>> kernel_thread+0x44/0x60
>> [    0.165612] Installing knfsd (copyright (C) 1996
>> okir@monad.swb.de).
>> [    0.168476] io scheduler noop
>> registered
>> [    0.168515] io scheduler anticipatory
>> registered
>> [    0.168538] io scheduler deadline
>> registered
>> [    0.168885] io scheduler cfq registered
>> (default)
>> [    0.763801] Generic RTC Driver
>> v1.07
>> [    0.764606] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
>> sharin
>> disabled
>>
>> [    0.773092] uartlite.0: ttyUL0 at MMIO 0x40600003 (irq = 5) is a
>> uartlite
>> [    0.773152] console [ttyUL0]
>> enabled
>> [    1.334309] RAMDISK driver initialized: 16 RAM disks of 4096K size
>> 1024 blo
>> size
>>
>> [    1.353807] loop: module
>> loaded
>> [    1.358480] xsysace xsysace.0: Xilinx SystemACE revision
>> 1.0.12
>> [    1.370084] xsysace xsysace.0: capacity: 7831152
>> sectors
>> [    1.380238]  xsa: xsa1 xsa2
>> xsa3
>> [    1.389686] Xilinx SystemACE device driver,
>> major=254
>> [    1.398224] nbd: registered device at major
>> 43
>> [    1.424199] XTemac: using sgDMA
>> mode.
>> [    1.429022] XTemac: using TxDRE
>> mode
>> [    1.436090] XTemac: using RxDRE
>> mode
>> [    1.443173] XTemac: buffer descriptor size: 32768
>> (0x8000)
>> [    1.454594] XTemac: (buffer_descriptor_init) phy: 0x3d20000, virt:
>> 0xff1000
>> , size:
>> 0x8000
>> [    1.475707] eth%d: XTemac: PHY detected at address
>> 0.
>> [    1.483329] eth0: Dropping NETIF_F_SG since no checksum
>> feature.
>> [    1.498175] eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC5020000,
>> irq=2
>> [    1.509565] eth0: XTemac id 1.0f, block id 5, type
>> 8
>> [    1.522258] xilinx_spi xilinx_spi.0: at 0x40618000 mapped to
>> 0xC5004000, ir
>> 4
>>
>> [    6.538578] ------------[ cut here
>> ]------------
>> [    6.545188] Badness at
>> drivers/usb/c67x00/c67x00-ll-hpi.c:241
>> [    6.556588] NIP: c01a4ec0 LR: c01a4eb4 CTR:
>> c00186a4
>> [    6.566441] REGS: c3c11d80 TRAP: 0700   Not tainted
>> (2.6.24-rc3-dirty)
>>
>> [    6.580945] MSR: 00029030 <EE,ME,IR,DR>  CR: 35000093  XER:
>> e0000065
>> [    6.593565] TASK = c3c0d000[1] 'swapper' THREAD:
>> c3c10000
>> [    6.603925] GPR00: 00000001 c3c11e30 c3c0d000 00000000 c02c8528
>> 00000001 85
>> 5751
>> 00000000
>> [    6.620512] GPR08: 00000000 00000000 c3d12384 c3c10000 35000093
>> ffffffff c0
>> 4040
>> c0284050
>> [    6.637100] GPR16: c0284074 c028407c c028408c c02840b8 c02840cc
>> 00000000 ff
>> ffff
>> ffffffff
>> [    6.653687] GPR24: c0300000 c0284038 c02c9a20 00000000 c3d12368
>> 00000000 c3
>> 2360
>> c02c9a04
>> [    6.670620] NIP [c01a4ec0]
>> c67x00_ll_reset+0x48/0x88
>> [    6.680468] LR [c01a4eb4]
>> c67x00_ll_reset+0x3c/0x88
>> [    6.690143] Call
>> Trace:
>> [    6.694986] [c3c11e30] [c01a4eb4] c67x00_ll_reset+0x3c/0x88
>> (unreliable)
>> [    6.708290] [c3c11e50] [c01a3b0c]
>> c67x00_drv_probe+0x16c/0x2e0
>> [    6.719866] [c3c11e80] [c017af4c]
>> platform_drv_probe+0x20/0x30
>> [    6.731442] [c3c11e90] [c0179328]
>> driver_probe_device+0xec/0x194
>> [    6.743364] [c3c11eb0] [c0179580]
>> __driver_attach+0x88/0xf4
>> [    6.754422] [c3c11ed0] [c017855c]
>> bus_for_each_dev+0x54/0x94
>> [    6.765654] [c3c11f00] [c017912c]
>> driver_attach+0x24/0x34
>> [    6.776366] [c3c11f10] [c0178998]
>> bus_add_driver+0x78/0x1d4
>> [    6.787424] [c3c11f30] [c01798b4]
>> driver_register+0x88/0x9c
>> [    6.798482] [c3c11f40] [c017b2c8]
>> platform_driver_register+0x9c/0xac
>> [    6.811095] [c3c11f50] [c02fae74]
>> c67x00_init+0x18/0x28
>> [    6.821462] [c3c11f60] [c02e8230]
>> kernel_init+0x10c/0x2a4
>> [    6.832175] [c3c11ff0] [c0004c38]
>> kernel_thread+0x44/0x60
>> [    6.842886] Instruction
>> dump:
>> [    6.848760] 90010024 480a4969 38800000 7fa3eb78 6084fa50 4bffefbd
>> 387d0020
>> 801388
>>
>> [    6.864136] 480a3edd 707dffff 7c000026 54001ffe <0f000000> 3c00ffff
>> 7fbd00d
>> 60000005
>>
>> [    6.882540] c67x00 c67x00.0: Device reset
>> failed
>> [    6.889278] c67x00: probe of c67x00.0 failed with error
>> 65531
>> [    6.901621] usbcore: registered new interface driver
>> libusual
>> [    6.912837] usbcore: registered new interface driver
>> cypress_cy7c63
>> [    6.925443] i8042.c: No controller
>> found.
>> [    6.934533] mice: PS/2 mouse device common for all
>> mice
>> [    6.945746] i2c /dev entries
>> driver
>> [    6.953016] i2c-parport-light: adapter type
>> unspecified
>> [    6.964041] usbcore: registered new interface driver
>> usbhid
>> [    6.972725] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core
>> driver
>> [    6.985267] TCP cubic
>> registered
>> [    6.991691] NET: Registered protocol family
>> 1
>> [    7.000260] NET: Registered protocol family
>> 17
>> [    7.011149] RPC: Registered udp transport
>> module.
>> [    7.018303] RPC: Registered tcp transport
>> module.
>> [   20.920617] kjournald starting.  Commit interval 5
>> seconds
>> [   20.975785] EXT3 FS on xsa2, internal
>> journal
>> [   20.981905] EXT3-fs: recovery
>> complete.
>> [   21.287791] EXT3-fs: mounted filesystem with ordered data
>> mode.
>> [   21.297194] VFS: Mounted root (ext3
>> filesystem).
>>
>>
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
>>     
>
>
>
>   
