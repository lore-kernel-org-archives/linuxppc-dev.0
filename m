Mime-Version: 1.0
Message-Id: <v04220801b4e6adfba6f6@[10.0.0.42]>
In-Reply-To: <200003041016.LAA00502@piglet.grunz.lu>
References: <200003041016.LAA00502@piglet.grunz.lu>
Date: Sat, 4 Mar 2000 04:15:51 -0800
To: mlan@cpu.lu
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: PCI I/O address problems on B&W G3
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:16 AM +0100 3/4/00, Michel Lanners wrote:

>>  So it would seem to me that we need some kind of a scheme for
>>  allocating I/O port base addresses if OF didn't do it.  I'm vaguely
>>  familiar with the concepts behind PCI address space allocation,
>>  having looked at it from the hardware design POV a while back, but
>>  I'm not familiar enough with the kernel code yet to tackle this
>>  problem (or to even be sure that I'm on the right track here).
>
>That should be handled by the new, 2.3 PCI code with dynamic resurce
>allocation. I've just discovered that part, however, and am not at all
>familiar with it. I'm RTFS'ing...

Another piece of code to look at might be the Alpha arch PCI code in
2.2.  From what I can tell it is doing complete configuration of PCI
by itself (apparently the firmware on Alpha boards doesn't do any PCI
config).

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
