From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
Date: Sat, 20 Jan 2001 17:00:27 +0100
Message-Id: <19341215093211.9503@smtp.wanadoo.fr>
In-Reply-To: 
 <Pine.LNX.4.30.0101201420040.18939-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.30.0101201420040.18939-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Very hard work indeed :) You'd have to write a mecanism to let most of
>> the OHCI controller code to run in a polled way from within the
>> debugger... quite nasty.
>
>Why? How's that different from ADB keyboards? It just won't work when
>interrupts are dead ;-)

xmon can poll the keyboard without any interrupts on Cuda & PMU machines
by sending the appropriate Cuda or PMU command to the chip and doing
polled IOs. On USB, it's also possible to poll the interrupt status
register of the OHCI chip. But it's a lot more painful since you have to
run most of the USB stack this way.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
