Message-Id: <l03130300b4afbdf43e5f@[24.218.140.90]>
In-Reply-To: <3889ABF5.CB8BD5AA@erols.com>
References: <l03130300b4aef8bd7dd2@[24.218.140.90]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 22 Jan 2000 15:11:38 -0500
To: Nelson Abramson <pogtal@erols.com>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: Stock 2.2.14 won't boot
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:09 AM -0500 1/22/00, Nelson Abramson wrote:
>"Michael R. Zucca" wrote:
>
>> I've compiled a stock (ftp.us.kernel.org) 2.2.14 with different stuff in
>> and out. While it seems to compile just fine I can't seem to get it to boot.
>>
>
>Do you get any make errors?

No errors during make, otherwise I wouldn't have a kernel to boot :-)

>What fails during boot..?

BootX switches to the black screen where it informs me of the kernel
version and a few address offsets (like video address, etc.) All of this is
normal. It just hangs there and doesn't progress.

>What are you
>configuring into the kernel that is causing it to fail...?

Nothing especially spectacular. 604, PowerMac, ati framebuffer, bootX
console support, pmac serial support, pmac floppy support, vga console,
mace ethernet, adaptec PCI scsi support, internal SCSI support (53C support
not the other kind), DMA sound for awacs, some file systems, PPP, etc.

I'm not compiling in anything I haven't in past versions.

I am booting off of a drive attached to the PCI scsi card but that
shouldn't matter as this works fine from older kernels.

____________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
____________________________________________________________________


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
