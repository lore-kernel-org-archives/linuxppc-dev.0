From: unit@panix.com
Date: Sat, 22 Jan 2000 00:45:21 -0500 (EST)
To: Mario Scarpa <m.scarpa@mondonet.net>
cc: PPC-DEV <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel Q
In-Reply-To: <3888F3DC.2B506EDC@mondonet.net>
Message-ID: <Pine.SUN.4.21.0001220031020.623-100000@panix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 21 Jan 2000, Mario Scarpa wrote:

--snip--

> When are we going to get the kernel source and have it compile
> out of the box without wandering around patches, broken
> dependencies and other glue ?
> Every time I try to compile the kernel on my Lombard PB I
> end up with something that - in the best case - bootstraps
> but lacks always something (X working only at 16bpp, the
> sound card or the modem not seen and so on...) and often
> just panics at IDE recognition...
> I mean, I don't want to get my ultranew PCI microwave owen
> recognized: I just would like to compile this fucking multicast
> support into a working kernel :-(

i have been compiling kernels on a pb walls (not too dissimilar
arch) since 2.2pre4 with next to no trouble. X has been solid at 32bpp,
(had some small problems with XFree86-3.3.5 that where resolved quickly).
I can only think of one occasion when a kernel has not booted (a 2.3.x).

cal-s


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
