Date: Sat, 5 May 2001 10:01:05 -0700 (PDT)
From: Paul White <pwhite@networkrobots.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Modules on 2.4.0 PPC Linux
In-Reply-To: <Pine.LNX.4.21.0105050940010.13276-100000@stimpy.networkrobots.com>
Message-ID: <Pine.LNX.4.21.0105050959500.13276-100000@stimpy.networkrobots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

I believe I found my problem...   I am compiling the kernel and modules on an X86 Linux machine, and it
is unable to run depmod -ae.   I have to run this on the PPC platform after everythings intsalled.

Thanks...

However as another question, is anyone currently running IP Connection Tracking and Net Filters (IPTables)
on PPC?

Thanks,

Paul W.

On Sat, 5 May 2001, Paul White wrote:

>
> All,
>
> I currently have 2.4.0 working on a PPC 7400 embedded board,
> however modules do not seem to be working.  When I attempt
> to load a modules, I receive several unresolved symbols,
> including printk(), schedule(), sk_free(), kmem_cache_alloc(),
> etc..  Since these are all global functions always compiled
> in, they should be found.
>
> Anyone have any ideas?
>
> Thanks....
>
> Paul W.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
