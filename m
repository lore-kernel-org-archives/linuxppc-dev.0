Return-Path: <Martin.Krause@tqs.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 30 Nov 2004 13:40:06 +0100
Message-ID: <DE2CC66C40EAB74EA6D66AC71BF98E1E016AF517@TQ-MAILSRV-1>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: <zhonglei@RCS-9000.COM>
Cc: Linuxppc-embedded@ozlabs.org
Subject: AW: AW: USB driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi zhonglei,

zhonglei wrotes on Dienstag, 30. November 2004 12:50:
> Thank you!
> After enabled SCSI support and SCSI disk support,I can enable
> USB mass storage devices . I enabled USB mass storage support
> and reboot my kernel.The system run into a deadlock!

Sorry, I haven't tested usb mass storage support on the lite5200,
so I could not tell if it works.
=20
> U-Boot 1.1.2 (Nov 12 2004 - 11:46:06)
>=20
> CPU:   MPC5200 v1.2 at 462 MHz

The cpu clock seems a bit fast to me. AFAIR the maximum is 400 MHz
for actual cpu revisions.

>        Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
> Board: Motorola MPC5200 (IceCube)
> I2C:   85 kHz, ready
> DRAM:  64 MB
> FLASH: 16 MB
> PCI:   Bus Dev VenId DevId Class Int
>         00  1a  1057  5803  0680  00
> In:    serial
> Out:   serial
> Err:   serial
> Net:   FEC ETHERNET
> IDE:   Bus 0: OK
>   Device 0: Model: Flash Card Firm: 2N3-0925 Ser#: CF00000000
>             Type: Removable Hard Disk
>             Capacity: 123.0 MB =3D 0.1 GB (251904 x 512)   Device 1:
> not available=20
>=20
> Autostarting.Press any key to abort..
>=20
> Hit any key to stop autoboot:  0
> Using FEC ETHERNET device
> TFTP from server 198.87.102.60; our IP address is 198.87.102.210
> Filename 'MPC5200/uImage'. Load address: 0x100000
> Loading:
> #################################################################
>=20
> #################################################################
>          #################################################
> done
> Bytes transferred =3D 914801 (df571 hex)
> ## Booting image at 00100000 ...
>    Image Name:   Linux-2.4.25
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    914737 Bytes =3D 893.3 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>=20
> What can I do next?

A good starting point for error searching is the FAQ-Section in the =
DULG:
http://www.denx.de/twiki/bin/view/DULG/Manual

Regards,
Martin
