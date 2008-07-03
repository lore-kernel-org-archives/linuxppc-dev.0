Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.233])
	by ozlabs.org (Postfix) with ESMTP id 0BC98DDEEF
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 07:59:15 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d8so3524176qbc.37
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Jul 2008 14:59:13 -0700 (PDT)
Date: Thu, 3 Jul 2008 15:58:29 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anand Kumar S <sanandkumar@hcl.in>
Subject: Re: Linux on ML403 serial console problem
Message-ID: <20080703215829.GD3098@secretlab.ca>
References: <66E8AEE9980BB44CA5FCAD39EBA56AC604A5F1DF@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <66E8AEE9980BB44CA5FCAD39EBA56AC604A5F1DF@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jul 03, 2008 at 03:42:21PM +0530, Anand Kumar S wrote:
> Any help is greatly appreciated as I am really struggling with this
> problem for the past 3 days. Given below is the output from serial port.
> I do not have FB support or VT or VT console
> 
> Support enabled. Only SERIAL console support is enabled i.e
> SERIAL_CORE_CONSOLE/SERIAL_8250_CONSOLE support is enabled
> 

You kernel output log is incomplete.  Please repost the entire output
from the serial port.  (I'm expecting to see the kernel command line).

g.

>  
> 
> ......
> 
> ......
> 
> Serial: 8250/16550 driver $Revision: 1.90 $ 5 ports, IRQ sharing
> disabled
> 
> Registering platform device 'serial8250'. Parent at platform
> 
> ttyS0 at MMIO 0x0 (irq = 9) is a 16550A
> 
> io scheduler noop registered
> 
> io scheduler anticipatory registered
> 
> io scheduler deadline registered
> 
> io scheduler cfq registered
> 
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> 
> loop: loaded (max 8 devices)
> 
> PPP generic driver version 2.4.2
> 
> PPP Deflate Compression module registered
> 
> NET: Registered protocol family 24
> 
> xemac 0: using fifo mode.
> 
> eth0: Xilinx EMAC #0 at 81000000 mapped to 0xC30C0000, irq=0
> 
> i2c /dev entries driver
> 
> xilinx_iic.0 #0 at 0x81600000 mapped to 0xC30E0000, irq=6
> 
> mice: PS/2 mouse device common for all mice
> 
> NET: Registered protocol family 2
> 
> IP: routing cache hash table of 512 buckets, 4Kbytes
> 
> TCP: Hash tables configured (established 2048 bind 4096)
> 
> NET: Registered protocol family 1
> 
> NET: Registered protocol family 17
> 
> interrupts enabled 
> 
> TX interrupts enabled. register baseaddr c30c0000 offset 7fc is 8 
> 
> TX interrupts enabled. register baseaddr c30c0000 offset ffc is 0 
> 
> RX interrupts enabled. register baseaddr c30c0000 offset 17fc is 9 
> 
> RX interrupts enabled. register baseaddr c30c0000 offset 1ffc is 0 
> 
> GIER interrupts enabled. register baseaddr c30c0000 offset 7f8 is
> 80000000 
> 
> Sending DHCP requests .,... OK
> 
> IP-Config: Got DHCP answer from 0.0.0.0, my address is 10.100.12.132
> 
> IP-Config: Complete:
> 
>       device=eth0, addr=10.100.12.132, mask=255.255.255.0,
> gw=10.100.12.1,
> 
>      host=10.100.12.132, domain=hclt.corp.hcl.in, nis-domain=(none),
> 
>      bootserver=0.0.0.0, rootserver=0.0.0.0, rootpath=
> 
> RAMDISK: Compressed image found at block 0
> 
> VFS: Mounted root (ext2 filesystem).
> 
> Freeing unused kernel memory: 124k init
> 
> done freeing memory. creating console 
> 
> console created 
> 
> running process /bin/test 
> 
> in tty_write
> 
> before calling write. buf contents h e l
> 
> core write
> 
> core write
> 
> core write
> 
> Kernel panic - not syncing: Attempted to kill init!
> 
>  <0>Rebooting in 180 seconds..<NULL>
> 
>  
> 
> 
> 
> DISCLAIMER:
> -----------------------------------------------------------------------------------------------------------------------
> 
> The contents of this e-mail and any attachment(s) are confidential and intended for the named recipient(s) only.
> It shall not attach any liability on the originator or HCL or its affiliates. Any views or opinions presented in 
> this email are solely those of the author and may not necessarily reflect the opinions of HCL or its affiliates.
> Any form of reproduction, dissemination, copying, disclosure, modification, distribution and / or publication of 
> this message without the prior written consent of the author of this e-mail is strictly prohibited. If you have 
> received this email in error please delete it and notify the sender immediately. Before opening any mail and 
> attachments please check them for viruses and defect.
> 
> -----------------------------------------------------------------------------------------------------------------------
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
