Date: Sun, 13 May 2001 13:48:00 -0400
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel bug
Message-ID: <20010513134800.A7905@kybl>
References: <20010513124601.A24522@kybl> <20010513191235.B12797@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010513191235.B12797@suse.de>; from olh@suse.de on Sun, May 13, 2001 at 07:12:35PM +0200
From: Tomas Jura <tjura@binghamton.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, May 13, 2001 at 07:12:35PM +0200, Olaf Hering wrote:
>
> On Sun, May 13, Tomas Jura wrote:
>
> > HW: PPC G3 beige, 160 MB of memory, (CONFIG_HIGHMEM off)
> > SW: Debian 2.2 unstable, kernel 2.2.5-pre1 (gcc 2.95.4)
>
> > Any ideas where is a mistake or how to solve it?
>
> Get the linux-2.2.19.tar.bz2 from your local kernel.org mirror.
> 2.2.5 is pretty old or the second two is a typo ;)
>
I'm sorry typo... correction: 2.4.5-pre1 and 2.4.4-x

One other thing which possibly can be a villain:
With RAM I added extra video memory so total size is now 6MB. But
dmesg shows:
atyfb: 3D RAGE PRO (PQFP, PCI) [0x4750 rev 0x7c] 4M SGRAM,
                                                 ^^^^^^^^
Tomas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
