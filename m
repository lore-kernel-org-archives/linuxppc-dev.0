Mime-Version: 1.0
Message-Id: <p04330101b7d054dd6b49@[24.25.18.230]>
In-Reply-To: <20010921002626.Postino-000284@smtp01.highway.ne.jp>
References: <200109200500.AAA17467@lists.linuxppc.org>
 <20010920.201024.730567552.t-matsuu@protein.osaka-u.ac.jp>
 <20010920201330.Postino-024975@smtp01.highway.ne.jp>
 <p04330104b7cfaa0a7830@[63.220.231.138]>
 <20010921002626.Postino-000284@smtp01.highway.ne.jp>
Date: Thu, 20 Sep 2001 22:26:10 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: 2.4.10-pre12 sysrq.c compile error (solved)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks, Kaoru!

Sorry, no patch yet. I'll do one if my next rsync doesn't have it fixed :-)

All extern declarations should be

	extern void wakeup_bdflush(void);

definition should be:

	void wakeup_bdflush(void);

and all calls should be:

	wakeup_bdflush();



Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
