Date: Tue, 16 Nov 1999 07:52:49 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Andreas Tobler <a.tobler@schweiz.ch>
cc: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel debugging??
In-Reply-To: <38314D32.91212445@schweiz.ch>
Message-ID: <Pine.LNX.4.10.9911160749360.21354-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



andreas,
	since you're on a powermac and using BootX, you can use
prom_print() to print debuging info before start_kernel, there after you
can just use printk().  instead of putting a million prints all over the
place, you should look at the patches between 2.3.25-2.3.28 and see what
was changed in ppc/kernel or ppc/mm , i've booted
2.3.25 on my 7200 but i have had no time lately to try 2.3.28, perhaps
later today i will work on it.



ani


On Tue, 16 Nov 1999, Andreas Tobler wrote:

> 
> Is there a possibility to debug the kernel, especially in its very early
> load stage?
> Is xmon the right tool to do so?
> My situation is a not booting 2.3.28 kernel. All I know is, that I pass
> at least the prom_init(). After that the screen stays black with the
> 'Welcome to kernel 2.3.28' and a few messages about addresses I think.
> And at the end it says 'booting... '
> (On a PM7200 and a Wallstreet I)
> 
> Any experiences around?
> 
> Thanks
> 
> Andreas
> -- 
> | Andreas Tobler				
> | CH-8004 Zuerich 							
> | E-Mail: andreas.tobler@alcatel.ch	| a.tobler@schweiz.ch
> -----------------------------------------------------------
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
