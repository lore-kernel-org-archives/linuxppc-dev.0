Date: Sat, 17 Nov 2001 01:34:40 +0000 (GMT)
From: Phillip Lougher <phillip@lougher.demon.co.uk>
To: Shie Erlich <shie_e@elbit.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: a general bootloader question
In-Reply-To: <Pine.LNX.4.21.0111170109000.1293-100000@lougher.demon.co.uk>
Message-ID: <Pine.LNX.4.21.0111170130020.1401-100000@lougher.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 17 Nov 2001, Phillip Lougher wrote:

> > The linux image should be a pure binary image (not with the ELF header).
> > See objdump concerning how to strip the vmlinux file.

objdump should be objcopy, namely

objcopy -S -O binary vmlinux <output_file>

In mitigation, it is 1.30 in the morning here, so what do you expect.

>
> >
> > Hope this helps.
> >
> > Phillip
> >
> > ----
> > Phillip Lougher,
> > Zarlink Semiconductor,
> > Chepstow,
> > Wales.
> >
> > >
> > > 		thanks in advance,
> > > 			Shie Erlich
> > >
> > >
> > >
> > >
> > >
> >
> >
> >
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
