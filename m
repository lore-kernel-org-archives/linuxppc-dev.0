Date: Sat, 20 Jan 2001 18:03:48 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <19341215093211.9503@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.30.0101201759050.26573-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >> Very hard work indeed :) You'd have to write a mecanism to let most of
> >> the OHCI controller code to run in a polled way from within the
> >> debugger... quite nasty.
> >
> >Why? How's that different from ADB keyboards? It just won't work when
> >interrupts are dead ;-)
>
> xmon can poll the keyboard without any interrupts on Cuda & PMU machines
> by sending the appropriate Cuda or PMU command to the chip and doing
> polled IOs. On USB, it's also possible to poll the interrupt status

Yuck. Thanks for the clarification ... I always thought ADB was too messy
for this but should have checked the source...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
