Return-Path: <kylo.ginsberg@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.192])
	by ozlabs.org (Postfix) with ESMTP id 827C868085
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 10:44:24 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i31so28327wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 09 Aug 2005 17:44:23 -0700 (PDT)
Message-ID: <61cc712d05080917381d86b123@mail.gmail.com>
Date: Tue, 9 Aug 2005 17:38:17 -0700
From: Kylo Ginsberg <kylo.ginsberg@gmail.com>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
In-Reply-To: <F795765B112E7344AF36AA91127964158494FC@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <F795765B112E7344AF36AA91127964158494FC@xmb-sjc-212.amer.cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: pci_enable_device fails on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bizhan,

I noticed that lspci reports SERR on the secondary side of the bridge
from bus 0 to bus 2.  Do you know what's causing SERR to be asserted?

Kylo

On 8/9/05, Bizhan Gholikhamseh (bgholikh) <bgholikh@cisco.com> wrote:
> Hi Kumar,
> I am using Linux 2.6.11, u-boot 1.1.2.
> I see failure in pci_enable_device with message:
> "PCI: Device 0000:02:01.0 not available because of resource collisions"
>=20
> I have attached three files:
> lspci_output.txt: out put of the "lspci -v"
> proc_pci.txt: output of the "cat /proc/pci"
> u-boot.txt: output of the "pci command at u-boot"
>=20
> Any help greatly appreciated,
> Bizhan
> -----Original Message-----
> From: Kumar Gala [mailto:kumar.gala@freescale.com]
> Sent: Monday, August 08, 2005 1:34 PM
> To: Bizhan Gholikhamseh (bgholikh)
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: pci_enable_device fails on MPC8541
>=20
> Bizhan,
>=20
> A few questions:
>=20
> 1. what kernel version are you using on these boards:
> 2. can you do an lspci -v on the boards
>=20
> - kumar
>=20
> On Aug 8, 2005, at 1:12 PM, Bizhan Gholikhamseh \(((bgholikh\))) wrote:
>=20
> > Hi All,
> > I am using two evaluation board from freescale, 8540ADS and MPC8541.
> > The same PCI driver is being compiled and loaded on both platforms.
> > The same PCI driver (developed by me) for DSP board compiled and
> > loaded on both platforms.
> >
> > When I type: "insmod C6415.ko" on 8541 board, I get the following
> > error:
> > "PCI: Device 0000:02:01.0 not available because of resource
> > collisions"
> > This messages is because of the execution of the generic PCI Linux
> > command:
> > "pci_enable_device(pdev)"
> > The same API has no problem on 8540ADS.
> >
> >
> >> From UBOOT I can see my device is on bus 3:
> >>
> > =3D> pci 3
> > Scanning PCI devices on bus 3
> > BusDev FUN    VendorID    DeviceID    Device Class    Sub-Class
> > ----------------------------------------------------------------------
> > --
> > --------------------
> > 03.01.00            0x104c    0xa106        .........
> >
> > Any idea why the insmod fails on one board and not on the other one?
> >
> > Many thanks in advance,
> > Bizhan
> >
> > <ATT2118305.txt>
> >
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
>
