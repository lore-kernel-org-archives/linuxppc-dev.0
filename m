Message-ID: <20030218221657.69298.qmail@web20709.mail.yahoo.com>
Date: Tue, 18 Feb 2003 14:16:57 -0800 (PST)
From: Root User <linux4me75@yahoo.com>
Subject: Re: 405GP external master
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> There's an app note at IBM about this:
>
> http://www->
3.ibm.com/chips/techlib/techlib.nsf/techdocs/B60C93EB27F44B0F87256AAF005E788F/$file/405DMAPerformance02.pdf
>
> --Chris

This appnote details the timing for DMA transfers, not
external masters.  I'm hoping that external masters
can result in better throughput than DMA.  With DMA,
you are limited to about 35 MB/sec max.  I need about
twice that bandwidth.

The user guide has timing diagrams for burst accesses
on the external bus.  If external masters and 405GP
can perform sustained, back-to-back burst transfers by
an external master, I should be able to hit my
targets.

Question is whether the 405GP can sustain continuous
burst transactions from an external master, or whether
there are other internal limitations which would
prevent me from hitting 70 MB/sec throughput from
SDRAM<->external master.

Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
