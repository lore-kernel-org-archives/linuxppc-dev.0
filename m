Date: Wed, 28 Jun 2000 14:27:18 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Steven Hanley <sjh@wibble.net>
cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: problem with compressing the kernel
In-Reply-To: <3959E550.3CC61CD@wibble.net>
Message-ID: <Pine.HPX.4.10.10006281352560.5670-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Jun 2000, Steven Hanley wrote:

> the output is dictated by the command you use to make the kernel, and
> the setup in the makefile.

Indeed.

>
> > so please don't claim that it is x86 specific without checking the facts
> > first.
>
> it is specific in that x86 is braindead enough that for years the option
> was necessary, I am unsure if x86 still needs the compressed image
> (anyone?) however as has been pointed out you may use compressed images
> on other architectures. I still strongly suspect the person asking on a
> ppc list how to compress a kernel for linux on an NT box was somewhat
> confused at least.

Try to build a ppc boot floppy without compression (of for any achitecture
if you have enough drivers).

> > This looks more like a documentation error. Nowadays you can get your
> > sources with bzip2, but for very long gzip/gunzip was an implicit
> > prerequisite to uncompress the kernel tarball (and the patches), otherwise
> > you could not even have a look at the requirements. Chicken and egg...
>
> not at all, this list is in the kernel tree, it has nothing to do with
> what format you get your kernel in, (rsync or cvs are common, you may
> notice, as examples of retrival of both patch updates and full kernel
> updates that have no need of gzip (ignoring that both can have and
> commonly do have, zlib compiled in and use it during transfer) the
> Changes file lists what utilities/tools are needed to actually compile
> the kernel. There is no need for bzip2 or gzip in the compilation
> process.

Not in the compilation, but since when do you use
cvs/rsync/bitkeeper/whatever ?

The official source tree (the mirrors of ftp.kernel.org) is still only
available as gz and more recently with bz2. So historically gzip has been
a prerequisite to look at the kernel source and build your kernel, that's
all what I claimed (did you use Linux and build your kernels from
ftp.funet.fi in 1995 ?).

For my needs I only use ftp.kernel.org kernels with my own patches since I
was severely burnt the day vger cvs disappeared, but that's clearly a
personal choice (simply that I don't trust anything else anymore).

>
> > > And of course remember you dont need otr use compressed images on ppc
> > > machines.
> >
> > I do need them. Not all PPC machines are macs, it seems :-)
>
> well if the hardware is embedded or similarly lacking in space as
> someone suggested I can understand the need, or possible x86. Otherwise
> I would be surprised if the hardware cant handle large images. There is
> a difference between "need" and "common use"

The HW/FW I have can handle fairly large images (several Mb at least),
floppies may have trouble however and I prefer to transfer smaller images
for network loads (besides the fact that the raw vmlinux will never boot
on my machines, I need to setup the HW through a first stage loader in a
way the kernel likes before giving it control).

That's common use BTW, there are probably more PPC processors running
Linux in embedded environments than in PowerMacs. Besides that, you
claimed that "you don't need to use compressed images on PPC machines"
which is definitely wrong without knowing the kind of machine and of boot
media.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
