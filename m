Mime-Version: 1.0
Message-Id: <v04220801b5d681fb0852@[10.0.0.42]>
In-Reply-To: <20000901110221.5823@mailhost.mipsys.com>
References: <v04220803b5d51a99c774@[10.0.0.42]>
 <20000901110221.5823@mailhost.mipsys.com>
Date: Sat, 2 Sep 2000 03:09:15 -0700
To: Benjamin Herrenschmidt <bh40@calva.net>, <linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:02 PM +0200 9/1/00, Benjamin Herrenschmidt wrote:

>>3. When attempting to do the partition scan, the kernel has massive
>>problems with lost IDE interrupts and failed DMA stuff.  Eventually
>>it gives up and moves on without successfully scanning my IDE drive.
>
>With the CMD controller ? The mac-io should work fine with the current
>bk, the CMD still have problems.

Yep, with the CMD.  I only have a DVD-ROM attached to the mac-io
controller, when I play with it tomorrow I'll watch carefully and see
if it's being recognized.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
