Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6668DE233
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Apr 2008 01:47:10 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JhnC6-0003sn-Cd
	for linuxppc-embedded@ozlabs.org; Fri, 04 Apr 2008 07:47:06 -0700
Message-ID: <16491756.post@talk.nabble.com>
Date: Fri, 4 Apr 2008 07:47:06 -0700 (PDT)
From: Amarendra_Reddy <amar1567@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Help required on MPC82XX USB Host controller Development using
	m82xx-hcd.
In-Reply-To: <200803270956.12203.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <16304553.post@talk.nabble.com>
	<200803270956.12203.laurentp@cse-semaphore.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Laurent,

Thanks for your reply.

Most of the modules of the new product(based on Kernrel 2.6.10) are
completed, except for the USB module. Hence we have to work with the kernre=
l
2.6.10 even for USB module.

We integrated cmp2usb project into Kernel 2.6.10, and with some
modifications and compiled the kernel successfully.

When pendrive is inserted into the USB port we are facing the below
mentioned problems.
(sorry for a lengthy posting)

We would be thankful if you / anyone could suggest us with some solution or
idea or an alternative approach.

Given below is the Console Output=20
CASE 1: When pendrive is inserted "Directly to USB port of the 8272ADS
board".
CASE 2: When pendrive is inserted on an "External hub which is conntected t=
o
USB port of 8272ADS board".

Output from console:

CASE 1: Pendrive Directly connected to uSB port of the 8272ADS board

USB Universal Host Controller Interface driver v2.2
Registering platform device 'mpc82xx-hcd.3'. Parent at platform
=3D> driver mpc82xx-hcd, 2005
mpc82xx-hcd mpc82xx-hcd.3: PQ2 intergrated USB controller v0.1
mpc82xx-hcd mpc82xx-hcd.3: new USB bus registered, assigned bus number 1
usb usb1: Product: PQ2 intergrated USB controller v0.1
usb usb1: Manufacturer: Linux 2.6.10_mvl401-8272ads mpc82xx-hcd
usb usb1: SerialNumber: mpc82xx-hcd.3
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
PQ2USB: debug file creation

........after SANDISK pendrive inserted.........

usb 1-1: new full speed USB device using mpc82xx-hcd and address 2
usb 1-1: Product: U3 Cruzer Micro
usb 1-1: Manufacturer: SanDisk Corporation
Oops: Exception in kernel mode, sig: 4 [#1]

........after unknown/generic manufacturer's pendrive inserted.......

usb 1-1: new full speed USB device using mpc82xx-hcd and address 2
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: new full speed USB device using mpc82xx-hcd and address 3
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: new full speed USB device using mpc82xx-hcd and address 4
usb 1-1: device not accepting address 4, error -110
usb 1-1: new full speed USB device using mpc82xx-hcd and address 5
usb 1-1: device not accepting address 5, error -110


CASE 2: Pendrive is inserted on an "External hub which is conntected to USB
port of 8272ADS board".

USB Universal Host Controller Interface driver v2.2
sl811: driver sl811-hcd, 19 May 2005
Registering platform device 'mpc82xx-hcd.3'. Parent at platform
=3D> driver mpc82xx-hcd, 2005
mpc82xx-hcd mpc82xx-hcd.3: PQ2 intergrated USB controller v0.1
mpc82xx-hcd mpc82xx-hcd.3: new USB bus registered, assigned bus number 1
usb usb1: Product: PQ2 intergrated USB controller v0.1
usb usb1: Manufacturer: Linux 2.6.10_mvl401-8272ads mpc82xx-hcd
usb usb1: SerialNumber: mpc82xx-hcd.3
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
PQ2USB: debug file creation
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.


.......after SANDISK pendrive inserted........

usb 1-1.3: new full speed USB device using mpc82xx-hcd and address 3
usb 1-1.3: Product: U3 Cruzer Micro
usb 1-1.3: Manufacturer: SanDisk Corporation
usb 1-1.3: can't set config #1, error -110
hub 1-1:1.0: cannot disable port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 1-1:1.0: cannot disable port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 1-1:1.0: cannot disable port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: cannot reset port 3 (err =3D -110)
hub 1-1:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 1-1:1.0: cannot disable port 3 (err =3D -110)
hub 1-1:1.0: cannot disable port 3 (err =3D -110)
hub 1-1:1.0: hub_port_status failed (err =3D -110)

........after unknown manufacturer's pendrive inserted...........

usb 1-1.1: new full speed USB device using mpc82xx-hcd and address 7
usb 1-1.1: Product: Mass Storage Device
usb 1-1.1: Manufacturer: Generic
usb 1-1.1: SerialNumber: 6EOG5LAF
scsi0 : SCSI emulation for USB Mass Storage devices
floating point used in kernel (task=3Dc0306050, pc=3Dc022a5f8)
Oops: Exception in kernel mode, sig: 4 [#1]



Thanks & Regards
Amarendra Reddy

--------------------------------------------------------

Laurent Pinchart-4 wrote:
>=20
> Hi Amarendra,
>=20
> On Wednesday 26 March 2008 17:11, Amarendra_Reddy wrote:
>>=20
>> Hi all,
>>=20
>> We are working on implementation of the USB host controller driver for
>> the
>> MPC8272ADS (eval board).=20
>>=20
>> The USB Host controller on MPC8272 chip is neither UHCI nor OHCI
>> compliant.=20
>>=20
>> We downloaded the project cpm2usb and the patches created by Mr.Mike
>> Rapoport from http://cpm2usb.sourceforge.net
>>=20
>> We integrated the 'm82xx-hcd' into the 2.6.10 source with few changes to
>> usb
>> data structures (usb_hcd,usb_device,usb_host_endpoint) and to struct
>> hc_driver. Also updated the function ''tx_err' present in m82xx-hcd.c.
>=20
> The cpm2usb project isn't maintained. If possible you should upgrade to a
> more=20
> recent kernel and switch to the powerpc architecture where a new USB
> driver=20
> called fhci is available.
>=20
> The MPC872ADS is supported in recent kernels so switching shouldn't be to=
o=20
> difficult.
>=20
> Best regards,
>=20
> --=20
> Laurent Pinchart
> CSE Semaphore Belgium
>=20
> Chauss=C3=A9e de Bruxelles, 732A
> B-1410 Waterloo
> Belgium
>=20
> T +32 (2) 387 42 59
> F +32 (2) 387 42 75
>=20
> =20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20

--=20
View this message in context: http://www.nabble.com/Help-on-MPC82XX-USB-Hos=
t-controller-Development-using-m82xx-hcd.-tp16304553p16491756.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
