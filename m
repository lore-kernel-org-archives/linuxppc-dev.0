To: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] Re: EV-64260-BP & GT64260 bi_recs 
In-Reply-To: Message from msokolov@ivan.Harhan.ORG (Michael Sokolov)
   of "Sun, 24 Mar 2002 20:31:55 PST." <0203250431.AA26633@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Mar 2002 17:30:51 +1100
Message-ID: <17181.1017037851@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 24 Mar 02 20:31:55 PST, msokolov@ivan.Harhan.ORG (Michael Sokolov) writes:
>I'm very very glad that 2_4_devel doesn't use the bd_info crap and uses bi_recs
>instead. If PPCBoot can't handle that, it's PPCBoot's problem. There is more to
>the world than PPCBoot. StarMON rules!

2_4_devel does "use the bd_info crap". It is my impression that bi_recs support
in 2_4_devel is very limited and only used by certain platforms, so you could
safely say that it doesn't use bi_recs (correct me if this is wrong - I don't
know all the other platforms intimately). The whole huge discussion on this very
list recently (with exactly this same subject line) has been to determine how
best to get rid of "the bd_info crap" and only use bi_recs. I'm sure as soon as
this is ironed out, ppcboot will easily support bi_recs (there you go Wolfgang -
I saved you having to respond to this :-). Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
