Message-ID: <375BCEC2.FE8B95B1@jlc.net>
Date: Mon, 07 Jun 1999 09:53:06 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Alexander Larsson <alex@signum.se>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Bug report
References: <Pine.LNX.4.04.9906071049580.26155-100000@tammy.signum.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alexander Larsson wrote:

> 
> In the embedded 2.2.5 sources i found the following in
> arch/ppc/kernel/ppc-stub.c
> 
> static inline void set_msr(int msr)
> {
>         asm volatile("mfmsr %0" : : "r" (msr));
> }
> 
> Shouldn't that be mtmsr?

Yes....Fortunately, it is only used in the kgbd portion of the
kernel, so normal operations are not affected.


	-- Dan

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
