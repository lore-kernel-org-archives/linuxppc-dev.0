Message-Id: <20010920201330.Postino-024975@smtp01.highway.ne.jp>
Date: Thu, 20 Sep 2001 20:13:30 +0900
To: MATSUURA Takanori <t-matsuu@protein.osaka-u.ac.jp>
Cc: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: 2.4.10-pre12 sysrq.c compile error
In-Reply-To: <20010920.201024.730567552.t-matsuu@protein.osaka-u.ac.jp>
References: <200109200500.AAA17467@lists.linuxppc.org>
 <20010920.201024.730567552.t-matsuu@protein.osaka-u.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: MATSUURA Takanori <t-matsuu@protein.osaka-u.ac.jp>
To: linuxppc-dev@lists.linuxppc.org

> > of `wakeup_bdflush'
> > make[3]: *** [sysrq.o] Error 1
> > make[3]: Leaving directory `/usr/src/linuxppc_2_4/drivers/char'
> > make[2]: *** [first_rule] Error 2
> > make[2]: Leaving directory `/usr/src/linuxppc_2_4/drivers/char'
> > make[1]: *** [_subdir_char] Error 2
> > make[1]: Leaving directory `/usr/src/linuxppc_2_4/drivers'
> > make: *** [_dir_drivers] Error 2
>
> `wakeup_bdflush' was defines in two defrent files.
>
> linuxppc_2_4_devel/drivers/char/sysrq.c (line: 35)
> extern void wakeup_bdflush(int);
>
> linuxppc_2_4_devel/include/linux/fs.h (line: 1347)
> extern void wakeup_bdflush(void);
>

if it's same extern , it's no problem.
Different paramenter is no good.

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
