Message-ID: <3958DA7D.B158E228@netx4.com>
Date: Tue, 27 Jun 2000 12:46:53 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Tom Roberts <tjroberts@lucent.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Query: kernel version for MPC750/MPC7400
References: <7283DE19D141D111AD0E00A0C95B195502C5F5F2@mail2.aiinet.com> <3957DEFF.9064056E@netx4.com> <3958B37C.1F280F3F@lucent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Roberts wrote:

> How about on an embedded MPC750 or MPC7400? Before joining this
> list I discovered Kernel version 2.2.15 on Yellowdog and have been
> using that.

That should work.  The question was directed toward 8xx processors,
so I thought I would answer that.

> There are zillions of references to CONFIG_8xx throughout the source.

All old, broken, out of date.  All of the updates in the "stand-alone"
8xx kernels were too much to be allowed into the "official" kernel
sources.  With 2.4.xx coming, I think I will just make that one
work and not fight to get the changes into 2.2.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
