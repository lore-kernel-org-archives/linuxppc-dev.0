Message-ID: <3935145C.DE1F478D@mandrakesoft.com>
Date: Wed, 31 May 2000 09:32:12 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Josh Huber <huberj@wpi.edu>
CC: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lite-On ethernet controller
References: <20000531090215.A652@mclinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Josh Huber wrote:
>
> I have what appears to be a Lite-On ethernet controller, which is supported
> by the tulip driver. What it really is, is a Asante FriendlyNET card. I had
> heard that the card works in 2.2.14+, but I'm having trouble getting it to
> work in later kernels (devel).
>
> Because of the network driver interface change, I can't try out the newest
> tulip driver in 2.4pre.

I don't understand what you mean here.


> Does anyone know of forward-ported tulip drivers?

A tulip driver exists in the 2.4pre kernel.  Are you having problems
with that driver?


> The particular error I'm seeing only happens with moderate load -- pings and
> other light traffic work 100%.
>
> Error information:
> NETDEV WATCHDOG: eth1: transmit timed out
> Transmit timed out, status e4660000, CSR12 000050ca, resetting...
>
> Device information:
> tulip driver output:
> eth1: Lite-On PNIC-II rev 37 at 0x1c00, 00:00:94:C5:EF:FF, IRQ 30.

IRQ 30?  Is that ok for PPC?


> lspci -vv output attached because it's too wide.

No attachment...

	Jeff



--
Jeff Garzik              | Liberty is always dangerous, but
Building 1024            | it is the safest thing we have.
MandrakeSoft, Inc.       |      -- Harry Emerson Fosdick

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
