Date: Wed, 17 Nov 1999 12:15:58 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: again 2.3.28
In-Reply-To: <Pine.LNX.4.05.9911172048000.25661-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.9911171209470.5504-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 17 Nov 1999, Geert Uytterhoeven wrote:

> Probably it depends on the machine, since I get up to free_all_bootmem(), which
> is called by mem_init() in start_kernel(). OK, I have a different box (CHRP)
> and was actually speaking about 2.3.27, but the 2.3.28 patch doesn't contain
> relevant changes.

	could your problem in free_all_bootmem() be caused by
"if(!bootmem_map) BUG();"?  because in do_init_bootmem()
it frees the bootmem bitmap (which is called very early).  
is it trying to free something thats already been free'd?

its possible this is happening on pmacs also...


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
