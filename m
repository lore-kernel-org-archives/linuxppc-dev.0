Date: Mon, 19 Mar 2001 10:10:49 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: xav <grave@ipno.in2p3.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: How to find information for the Raven Chip ?
In-Reply-To: <3AAC909F.9DE40CC9@ipno.in2p3.fr>
Message-ID: <Pine.HPX.4.10.10103191008020.13151-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 12 Mar 2001, xav wrote:

>
> Hi,
>
> After I have followed the Matt's advice, I was able
> to request irq for my tundra universe chip on my 2303
> board (with 2.4.2 kernel from bk tree). But when I enable vme
> irq 6 on it : it seems that this irq is always on (no problem with
> others vme irq). Where can I look for the
> information about level/edge in the Raven chip ?

If the problem is only with one of the VME irqs, it is likely a stuck IRQ
line on the vme bus or a faulty interface on the MVME board. All
enabled VME irq trigger the same PCI irq (LIRQ0 on the PCI side).

Either this or you have a RORA interrupt that you don't clear properly.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
