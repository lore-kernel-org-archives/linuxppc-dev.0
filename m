Content-Type: text/plain;
  charset="iso-8859-1"
From: Leonardo Pereira Santos <lsantos@pd3.com.br>
Subject: Re: Can software discover MPC8xx variant?
Date: Wed, 29 Jan 2003 14:29:37 -0200
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Message-Id: <200301291429.38410.lsantos@pd3.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



As the 8xx family is supported by the kernel, I assume that what you want is
to know if the 8xx processor running supports some feature? If this is the
case, I can tell you how to do it the way I'd.
You can define some ioport with pull-up and pool-down resistors and in the
manufacturing process specifiy if this board is for product A, then you
should use MPC850DSL and you will mount some of the pull-ups and pull-downs.
If the board is for product B, then you should mount MPC850SAR and mount
differently the pull-ups and downs. By reading the value on the selected
pins, you might de able to know what board this is. This scheme can also be
used to know what hardware revision your board have.

On Wednesday 29 January 2003 12:13, Marius Groeger wrote:
> On Wed, 29 Jan 2003, Alex Zeffertt wrote:
> > Can anybody tell me if there is a way to identify which processor from
> > the MPC8xx family software is running on.  I hoped I could use the IMMR
> > special purpose register.  However, this only tells you the silicon
> > revision, which can have the same value even if the processors are
> > different!
> >
> > Does the processor type (e.g. 862, 857T, 857DSL) reside anywhere in the
> > processor?
>
> U-Boot/PPCboots cpu/mpc8xx/cpu.c contains a lot of generic type
> detection code, but even there the assumes that the basic type is
> known at compile time.
>
> Regards,
> Marius
>
> ---------------------------------------------------------------------------
>-- Marius Groeger           SYSGO Real-Time Solutions AG
> mgroeger@sysgo.de Software Engineering     Embedded and Real-Time Software
>   www.sysgo.de Voice: +49-6136-9948-0   Am Pfaffenstein 14
> www.osek.de FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany
> www.elinos.com
>
- --

Leonardo Pereira Santos
Engenheiro de Projetos
PD3 Tecnologia
av. Pará 330/202
(51) 3337 1237

Today Fortune tells us:
Are you scared of speed? If so, try Windows NT.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
