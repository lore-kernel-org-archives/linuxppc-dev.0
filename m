Message-ID: <39C8BB30.9E8DA6F@sxb.bsf.alcatel.fr>
Date: Wed, 20 Sep 2000 15:27:12 +0200
From: Christian Batt <Christian.Batt@sxb.bsf.alcatel.fr>
MIME-Version: 1.0
To: Tobias Otto-Adamczak <Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8xx DPRAM : m8xx_cpm_hostalloc
References: <Pine.LNX.4.21.0009201448500.2375-100000@odoaker.hrz.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I assume the subject is m8xx_cpm_dpalloc, not m8xx_cpm_hostalloc.

Yes, you're right. I have missed the right name when copy/pasting... : ))

> > I am currently working with a MPC860 (Linux kernel 2.2.13)
> > and I need more DPRAM space for my BD/buffers, than the
> > space between IMMR+0x2800 - IMMR+0x2F00 (1792 bytes).
>
> You can place your buffers outside the DPRAM (you can use
> m8xx_cpm_hostalloc for that).

OK.

> > I know the 860 has 5K of DPRAM : 4K + 1K of parameter RAM.
> >
> > So, I have tried to modify the value of
> >     CPM_DATAONLY_BASE   from 0x0800 to 0x0000
> >     CPM_DATAONLY_SIZE     from 0x0700 to 0x1000
>
> These values were chosen in regard to possibly active microcode relocation
> patches that could reside in the DPRAM. Does your boot code / monitor
> program / linux kernel load and use microcode relocation patches ? If so,
> you should determine the area where they reside so that you know which
> space is left for you in DPRAM.

No, I don't use any microcode patch.

> > but my kernel (compiled with those values) stucks early at boot time :
> >
> > ...
> > Uncompressing Linux... done.
> > Now booting the kernel
> >     -(and no more)-
>
> Looks like your linux console doesn't work. Which SCC/SMC are you using
> as console ?

I am using SMC1 as the console an SCC2 for Ethernet.

Thanks a lot    ;-)

Christian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
