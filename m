Return-Path: <iluri@fagorautomation.es>
Received: from correo2.sarenet.es (correo2.sarenet.es [194.30.0.12])
	by ozlabs.org (Postfix) with ESMTP id C96FC679F9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 23:28:10 +1000 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by correo2.sarenet.es (Postfix) with ESMTP id 2B33E36E0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 15:28:06 +0200 (CEST)
Message-ID: <44648DE5.8030601@fagorautomation.es>
Date: Fri, 12 May 2006 15:30:13 +0200
From: Igor Luri <iluri@fagorautomation.es>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux doesn't boot if USB is enabled
References: <20060512095339.421CC352B2A@atlas.denx.de>
In-Reply-To: <20060512095339.421CC352B2A@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Wolfgang,

I have updated linux kernel an u-boot from the CVS repository, so I have 
de latest u-boot and linux version. I grabed the new u-boot an kernel 
and now hungs later while probing PCI. If I configure linux kernel 
without PCI support, it boots OK.

I use lite5200b_defconfig configuration. I am missing something in the 
configuration relationated with PCI?



U-Boot 1.1.4 (May 12 2006 - 
14:45:32)                                                                           

                                                                                                                

CPU:   MPC5200 v2.2, Core v1.4 at 462 
MHz                                                                      
       Bus 132 MHz, IPB 132 MHz, PCI 33 
MHz                                                                    
Board: Freescale 
Lite5200B                                                                                      

I2C:   85 kHz, 
ready                                                                                            

DRAM:  256 
MB                                                                                                   

FLASH: 32 
MB                                                                                                    

*** Warning - bad CRC, using default 
environment                                                               
                                                                                                                

PCI:   Bus Dev VenId DevId Class 
Int                                                                            

        00  1a  1057  5809  0680  
00                                                                            

In:    
serial                                                                                                   

Out:   
serial                                                                                                   

Err:   
serial                                                                                                   

Net:   FEC 
ETHERNET                                                                                             

IDE:   Bus 0: 
OK                                                                                                

  Device 0: Model: SanDisk SDCFB-32 Firm: HDX 2.15 Ser#: 
103407C2604A5824                                      
            Type: Hard 
Disk                                                                                     

            Capacity: 30.6 MB = 0.0 GB (62720 x 
512)                                                           
  Device 1: not 
available                                                                                       

                                                                                                                

Type "run flash_nfs" to mount root filesystem over NFS

Hit any key to stop autoboot:  0
=>  bootp 500000 vmlinux.UBoot
BOOTP broadcast 1
Using FEC ETHERNET device
TFTP from server 10.0.7.228; our IP address is 10.0.17.102
Filename 'vmlinux.UBoot'.
Load address: 0x500000
Loading: #################################################################
         #################################################################
         ##########################################################
    
 done                                                                                                            

Bytes transferred = 959935 (ea5bf 
hex)                                                                          

=> usb 
reset                                                                                                    

(Re)start 
USB...                                                                                                

USB:   scanning bus for devices... 1 USB Device(s) 
found                                                       
       scanning bus for storage devices... 0 Storage Device(s) 
found                                           
=> bootm 
500000                                                                                                 

## Booting image at 00500000 
...                                                                                

   Image Name:   
Linux-2.4.25                                                                                   

   Created:      2006-05-12  12:31:19 
UTC                                                                      
   Image Type:   PowerPC Linux Kernel Image (gzip 
compressed)                                                  
   Data Size:    959871 Bytes = 937.4 
kB                                                                       
   Load Address: 
00000000                                                                                       

   Entry Point:  
00000000                                                                                       

   Verifying Checksum ... 
OK                                                                                    

   Uncompressing Kernel Image ... 
OK                                                                            

Memory BAT mapping: BAT2=256Mb, BAT3=0Mb, residual: 
0Mb                                                        
Linux version 2.4.25 (igor@ILURI_LINUX) (gcc version 3.3.6) #1 vie may 
12 14:27:36 CEST 2006                   
On node 0 totalpages: 
65536                                                                                     

zone(0): 65536 
pages.                                                                                           

zone(1): 0 
pages.                                                                                               

zone(2): 0 
pages.                                                                                               

Kernel command 
line:                                                                                            

Calibrating delay loop... 307.20 
BogoMIPS                                                                       

Memory: 256340k available (1636k kernel code, 496k data, 76k init, 0k 
highmem)                                 
Dentry cache hash table entries: 32768 (order: 6, 262144 
bytes)                                                
Inode cache hash table entries: 16384 (order: 5, 131072 
bytes)                                                 
Mount cache hash table entries: 512 (order: 0, 4096 
bytes)                                                     
Buffer cache hash table entries: 16384 (order: 4, 65536 
bytes)                                                 
Page-cache hash table entries: 65536 (order: 6, 262144 
bytes)                                                  
POSIX conformance testing by 
UNIFIX                                                                             

PCI: Probing PCI hardware
PCI: moved dev

Wolfgang Denk wrote:

>In message <918EB199DDDFFA42BEA2EB3A1C6021F3CE19E2@correo.fagorautomation.net> you wrote:
>  
>
>>We also have a mpc5200liteB evaluation board with u-boot 1.1.4 and linux
>>2.4.25 from Denx. We have realized that when USB is enabled linux
>>doen´t boot, it hungs after u-boot uncompresses linux image.
>>    
>>
>
>You need the latest versions of both U-boot and Linux.
>
>For U-Boot, you need a version after April 18 (see especially  commit
>ID  8419c013048b1f15f3fa2fc7c0463d860a04ee3e).  For the Linux kernel,
>you  need  a  version  after  April  21  (see  especially  commit  ID
>1ac8b71bdbe6de928ba84c83831f6988a9b51165).
>
>I recommend to grab the top-of-tree from both repositories.
>
>Best regards,
>
>Wolfgang Denk
>
>  
>
