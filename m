Message-Id: <20000906044141.Postino-015892@smtp01.highway.ne.jp>
Date: Wed, 6 Sep 2000 04:41:41 +0900
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: copy_to_user_ret in 2.4.0-test8
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I tried to compile today's linux-2.4.0-test8.
rtc.c has copy_to_user_ret untill,
but new uaccess.h hasn't copy_to_user_ret.
So I couldn't compile today's 2.4.0-test8.

Kaoru

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
