Message-Id: <200005162039.WAA00813@piglet.grunz.lu>
Date: Tue, 16 May 2000 22:39:32 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Promise Ultra/66
To: spiette@generation.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000516133216.A760@xim.bellglobal.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On  16 May, this message from Simon Piette echoed through cyberspace:
>
> Hi,
>
> I'm currently trying to get working a Promise Ultra/66 (BIOS v 1.14) on
> a 2.2.12 kernel and/or a 2.2.15 kernel both from kernel.org, as Michael
                                                                  ^^^^^^^
Make that Michel, but never mind ;-)

> Lanners used those. I would like to have it to work on a Umax J700/180
> (the actual machine) and a StarMax 3200/240
>
> For the former (2.2.12 kernel), I got the ide-2.2.12 patch form Andre
> Hedrick (http://www.kernel.org/pub/linux/kernel/people/hedrick)
> and applied the patch from Michael Lanners
> (http://lists.linuxppc.org/listarcs/linuxppc-dev/199909/msg00146.html)

Forget about these old patches. Go to my PCI page:

http://www.cpu.lu/~mlan/linux/dev/pci.html

and get yourself my latest patches for either 2.2.15 (kernel.org) or
2.3.99-pre7 (linuxcare.au) kernels. For 2.2.15, you need Andre's patches
in addition to mine. Apply his IDE patches first.

Have fun!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
