Return-Path: <carcadiz@hotmail.com>
Received: from blu139-omc2-s10.blu139.hotmail.com
	(blu139-omc2-s10.blu139.hotmail.com [65.55.175.180])
	by ozlabs.org (Postfix) with ESMTP id ADD61DDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Dec 2007 19:29:14 +1100 (EST)
Message-ID: <BLU106-W29574B582C7A66E85FA5FCCA620@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: Misbah khan <misbah_khan@engineer.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: USB configuration
Date: Mon, 17 Dec 2007 09:29:12 +0100
In-Reply-To: <14370084.post@talk.nabble.com>
References: <14192347.post@talk.nabble.com>
	<BLU106-W40541C7A5C29E0CF526F13CA6F0@phx.gbl>
	<14206951.post@talk.nabble.com>
	<BLU106-W35DC430E02A0A1798D8B95CA650@phx.gbl>
	<14370084.post@talk.nabble.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


MIsbah wrote:
> I have configured for mass storage device still i am not getting the debu=
g
> msg that the kernel has detected the pen drive (after i connect the pen
> drive ).
>=20
>   " Initializing USB Mass Storage driver...
>      usbcore: registered new driver usb-storage
>      USB Mass Storage support registered.=20
>   "

As long as you enabled the USB Mass storage and all usb-related modules, if=
 you don't get any output, maybe the usb hardware is not working properly. =
I don't work with that board, so I feel like I can not help further more, s=
orry.
Hope you find a solution!

Regards,

Pedro L.

