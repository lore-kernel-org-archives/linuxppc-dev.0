Date: Sun, 24 Mar 02 22:47:19 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203250647.AA26997@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Murray Jensen <Murray.Jensen@cmst.csiro.au> wrote:

> 2_4_devel does "use the bd_info crap".

Thankfully not for EV-64260 or any other almost-non-embedded 6xx/7xx/74xx
systems, only for 4xx/8xx/82xx stuff that's completely off my radar screen for
now and probably for the foreseeable future.

> It is my impression that bi_recs support
> in 2_4_devel is very limited and only used by certain platforms, so you could
> safely say that it doesn't use bi_recs (correct me if this is wrong - I don't
> know all the other platforms intimately).

It is wrong. Every platform in 2_4_devel my hacky hands have touched uses
bi_recs exclusively. bi_recs work very well for me as they are right now.

> The whole huge discussion on this very
> list recently (with exactly this same subject line) has been to determine how
> best to get rid of "the bd_info crap" and only use bi_recs. I'm sure as soon as
> this is ironed out, [...]

For me it has been ironed out perfectly a long time ago, which is why I haven't
participated much in that "discussion".

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
