Date: Mon, 22 Jan 2001 23:31:11 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
cc: Jeff Hartmann <jhartmann@valinux.com>, michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <3A6CA6A9.7794B603@mvista.com>
Message-ID: <Pine.GSO.4.10.10101222326300.26751-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, 22 Jan 2001, Dan Malek wrote:

> > ......  Currently there is no kernel function to do
> > this explicitly
>
> I'm working on that.  The PowerPC port cheated by using BATs and
> trivial macros, but this doesn't work on some of the newer processors
> and more complex applications.  Other architectures did the same, and
> I am surprised there aren't generic kernel functions to track down this
> information.  In fact, these functions are already present for 4xx and
> 8xx processors, so don't write anything new.

AFAIK such tricks are used for mapping normal (low) memory and ioremapped
areas. For normal memory you can use phys_to_virt()/virt_to_phys() and for
ioremapped memory, you have to store the physical and virtual address
yourself. What am I missing?

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
