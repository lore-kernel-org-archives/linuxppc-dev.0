Return-Path: <sipcop009@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.195])
	by ozlabs.org (Postfix) with ESMTP id 910A367C25
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 05:05:38 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 13so261822nzp
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 12:05:37 -0700 (PDT)
Message-ID: <5a4792c0050714120571fff071@mail.gmail.com>
Date: Thu, 14 Jul 2005 12:05:36 -0700
From: SIP COP 009 <sipcop009@gmail.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <E65A8A95-7352-40A3-9A86-EF437F0132D0@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5a4792c0050713235574522cfb@mail.gmail.com>
	<E65A8A95-7352-40A3-9A86-EF437F0132D0@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8272ADS and Linux 2.6.12
Reply-To: SIP COP 009 <sipcop009@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar,

Thanks for u'r reply. I tried it but it does not seem to work.

Here's my uboot info...
U-Boot 1.1.1 (Oct 29 2004 - 18:28:57)

MPC8272 Reset Status: External Soft, External Hard

MPC8272 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
 - dfbrg 1, corecnf 0x0a, busdf 3, cpmdf 1, plldf 0, pllmf 3
 - vco_out  400000000, scc_clk  100000000, brg_clk   25000000
 - cpu_clk  400000000, cpm_clk  200000000, bus_clk  100000000
 - pci_clk   66666666

CPU:   MPC8272 (HiP7 Rev 13, Mask 0.0 0K50M) at 400 MHz
Board: Motorola MPC8272ADS
DRAM:  64 MB
Now running in RAM - U-Boot at: 03fc4000
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
Net:   FCC1 ETHERNET
Hit any key to stop autoboot:  0=20





=3D> setenv bootargs console=3DttyCPM0,115200  root=3D/dev/ram
=3D> bootm fe600000
## Booting image at fe600000 ...
   Image Name:   2.6.12 for 8272
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    875845 Bytes =3D 855.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Hang here...

Anymore thots and pointers ?

Thanks!
ashutosh



On 7/14/05, Kumar Gala <kumar.gala@freescale.com> wrote:
> You may need to check the bootargs to insure that console=3DttyCPM0
>=20
> - kumar
>=20
> On Jul 14, 2005, at 1:55 AM, SIP COP 009 wrote:
>=20
> > Hello,
> >
> > We have a MPC8272 Eval Board which came with Linux 2.4 and U-boot. We
> > wanted to move to 2.6. I downloaded the latest 2.6.12 sources and
> > compiled the sources for this platform. The kernel is built, have run
> > the mkimage tool, but the kernel wont boot.  It just hangs after
> > decompressing the image.
> >
> > Any ideas  ? Anything different that needs to be done for 2.6 ? Or any
> > known issues ?
> >
> > Thanks!
> > ashutosh
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>=20
>
