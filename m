Mime-Version: 1.0
Message-Id: <p0433010bb7cebf4c3df9@[63.220.231.138]>
Date: Wed, 19 Sep 2001 17:34:26 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: 2.4.10-pre12 sysrq.c compile error
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


rsynced mvista today, linuxppc_2_4:

sysrq.c:35: conflicting types for `wakeup_bdflush'
/usr/src/linuxppc_2_4/include/linux/fs.h:1347: previous declaration
of `wakeup_bdflush'
make[3]: *** [sysrq.o] Error 1
make[3]: Leaving directory `/usr/src/linuxppc_2_4/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linuxppc_2_4/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/linuxppc_2_4/drivers'
make: *** [_dir_drivers] Error 2


Help?


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
