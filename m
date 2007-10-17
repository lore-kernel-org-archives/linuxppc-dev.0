Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 98B4FDDE24
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 04:24:01 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3047417wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 11:24:00 -0700 (PDT)
Message-ID: <fa686aa40710171123uefac227q4fecd64516794129@mail.gmail.com>
Date: Wed, 17 Oct 2007 12:23:59 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: aauer1 <aauer1@gmx.at>
Subject: Re: Linux booting problem on Xilinx ppc
In-Reply-To: <13259685.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12694083.post@talk.nabble.com>
	<fa686aa40709152009k2b27ffc9kfb3fd0848f6b16d@mail.gmail.com>
	<12696686.post@talk.nabble.com> <13219154.post@talk.nabble.com>
	<000901c81006$7303b490$bb3ca688@LGE.NET>
	<13239003.post@talk.nabble.com>
	<fa686aa40710161237t54688b71g9c7cf9acdac2b744@mail.gmail.com>
	<13252272.post@talk.nabble.com>
	<fa686aa40710170754p54aa405au9b046f7039ecb9ac@mail.gmail.com>
	<13259685.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/17/07, aauer1 <aauer1@gmx.at> wrote:
>
>
> Grant Likely-2 wrote:
> >
> > On 10/17/07, aauer1 <aauer1@gmx.at> wrote:
> >> Now, I know that the kernel boots but I don't get an output with my
> >> Xilinx
> >> UartLite module. Are there some kernel modules which must be activated??
> >> Btw. I have used the Linux-2.6-virtex kernel from
> >> http://git.secretlab.ca/git/ and another Kernel (2.6.23 from kernel.org)
> >> -
> >> both with the same result.
> >
> > Post the output of __log_buf here please.
> >
> >
>
> Here is my dump of the __log_buf:
> ======================
> <5>[    0.000000] Linux version 2.6.23-rc2
> (aauer@servitus.student.iaik.tugraz.at) (gcc version 4.0.0 (DENX ELDK 4.1
> 4.0
> .0)) #8 Wed Oct 17 20:05:28 CEST 2007
> <6>[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
> <7>[    0.000000] Entering add_active_range(0, 0, 16384) 0 entries of 256
> used
> <4>[    0.000000] Zone PFN ranges:
> <4>[    0.000000]   DMA             0 ->    16384
> <4>[    0.000000]   Normal      16384 ->    16384
> <4>[    0.000000] Movable zone start PFN for each node
> <4>[    0.000000] early_node_map[1] active PFN ranges
> <4>[    0.000000]     0:        0 ->    16384
> <7>[    0.000000] On node 0 totalpages: 16384
> <7>[    0.000000]   DMA zone: 128 pages used for memmap
> <7>[    0.000000]   DMA zone: 0 pages reserved
> <7>[    0.000000]   DMA zone: 16256 pages, LIFO batch:3
> <7>[    0.000000]   Normal zone: 0 pages used for memmap
> <7>[    0.000000]   Movable zone: 0 pages used for memmap
> <4>[    0.000000] Built 1 zonelists in Zone order.  Total pages: 16256
> <5>[    0.000000] Kernel command line: console=ttUL0 root=/dev/xsysace2 rw

Typo!  :-)

Try  "ttyUL0"

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
