Date: Mon, 22 Jan 2001 23:48:08 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Dan Malek <dan@mvista.com>
cc: Roman Zippel <zippel@fh-brandenburg.de>,
        Jeff Hartmann <jhartmann@valinux.com>, michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <3A6CEF13.1F868277@mvista.com>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010122234414.52936A-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 22 Jan 2001, Dan Malek wrote:

> > .....  I
> > wonder why planb works at all....
>
> Probably because no one stumbles across the memory it is trashing?
> Currently, bad_thing_will_happen = vmalloc + virt_to_bus + dma.
> It could be with the right memory size, modulo addressing, memory
> controller configuration, timing of the vmalloc, it just may
> accidently work.  If this is the case, I would be out buying
> lottery tickets........

Ok, my apologies, planb doesn't use vmalloc at all these days.  So, there
is no problem of that kind.  (In the beginning, it had vmalloc with a lot
of problems as I recall now.)


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
