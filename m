Message-ID: <39C8C35A.17D027C0@sxb.bsf.alcatel.fr>
Date: Wed, 20 Sep 2000 16:02:02 +0200
From: Christian Batt <Christian.Batt@sxb.bsf.alcatel.fr>
MIME-Version: 1.0
To: Tobias Otto-Adamczak <Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8xx DPRAM : m8xx_cpm_hostalloc
References: <Pine.LNX.4.21.0009201535490.2375-100000@odoaker.hrz.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > > You can place your buffers outside the DPRAM (you can use
> > > m8xx_cpm_hostalloc for that).
> >
> > OK.
>
> Does this solve your problem ? What are you working on, e.g. which
> controller/protocol ? What is your HW (CPU, board) ?

I am working on a utopia (ATM) module. The board is a TQM8xxL
shipped with a 860SAR, Rev C1.
The buffers are stored in the host main memory, whereas the Buffer
Descriptors and some other ATM tables are stored in DPRAM.
That's why I need more DPRAM space ...

> > No, I don't use any microcode patch.
>
> On my MBX board the EPPC-Bug monitor loads a patch at boot time. I ignored
> that for a long time; I thought I was done with disabling the microcode
> option in the kernel config. But I had to explicitly disable the microcode
> relocation to get my SPI working.
>
> Surely it would work also with microcode enabled but then I would have to
> take care of all these relocation things.

The monitor I use to run the kernel, is the one shipped with the TQboard.
Just after a hard reset, I have dumped the state of the register after
monitor setup : SCCR = 0  ->  ERAM =0 : So, microcode program execution is
disabled.

I will get a deeper look inside all that stuff ...

Thanks for your help Tobias,

Best Regards

Christian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
