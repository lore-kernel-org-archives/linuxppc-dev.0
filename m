Date: Thu, 25 Jan 2001 22:40:11 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
cc: Roman Zippel <zippel@fh-brandenburg.de>, mgreer@mvista.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC
In-Reply-To: <3A708795.9D627FE9@mvista.com>
Message-ID: <Pine.HPX.4.10.10101252211170.22074-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 25 Jan 2001, Dan Malek wrote:

> Gabriel Paubert wrote:
>
> > ..... Has anybody
> > any docs on how the MMU has been modified to handle the extra bits on the
> > 7450.
>
> Yes, I have one and I am working on it.  Although I have been spending
> time at the lower end of the processor scale, my changes are directly
> applicable to the 7450 enhancements as well.  Of course, we then
> have the "common kernel" problem :-).  If I build something to
> take advantage of the 7450 enhancements, it may not boot on other
> systems.

If you build an x86 kernel for 36 bit extension, it won't either boot on
earlier processors, and page tables are twice the size for 1/8 increase
in the number of address bits.

>
> > The only port which is simple is the 68k
>
> Lots of people complain about it, but I'll agree the 68k MMU
> design and supporting instructions is still the best.

It was rather clean, except for the fact that it changed too much between
processors: 68020/68030/68040 are all different. I think
MMU[68060]==MMU[68040] but that's about all (never had a 68060).

>
> > ...... Using such a simple trick for processors which do not allow
> > to (easily or not) access alternate address spaces is not an option.
>
> You can easily make the PowerPC have this same alternate address
> design.  Either people forget or have never known the value of these
> large virtual alternate address space designs, and simply jump to
> the common space design we have in Linux.

Yes, I am aware of this and have been thinking on this for about one year.
Just never had time to write it and my plans are actually more ambitious.
I'm getting two Macs to play on (one from the institute and a notebook for
me) from next week so I can test PMAC/Prep/CHRP. I wanted to first work on
a common zImage for all these machines however, because it was necessary
for a few other things that I have in mind. But I'm only doing this in my
copious (cough) spare time (with a wife, a 3 year old son and a second one
coming soon).

The MM design of which Linus is so proud is actually not well suited to
6xx/7xx processors. Can't speak about high end IBM processors.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
