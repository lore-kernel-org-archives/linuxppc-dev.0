Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 7B1B4679EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 17:13:25 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: PPC Linux support for Tundra TSI148
Date: Thu, 27 Apr 2006 09:13:10 +0200
References: <821B2170E9E7F04FA38DF7EC21DE4871049711CD@VCAEXCH01.hq.corp.viasat.com>
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE4871049711CD@VCAEXCH01.hq.corp.viasat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604270913.10778.g.jaeger@sysgo.com>
Cc: "Martin, Tim" <tim.martin@viasat.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

See my comments inline:

On Wednesday 26 April 2006 18:24, Martin, Tim wrote:
> Gerhard,
> 
> Thanks for the information.  More questions...
> 
> What type of transfers were you doing? (e.g. A32/D64? SST320 or SST267?)
A32/D64 and 2eSST @ SST320

> Are these transfer from userspace data, from kernelspace data, or from
> the Tundra's pattern buffer?

They are from userspace.

> What was your PCI bus speed & width? 
???

> Were you using inbound/outbound windows or Tundra's DMA controller?
DMA - via /dev/vme_dma0 interface

> What was the Tundra chipset configuration for the 168 MBps?
i.e. Buffersize 64K, 4K alignment, 2K PCI Fifo and 1K VME Fifo.
Using the Tundra driver and its interface structure, I used a 
request level of 2, fairmode is set to normal, timeon timeout timer
is set to 7 and timeoff is set to no waiting (0).

> 
> Thanks,
> Tim
> 
> > -----Original Message-----
> > From: linuxppc-embedded-bounces+tmartin=viasat.com@ozlabs.org
> > [mailto:linuxppc-embedded-bounces+tmartin=viasat.com@ozlabs.org] On
> Behalf
> > Of Gerhard Jaeger
> > Sent: Wednesday, April 26, 2006 12:26 AM
> > To: linuxppc-embedded@ozlabs.org
> > Subject: Re: PPC Linux support for Tundra TSI148
> > 
> > On Wednesday 26 April 2006 01:47, Martin, Tim wrote:
> > > Does anyone out there have any real world measured performance of a
> > > Linux PowerPC (kernel module + user space application) doing 2eSST
> VME
> > > transfers with the Tundra TSI148 chipset?
> > >
> > > Tundra has a Linux driver available for the Motorola MVME6100 , but
> told
> > > me they don't have any performance data available.  I'm looking for
> > > sustained throughput rates, not the peak burst rates (e.g. 320 MBps,
> 267
> > > MBps).
> > >
> > 
> > Hi,
> > 
> > I've done here some tests between two MVME6100, while updating the
> 6100
> > BSP
> > for our embedded Linux distro. Depending on the buffersize, alignment,
> VME
> > and
> > PCI FIFO settings we have (without further optimizations) throughput
> rates
> > ranging
> > from 100MBps up to 168MBps. I think some tuning could still be done.
> > 
> >HTH
> > Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
