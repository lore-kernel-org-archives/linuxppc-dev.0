Date: Fri, 2 Feb 2001 09:53:06 +1100
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: agpgart? or how to use dri?
Message-ID: <20010202095306.A7859@chiru.svana.org>
Reply-To: Steven Hanley <sjh@wibble.net>
References: <20010201184806.A5957@chiru.svana.org> <19341227050123.16989@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19341227050123.16989@mailhost.mipsys.com>; from bh40@calva.net on Thu, Feb 01, 2001 at 12:29:39PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 01, 2001 at 12:29:39PM +0100, Benjamin Herrenschmidt wrote:
> The current agpgart driver won't work on PPC, the Apple AGP host bridge
> is not supported.

so I guessed

> The new DRI support announced by Gareth is using the PCI GART which
> doesn't need the AGP capabilities.

makes sense

> Don't enable either AGP or DRI in your
> kernel, and build the kernel r128 DRM module from XFree sources.

I didnt, but as mentioned when I dont have AGP gart enabled in the kernel
make in the kernel module directory in the X Free source tree only makes
tdfx, it fdoesnt do r128 or anything else.

> You need
> to use the CVS branch posted earlier by Gareth.

I am using that branch.

> I slightly hacked my own
> to build since I lack the glide libs necessary for the 3dfx stuff to compile.

what does glide have to do with this? isnt that only used with tdfx?

So where do I find out about pci gart and how to make the r128 driver
compile using it? Should I simply read through the Makefil and the r128 code
and ifnd the stuff related to pci gart and enable anything there possibly
turned off or some such?

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh
Look Up In The Sky
    Is it a bird?   No
        Is it a plane    No
            Is it a small blue banana?
Yes

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
