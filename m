Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 22B7E679F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 02:24:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PPC Linux support for Tundra TSI148
Date: Wed, 26 Apr 2006 09:24:20 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE4871049711CD@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Gerhard Jaeger" <g.jaeger@sysgo.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gerhard,

Thanks for the information.  More questions...

What type of transfers were you doing? (e.g. A32/D64? SST320 or SST267?)

Are these transfer from userspace data, from kernelspace data, or from
the Tundra's pattern buffer?

What was your PCI bus speed & width?

Were you using inbound/outbound windows or Tundra's DMA controller?

What was the Tundra chipset configuration for the 168 MBps?

Thanks,
Tim

> -----Original Message-----
> From: linuxppc-embedded-bounces+tmartin=3Dviasat.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+tmartin=3Dviasat.com@ozlabs.org] On
Behalf
> Of Gerhard Jaeger
> Sent: Wednesday, April 26, 2006 12:26 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: PPC Linux support for Tundra TSI148
>=20
> On Wednesday 26 April 2006 01:47, Martin, Tim wrote:
> > Does anyone out there have any real world measured performance of a
> > Linux PowerPC (kernel module + user space application) doing 2eSST
VME
> > transfers with the Tundra TSI148 chipset?
> >
> > Tundra has a Linux driver available for the Motorola MVME6100 , but
told
> > me they don't have any performance data available.  I'm looking for
> > sustained throughput rates, not the peak burst rates (e.g. 320 MBps,
267
> > MBps).
> >
>=20
> Hi,
>=20
> I've done here some tests between two MVME6100, while updating the
6100
> BSP
> for our embedded Linux distro. Depending on the buffersize, alignment,
VME
> and
> PCI FIFO settings we have (without further optimizations) throughput
rates
> ranging
> from 100MBps up to 168MBps. I think some tuning could still be done.
>=20
> HTH
> Gerhard
>=20
> --
> Gerhard Jaeger <gjaeger@sysgo.com>
> SYSGO AG                      Embedded and Real-Time Software
> www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