> ----misbah=20
>=20
>=20
> Pedro Luis D. L. wrote:
>>=20
>>=20
>>> From: misbah_khan@engineer.com
>>> To: linuxppc-embedded@ozlabs.org
>>> Subject: RE: USB configuration
>>>=20
>>>=20
>>> I have inserted a USB card reader, and the following dmesg it shows ...=
..
>>>=20
>>> -----------------------------------------------------------------------=
--------
>>> mpc8272ads: Init
>>> PCI: Probing PCI hardware
>>> PCI: Cannot allocate resource region 0 of device 0000:00:00.0
>>> PCI: Cannot allocate resource region 1 of device 0000:00:00.0
>>> SCSI subsystem initialized
>>> Linux Kernel Card Services
>>>   options:  [pci] [cardbus]
>>> usbcore: registered new driver usbfs
>>> usbcore: registered new driver hub
>>> Serial: CPM driver $Revision: 0.01 $
>>> ttyCPM0 at MMIO 0xf0011a00 (irq =3D 40) is a CPM UART
>>> ttyCPM1 at MMIO 0xf0011a60 (irq =3D 43) is a CPM UART
>>> io scheduler noop registered
>>> io scheduler anticipatory registered
>>> io scheduler deadline registered
>>> io scheduler cfq registered
>>> loop: loaded (max 8 devices)
>>> fs_enet.c:v1.0 (Aug 8, 2005)
>>> fs_enet: eth0 Phy @ 0x0, type DM9161 (0x0181b881)
>>> fs_enet: eth1 Phy @ 0x3, type DM9161 (0x0181b881)
>>> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>>> ide: Assuming 33MHz system bus speed for PIO modes; override with
>>> idebus=3Dxx
>>> st: Version 20041025, fixed bufsize 32768, s/g segs 256
>>> osst :I: Tape driver with OnStream support version 0.99.1
>>> osst :I: $Id: osst.c,v 1.70 2003/12/23 14:22:12 wriede Exp $
>>> ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI=
)
>>> ohci_hcd: block sizes: ed 64 td 64
>>> drivers/usb/serial/usb-serial.c: USB Serial support registered for
>>> Generic
>>> usbcore: registered new driver usbserial_generic
>>> usbcore: registered new driver usbserial
>>> drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
>>> NET: Registered protocol family 2
>>> IP: routing cache hash table of 512 buckets, 4Kbytes
>>> TCP: Hash tables configured (established 4096 bind 8192)
>>> NET: Registered protocol family 1
>>> NET: Registered protocol family 17
>>> IP-Config: Complete:
>>>       device=3Deth1, addr=3D192.168.33.136, mask=3D255.255.248.0,
>>> gw=3D192.168.32.47,
>>>      host=3Dcashel, domain=3D, nis-domain=3D(none),
>>>      bootserver=3D192.168.33.96, rootserver=3D192.168.33.96, rootpath=
=3D
>>> Looking up port of RPC 100003/2 on 192.168.33.96
>>> Looking up port of RPC 100005/1 on 192.168.33.96
>>> VFS: Mounted root (nfs filesystem).
>>> Freeing unused kernel memory: 104k init
>>> -----------------------------------------------------------------------=
---------------
>>>=20
>>=20
>> It looks like it is well configured, because the usbfs and hub are loade=
d.
>> You could check in your kernel configuration that you enabled USB Mass
>> storage driver and attached a pen drive as I suggested before.
>> Another possibility is to insert a card in the USB card reader. Then you
>> should be able to see with dmesg if it is recognized.
>>=20
>> Pedro.
>>=20
>>> This doesent gives me the clear explaination of whether USB is working
>>> properly....
>>>=20
>>> I would appreciate if you could share with me the basic steps to be
>>> followed
>>> to confirm that the USB support that i had configured is being tested i=
n
>>> all
>>> aspects.
>>>=20
>>> Misbah
>>>=20
>>> Pedro Luis D. L. wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> Date: Thu, 6 Dec 2007 05:27:14 -0800
>>>>> From: misbah_khan@engineer.com
>>>>> To: linuxppc-embedded@ozlabs.org
>>>>> Subject: USB configuration
>>>>>=20
>>>>>=20
>>>>> HI all ...
>>>>=20
>>>> Hi,
>>>>=20
>>>>> I have configured the Montavista Kernel for USB support and for
>>>>> PPC8272-ADS
>>>>> board I need to know that how could i test that my USB is working ???=
?
>>>>>=20
>>>>=20
>>>> Try to attach an USB device, like a pendrive,  to an USB port. Then
>>>> type:=20
>>>> dmesg | tail
>>>>=20
>>>> If the USB support is working properly, you should see some output
>>>> saying
>>>> which device have you attached and where is it mapped.
>>>> If you plug a memory stick, you can try to mount it and check that the
>>>> filesystem is correct.
>>>>=20
>>>> Pedro.
>>>>=20
>>>>> Its creating the directory :- /proc/bus/usb/ but doesent contain any
>>>>> file
>>>>> under it ????
>>>>>=20
>>>>>=20
>>>>> its also creating the directory :- /sys/bus/usb/   but doesent contai=
n
>>>>> any
>>>>> file under it ????
>>>>>=20
>>>>>=20
>>>>> Please let me know the procedure to test whether my USB configuration
>>>>> is
>>>>> all
>>>>> right ????
>>>>>=20
>>>>> Thank u=20
>>>>> Misbah <><
>>>>> --=20
>>>>> View this message in context:
>>>>> http://www.nabble.com/USB-configuration-tf4956061.html#a14192347
>>>>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>>>>>=20
>>>>> _______________________________________________
>>>>> Linuxppc-embedded mailing list
>>>>> Linuxppc-embedded@ozlabs.org
>>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>=20
>>>> _________________________________________________________________
>>>> Tecnolog=EDa, moda, motor, viajes,=85suscr=EDbete a nuestros boletines=
 para
>>>> estar a la =FAltima
>>>> http://newsletters.msn.com/hm/maintenanceeses.asp?L=3DES&C=3DES&P=3DWC=
Maintenance&Brand=3DWL&RU=3Dhttp%3a%2f%2fmail.live.com
>>>> _______________________________________________
>>>> Linuxppc-embedded mailing list
>>>> Linuxppc-embedded@ozlabs.org
>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>=20
>>>>=20
>>>=20
>>> --=20
>>> View this message in context:
>>> http://www.nabble.com/USB-configuration-tf4956061.html#a14206951
>>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>>>=20
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>=20
>> _________________________________________________________________
>> MSN Video.=20
>> http://video.msn.com/?mkt=3Des-es
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>=20
>>=20
>=20
> --=20
> View this message in context: http://www.nabble.com/USB-configuration-tp1=
4192347p14370084.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
MSN Video.=20
http://video.msn.com/?mkt=3Des-es=
