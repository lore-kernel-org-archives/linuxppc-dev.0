Message-Id: <20010921001918.Postino-011488@smtp01.highway.ne.jp>
Date: Fri, 21 Sep 2001 00:19:18 +0900
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: 2.4.10-pre12 sysrq.c compile error
In-Reply-To: <p04330104b7cfaa0a7830@[63.220.231.138]>
References: <200109200500.AAA17467@lists.linuxppc.org>
 <20010920.201024.730567552.t-matsuu@protein.osaka-u.ac.jp>
 <20010920201330.Postino-024975@smtp01.highway.ne.jp>
 <p04330104b7cfaa0a7830@[63.220.231.138]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Stefan Jeglinski <jeglin@4pi.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.10-pre12 sysrq.c compile error
Date: Thu, 20 Sep 2001 10:52:13 -0400

>
> >  > `wakeup_bdflush' was defines in two defrent files.
> >>
> >  > linuxppc_2_4_devel/drivers/char/sysrq.c (line: 35)
> >>  extern void wakeup_bdflush(int);
> >>
> >>  linuxppc_2_4_devel/include/linux/fs.h (line: 1347)
> >>  extern void wakeup_bdflush(void);
> >>
> >
> >if it's same extern , it's no problem.
> >Different paramenter is no good.
>
> Right. I should have supplied more info about what I have tried.

Look at fs/buffer.c line2748 where the real function is in.
so That is void wakeup_bdflush(void)

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
