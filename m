Date: Mon, 14 May 2001 17:27:16 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel bug
Message-ID: <20010514172716.B31100@suse.de>
References: <20010513124601.A24522@kybl> <20010513191235.B12797@suse.de> <20010513134800.A7905@kybl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010513134800.A7905@kybl>; from tjura@binghamton.edu on Sun, May 13, 2001 at 01:48:00PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, May 13, Tomas Jura wrote:

>
> On Sun, May 13, 2001 at 07:12:35PM +0200, Olaf Hering wrote:
> >
> > On Sun, May 13, Tomas Jura wrote:
> >
> > > HW: PPC G3 beige, 160 MB of memory, (CONFIG_HIGHMEM off)
> > > SW: Debian 2.2 unstable, kernel 2.2.5-pre1 (gcc 2.95.4)
> >
> > > Any ideas where is a mistake or how to solve it?
> >
> > Get the linux-2.2.19.tar.bz2 from your local kernel.org mirror.
> > 2.2.5 is pretty old or the second two is a typo ;)
> >
> I'm sorry typo... correction: 2.4.5-pre1 and 2.4.4-x
>
> One other thing which possibly can be a villain:
> With RAM I added extra video memory so total size is now 6MB. But
> dmesg shows:
> atyfb: 3D RAGE PRO (PQFP, PCI) [0x4750 rev 0x7c] 4M SGRAM,


Have a look at this text file:
http://penguinppc.org/~olaf/reporting_kernel_issues.txt

Does this show up in the OF tree? Some models have a memory* property in
/proc/device-tree/pci\@80000000/ATY,mach64*

But it seems that Mach64 ressource handling is currently a bit broken.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
