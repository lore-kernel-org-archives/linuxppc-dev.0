Date: Mon, 22 Jan 2001 23:15:31 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Jeff Hartmann <jhartmann@valinux.com>
cc: Dan Malek <dan@mvista.com>, michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <3A6CAAA2.6090607@valinux.com>
Message-ID: <Pine.GSO.4.10.10101222313030.26323-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, 22 Jan 2001, Jeff Hartmann wrote:

> > Ummm...of course it is virtually contiguous.  How could it be
> > different?  You request a size, and it returns a base virtual address.
> > If there were holes in it, how would you know?
>
> Look at vread in vmalloc.c, I think it would handle holes in a
> vmalloc'ed area (From a brief reading of the code.)  I've seen postings
> about this on linux-kernel.  I don't see a vwrite implementation, but I
> would assume you would have to do something similar for writes.

Between two vmalloced areas is of course a hole to catch overflow errors.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
