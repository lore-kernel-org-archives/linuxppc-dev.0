Message-ID: <3C9A301A.5B1B14DE@mvista.com>
Date: Thu, 21 Mar 2002 14:10:18 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] Re: EV-64260-BP & GT64260 bi_recs
References: <0203200102.AA08371@ivan.Harhan.ORG> <20020321141524.U6003@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes wrote:

> FYI, the gt eth driver is completely busticated for SMP. I managed to get
> zuma's mpsc driver working on SMP by turning on snooping. (this may be the
> 'wrong' thing to do , but it works for now)

I haven't looked at the zuma version of the drivers but the ones inherited from
marvell need to be dumped and completely rewritten...and made SMP-safe.  Its been
on my list but I haven't gotten around to do that.  If/when I do, I'll look at what
Nye, et. al. has done first.  They may have all the issues settled already.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
