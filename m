Message-ID: <38318048.B414DC12@schweiz.ch>
Date: Tue, 16 Nov 1999 17:03:20 +0100
From: Andreas Tobler <a.tobler@schweiz.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Ani Joshi <ajoshi@shell.unixbox.com>
CC: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel debugging??
References: <Pine.LNX.4.10.9911160749360.21354-100000@shell.unixbox.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ani,

Ani Joshi wrote:
> 
> andreas,
>         since you're on a powermac and using BootX, you can use
> prom_print() to print debuging info before start_kernel, there after you

This what I'm doing now.
But I feel a bit lost when it goes into asm.

> can just use printk().  instead of putting a million prints all over the
> place, you should look at the patches between 2.3.25-2.3.28 and see what
> was changed in ppc/kernel or ppc/mm ,

This I also did, on the mm side do I have to include both mm and
arch/ppc/mm?
Here many changes happened.

> i've booted 2.3.25 on my 7200 
And I could boot a stock 2.3.26 with changes in asm-ppc/fcntl.h
(O_LARGEFILE ....)

>but i have had no time lately to try 2.3.28, perhaps
> later today i will work on it.

On my side it's mostly a question of learning, a fixed problem is nice,
a self found and fixed problem is even nicer :-)

Thanks for your hints

Andreas

-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail: andreas.tobler@alcatel.ch	| a.tobler@schweiz.ch
-----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
