Date: Wed, 28 Jun 2000 11:05:08 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Steven Hanley <sjh@wibble.net>
cc: Rolf Liu <rolfl@sc23.sc.mcel.mot.com>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: problem with compressing the kernel
In-Reply-To: <395998E0.65DD0D9B@wibble.net>
Message-ID: <Pine.HPX.4.10.10006281021160.5670-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Jun 2000, Steven Hanley wrote:

> you seem to be confused anyway, yes the kernel is compressed for x86
> machiens (it is however not compressed for other architectures, my ppc
> box uses a normal uncompresased vmlinux image.

Perhaps on a Mac, but _all_ the kernels I have ever built for _all_ my PPC
machines have _always_ been compressed, without a _single_ exception.
Browsing the tree you'll easily find that there the kernel image is
compressed (maybe depending on some CONFIG option) on:

- alpha
- arm
- i386
- m68k
- ppc

so please don't claim that it is x86 specific without checking the facts
first.

> Now of course I wonder why you would need the ability as after all a
> linux box is all you need to compile and make the image, or heck a
> compatible gcc on any unix can in theory compile the kernel, the utility
> to compress and uncompress the kernel is in the source tree so long as
> you can compile the source tree it should work fine. gzip is not listed
> as a requirement in kernel compiling in the file
> /usr/src/linux/Documentation/Changes for this reason, if you can compile
> the kernel on a machine it can create the compressed images if needed.

This looks more like a documentation error. Nowadays you can get your
sources with bzip2, but for very long gzip/gunzip was an implicit
prerequisite to uncompress the kernel tarball (and the patches), otherwise
you could not even have a look at the requirements. Chicken and egg...

>
> And of course remember you dont need otr use compressed images on ppc
> machines.

I do need them. Not all PPC machines are macs, it seems :-)

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
