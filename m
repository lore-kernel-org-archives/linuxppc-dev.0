To: None Atall <linux_meis@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Linux-ATM-General] Re: ATM driver for 8260 (linux 2.4.x) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 29 Jan 2002 06:23:21 PST."
             <20020129142321.38639.qmail@web9706.mail.yahoo.com>
Date: Tue, 29 Jan 2002 16:55:06 +0100
Message-Id: <20020129155511.670E1109D5@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020129142321.38639.qmail@web9706.mail.yahoo.com> you wrote:
>
> For some reason the interrupt handler reads old
> values, although the CPM puts new data. (I checked it

Sounds like a cache problem...

> using JTAG). It seems
> like the old data are kept on buffers and are not
> refreshed. Unfortunetely i did what Hofrat saied,
> but it doesn't work. Is there a function for forcing
> refresh? flush_tlb or flush_dcache perhaps?

flush_dcache_range().

> > > Also, in the original driver Alex used the
> > > mm_alloc_uncached_pages function, but i have
> > replased
> > > it with kmalloc(size, GFP_KERNEL). Is it correct?

Hint! Hint!

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
As far as we know, our computer has never had an undetected error.
		                                           -- Weisert

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
