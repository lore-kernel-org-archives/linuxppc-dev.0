Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91B66DDDD6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Dec 2007 20:34:21 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1J4Yq8-0003g7-FZ
	for linuxppc-embedded@ozlabs.org; Tue, 18 Dec 2007 01:34:16 -0800
Message-ID: <14387839.post@talk.nabble.com>
Date: Tue, 18 Dec 2007 01:34:16 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: USB configuration
In-Reply-To: <4766940E.4090801@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <14192347.post@talk.nabble.com>
	<BLU106-W40541C7A5C29E0CF526F13CA6F0@phx.gbl>
	<14206951.post@talk.nabble.com>
	<BLU106-W35DC430E02A0A1798D8B95CA650@phx.gbl>
	<14370084.post@talk.nabble.com> <4766940E.4090801@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I have configured MPC82xx USB controler 
the debug msg is this " g_file_storage gadget: controller 'mpc8272_udc' not
recognized "
Is this the problem ?????

USB Led is also not glowing where in all the other configurations are
registered success ....viz

/----------------------------------------------------------------------------------------------------
7:255.255.248.0:cashel:eth1:off
PID hash table entries: 512 (order: 9, 8192 bytes)
hr_time_init: arch_to_nsec = 83886080, nsec_to_arch = 107374182
Warning: real time clock seems stuck!
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 62208k available (1952k kernel code, 588k data, 108k init, 0k
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
desched cpu_callback 2/00000000
desched thread 0 started up.
NET: Registered protocol family 16
mpc8272ads: Init
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
PCI: Cannot allocate resource region 1 of device 0000:00:00.0
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
ttyCPM1 at MMIO 0xf0011a60 (irq = 43) is a CPM UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
fs_enet.c:v1.0 (Aug 8, 2005)
fs_enet: eth0 Phy @ 0x0, type DM9161 (0x0181b881)
fs_enet: eth1 Phy @ 0x3, type DM9161 (0x0181b881)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
st: Version 20041025, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.1
osst :I: $Id: osst.c,v 1.70 2003/12/23 14:22:12 wriede Exp $
USB Universal Host Controller Interface driver v2.2
sl811: driver sl811-hcd, 06 Dec 2004
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for USB
modems and ISDN adapters
drivers/usb/class/bluetty.c: USB Bluetooth support registered
usbcore: registered new driver bluetty
drivers/usb/class/bluetty.c: USB Bluetooth tty driver v0.13
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
MPC8272 USB peripheral device
g_file_storage gadget: controller 'mpc8272_udc' not recognized
g_file_storage gadget: no file given for LUN0
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=eth1, addr=192.168.33.136, mask=255.255.248.0,
gw=192.168.32.47,
     host=cashel, domain=, nis-domain=(none),
     bootserver=192.168.33.96, rootserver=192.168.33.96, rootpath=
Looking up port of RPC 100003/2 on 192.168.33.96
Looking up port of RPC 100005/1 on 192.168.33.96
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 108k init
INIT: version 2.85 booting
Setting up IP spoofing protection: rp_filter.
Disable TCP/IP Explicit Congestion Notification: done.
Starting network interfaces: /sbin/ifup: interface lo already configured
done.
Starting portmap daemon: portmap.
INIT: Entering runlevel: 3
Starting internet superserver: inetd.

MontaVista(R) Linux(R) Professional Edition 4.0.1 (0502020)

----------------------------------------------------------------------------------------------------/

--------Misbah<><



Scott Wood-2 wrote:
> 
> Misbah khan wrote:
>> I have configured for mass storage device still i am not getting the
>> debug
>> msg that the kernel has detected the pen drive (after i connect the pen
>> drive ).
>> 
>>   " Initializing USB Mass Storage driver...
>>      usbcore: registered new driver usb-storage
>>      USB Mass Storage support registered. 
>>   "
> 
> Did you get any output indicating that the USB controller was found and 
> initialized?  This *is* a PCI-based OHCI controller you're trying to 
> use, and not the CPM USB, right?  Do other PCI devices work?
> 
> -Scott
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/USB-configuration-tp14192347p14387839.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
