Message-Id: <199906142121.XAA04254@denx.muc.de>
To: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
Cc: linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.muc.de>
Subject: Re: cache line size (was Help booting MBX through bootd) 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Jun 1999 15:21:07 +0200."
             <376501C2.FAF2B207@switchboard.ericsson.se>
Date: Mon, 14 Jun 1999 23:21:47 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <376501C2.FAF2B207@switchboard.ericsson.se> you write:
> 
> > But the cache line size differs even for different models of the  8xx
> > family!
> 
> Are you sure?

Well, yes. But not exact enough. I silently included the 82x0 in  the
8xx family.

> I browsed my 821, 823, 850 and 860 manuals and I found out that Motorola
> seem to have 2 different cpu cores.
> 
> budget   core: 850/823 - 8/8 TLBs, 2/1 Kbyte cache.
> standard core: 860/821 - 32/32 TLBs, 4/4 Kbyte cache.
> deluxe   core: 860P    - 32/32 TLBs, 16/8 Kbyte cache
> 
> All seem to have 4 words a 32 bits in each cache line.

You are right.

> What about the other cpus; 60x, 750/740?

32 bytes per cache line = 8 32-bit words

> And the other embedded ones; 8240/8260?
> 
> 8 words a 32 bits in each cache line? 

Yes, the 82x0 have 8 32-bit words in each line.

Wolfgang Denk

-- 
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If you think the problem is bad now, just wait until we've solved it.
                                                        Epstein's Law

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
