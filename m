Date: Thu, 20 Sep 2001 20:10:24 +0900 (JST)
Message-Id: <20010920.201024.730567552.t-matsuu@protein.osaka-u.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.10-pre12 sysrq.c compile error
From: MATSUURA Takanori <t-matsuu@protein.osaka-u.ac.jp>
In-Reply-To: <200109200500.AAA17467@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: owner-linuxppc-dev@lists.linuxppc.org
Subject: Linux PPC Developer Digest V34 #19
Date: Thu, 20 Sep 2001 00:00:59 -0500

> Date: Wed, 19 Sep 2001 17:34:26 -0400
> From: Stefan Jeglinski <jeglin@4pi.com>
> Subject: 2.4.10-pre12 sysrq.c compile error
>
> rsynced mvista today, linuxppc_2_4:
>
> sysrq.c:35: conflicting types for `wakeup_bdflush'
> /usr/src/linuxppc_2_4/include/linux/fs.h:1347: previous declaration
> of `wakeup_bdflush'
> make[3]: *** [sysrq.o] Error 1
> make[3]: Leaving directory `/usr/src/linuxppc_2_4/drivers/char'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linuxppc_2_4/drivers/char'
> make[1]: *** [_subdir_char] Error 2
> make[1]: Leaving directory `/usr/src/linuxppc_2_4/drivers'
> make: *** [_dir_drivers] Error 2

`wakeup_bdflush' was defines in two defrent files.

linuxppc_2_4_devel/drivers/char/sysrq.c (line: 35)
extern void wakeup_bdflush(int);

linuxppc_2_4_devel/include/linux/fs.h (line: 1347)
extern void wakeup_bdflush(void);


MATSUURA Takanori @ Division of Protein Chemistry,
                     Institute for Protein Research, Osaka University, Japan
E-Mail: t-matsuu@protein.osaka-u.ac.jp
Web Page: http://chux1.protein.osaka-u.ac.jp/~t-matsuu/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
