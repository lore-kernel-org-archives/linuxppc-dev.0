Mime-Version: 1.0
Message-Id: <p04330104b7cfaa0a7830@[63.220.231.138]>
In-Reply-To: <20010920201330.Postino-024975@smtp01.highway.ne.jp>
References: <200109200500.AAA17467@lists.linuxppc.org>
 <20010920.201024.730567552.t-matsuu@protein.osaka-u.ac.jp>
 <20010920201330.Postino-024975@smtp01.highway.ne.jp>
Date: Thu, 20 Sep 2001 10:52:13 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: 2.4.10-pre12 sysrq.c compile error
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > `wakeup_bdflush' was defines in two defrent files.
>>
>  > linuxppc_2_4_devel/drivers/char/sysrq.c (line: 35)
>>  extern void wakeup_bdflush(int);
>>
>>  linuxppc_2_4_devel/include/linux/fs.h (line: 1347)
>>  extern void wakeup_bdflush(void);
>>
>
>if it's same extern , it's no problem.
>Different paramenter is no good.

Right. I should have supplied more info about what I have tried.

I attempted to make everything consistent each way. IOW, I have made
the function definition and extern declarations all with a void
argument, and also all with an int argument. In one case, the
compiler error is "too many arguments in wakeup_bdflush" and in the
other case the compiler error is "too few arguments in
wakeup_bdflush".

I have noted numerous instances of wakeup_bdflush() and
wakeup_bdflush(0) but I'm not sure this is an issue.

There's an inconsistency here that first appeared straightforward to
me but now I'm not sure of the changes that are needed.

I rsynced this morning but still the same result.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
