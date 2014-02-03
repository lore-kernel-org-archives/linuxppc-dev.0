Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id B2A1C2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 04:08:51 +1100 (EST)
Message-ID: <52EFCD26.5070702@ovro.caltech.edu>
Date: Mon, 03 Feb 2014 09:08:54 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Michael Moese <michael.moese@men.de>
Subject: Re: PCIe Access - achieve bursts without DMA
References: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
 <1391208815.27142.38.camel@pasglop> <52EC2F46.7000609@ovro.caltech.edu>
 <20140203082050.GB1970@localhost.intra.men.de>
In-Reply-To: <20140203082050.GB1970@localhost.intra.men.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> On Fri, Jan 31, 2014 at 03:18:30PM -0800, David Hawkins wrote:
>> 1. Peripheral board DMA (board-to-board)
>> 2. Peripheral board DMA to host memory.
>> 3. Host (root complex) DMA.
>>
>> As far as "verification" of your custom peripheral board FPGA IP is
>> concerned, if I was a customer, and you had data for (1) and (2),
>> I'd be pretty happy (and could care less about (2), since its so
>> system dependent).
>
> Usually I would totally agree with you and try to implement the benchmark
> using DMA transfers Unfortunately, we have some boards and IP cores that
> do not support DMA transfers, or the target system must not do by a
> requirement, and as I have no influence on these, I had to investigate
> on how to improve my throughput.

Ah, I see, that does make your life difficult then.

> I've submitted a RFC Patch earlier today, which allowed me to perform
> PCIe read bursts on IO memory, achieving 18 MB/s instead of the 3 MB/s
> I got when using non-cached reads. However, I had to ioremap() my
> memory, like Gabriel said, using write-thru configuration.

That sounds like a reasonable compromise.

Cheers,
Dave
