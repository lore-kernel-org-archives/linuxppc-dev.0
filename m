Message-ID: <3ACD61A4.F04B1AF3@ipno.in2p3.fr>
Date: Fri, 06 Apr 2001 08:26:45 +0200
From: xav <grave@ipno.in2p3.fr>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: How to find information for the Raven Chip ?
References: <Pine.HPX.4.10.10103191008020.13151-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:

> On Mon, 12 Mar 2001, xav wrote:
>
> >
> > Hi,
> >
> > After I have followed the Matt's advice, I was able
> > to request irq for my tundra universe chip on my 2303
> > board (with 2.4.2 kernel from bk tree). But when I enable vme
> > irq 6 on it : it seems that this irq is always on (no problem with
> > others vme irq). Where can I look for the
> > information about level/edge in the Raven chip ?
>
> If the problem is only with one of the VME irqs, it is likely a stuck IRQ
> line on the vme bus or a faulty interface on the MVME board. All
> enabled VME irq trigger the same PCI irq (LIRQ0 on the PCI side).
>
> Either this or you have a RORA interrupt that you don't clear properly.
>
>         Regards,
>         Gabriel.

Hi !

The problem was an hardware one...
I just move the mvme2301 board from slot 0 to 2 and now everything works
fine : interrupt, A16/A24 and A32 reads and writes.

Thanks for the help...

O+ xavier


--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
