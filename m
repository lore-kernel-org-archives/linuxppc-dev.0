Message-ID: <20000928053628.1115.qmail@dag.newtech.fi>
To: greyham@research.canon.com.au (Graham Stoney)
cc: dag@newtech.fi (Dag Nygren), linuxppc-embedded@lists.linuxppc.org,
        dag@newtech.fi
Subject: Re: Crosscompiler broken ? 
In-Reply-To: Message from greyham@research.canon.com.au (Graham Stoney)
   of "Thu, 28 Sep 2000 10:58:28 +1100." <20000927235828.E93B5ED@elph.research.canon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Sep 2000 08:36:28 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Dag Nygren writes:
> > The  compilation of the kernel is done with a crosscompiler
> > on an Intel x86 system and strange things are happening:
>
> What version of the compiler and kernel are you using?

Sorry, should of course have included that:
Compiler: 2.95.1
Kernel: 2.2.15

>
> > printk("dentry_hashtable(0.5)(addr = 0x%lx) = 0x%lx\n", &dentry_hashtable,
> > dentry_hashtable);   /* DEBUG */
>
> I couldn't reproduce this problem.  However, you might want to get into the
> habit of using the correct format specifiers.  It doesn't make a difference in
> this instance, but it will trip you up eventually.  Use %p to print pointers,
> not %lx.

Yep, changed that later on and it really makes no difference.
The %lx comes from a time when I learned C-programming,
at that point there were no %p in printf() etc.

Also upgraded to 2.95.2. No change.

BRGDS


--
Dag Nygren                               email: dag@newtech.fi
Oy NewTech Ab                            phone: +358 9 8024910
Trasktorpet 3                              fax: +358 9 8024916
02360 ESBO                                 GSM: 0400-426312
FINLAND


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
