To: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] Re: EV-64260-BP & GT64260 bi_recs 
In-Reply-To: Message from msokolov@ivan.Harhan.ORG (Michael Sokolov)
   of "Sun, 24 Mar 2002 22:47:19 PST." <0203250647.AA26997@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Mar 2002 18:44:31 +1100
Message-ID: <17636.1017042271@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 24 Mar 02 22:47:19 PST, msokolov@ivan.Harhan.ORG (Michael Sokolov) writes:
>It is wrong. Every platform in 2_4_devel my hacky hands have touched uses
>bi_recs exclusively. bi_recs work very well for me as they are right now.

Which part of "very limited and only used by certain platforms" is wrong? OK,
maybe its half-and-half then (half the platforms use them, half don't) - that's
a long way from all platforms. The proposal is that 2.5 use bi_recs exclusively
for all platforms (something I agree with, by the way). The discussion is in the
detail of the implementation.

>For me it has been ironed out perfectly a long time ago, which is why I haven't
>participated much in that "discussion".

Well, you'd better get involved then - because the proposal is to change them
(or maybe "extend slightly in a backwards compatible way", would better describe
it) so if they're perfect for you now, you wouldn't want this :-) I think they
are too limited at the moment, but could be very useful if implemented properly.
benh's current proposal appears to give me all that I want (except for some
formal definition of "dimension"), so I support it. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
