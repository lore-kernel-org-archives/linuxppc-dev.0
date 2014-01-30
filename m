Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 201F02C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 01:19:45 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 26521-10 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 30 Jan 2014 14:19:36 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: "'Moese, Michael'" <michael.moese@men.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: PCIe Access - achieve bursts without DMA
Date: Thu, 30 Jan 2014 14:19:12 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6B530A@AcuExch.aculab.com>
References: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
In-Reply-To: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From Moese, Michael
> Hello PPC-developers,
> I'm currently trying to benchmark access speeds to our PCIe-connected IP-=
cores
> located inside our FPGA. On x86-based systems I was able to achieve burst=
s for
> both read and write access. On PPC32, using an e500v2, I had no success a=
t all
> so far.

I'm not sure that you can.
I had to write a simple driver for the PCIe CSB bridge dma on a 83xx ppc.
I think that might be the one in the e500v2.

I don't know how fast 'normal' PCIe slaves are, but we were accessing
an Altera fpga and the latency is less than pedestrian.
I think an ISA bus can run faster!
With moderate length transfers, the throughput was more than adequate.

	David
