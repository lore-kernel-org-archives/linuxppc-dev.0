Date: Wed, 20 Sep 2000 15:48:19 +0200 (MEST)
From: Tobias Otto-Adamczak <Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de>
To: Christian Batt <Christian.Batt@sxb.bsf.alcatel.fr>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8xx DPRAM : m8xx_cpm_hostalloc
In-Reply-To: <39C8BB30.9E8DA6F@sxb.bsf.alcatel.fr>
Message-ID: <Pine.LNX.4.21.0009201535490.2375-100000@odoaker.hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > You can place your buffers outside the DPRAM (you can use
> > m8xx_cpm_hostalloc for that).
>
> OK.

Does this solve your problem ? What are you working on, e.g. which
controller/protocol ? What is your HW (CPU, board) ?

> No, I don't use any microcode patch.

On my MBX board the EPPC-Bug monitor loads a patch at boot time. I ignored
that for a long time; I thought I was done with disabling the microcode
option in the kernel config. But I had to explicitly disable the microcode
relocation to get my SPI working.

Surely it would work also with microcode enabled but then I would have to
take care of all these relocation things.

Ciao - Tobias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
