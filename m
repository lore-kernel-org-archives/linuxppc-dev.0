Subject: Re: Crosscompiler broken ?
To: dag@newtech.fi (Dag Nygren)
Date: Thu, 28 Sep 2000 10:58:28 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20000927121938.2547.qmail@dag.newtech.fi> from "Dag Nygren" at Sep 27, 2000 03:19:38 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000927235828.E93B5ED@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dag Nygren writes:
> The  compilation of the kernel is done with a crosscompiler
> on an Intel x86 system and strange things are happening:

What version of the compiler and kernel are you using?

> printk("dentry_hashtable(0.5)(addr = 0x%lx) = 0x%lx\n", &dentry_hashtable,
> dentry_hashtable);   /* DEBUG */

I couldn't reproduce this problem.  However, you might want to get into the
habit of using the correct format specifiers.  It doesn't make a difference in
this instance, but it will trip you up eventually.  Use %p to print pointers,
not %lx.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
