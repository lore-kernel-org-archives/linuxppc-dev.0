Date: Thu, 10 Jul 2003 02:58:21 -0500 (CDT)
From: "Milton D. Miller II" <miltonm@realtime.net>
Message-Id: <200307100758.h6A7wK7a073057@sullivan.realtime.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re:  Making 2.5 kernels
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Even with -nostdinc -iwithprefix include  -Iinclude
you seem to be picking up /usr/include/net/route.h
instead of include/net/route.h.   The kernel version
doesn't include features.  Maybe unpack your source
again?   Either that or -iwithprefix is picking up
/usr/include/ instead of the gcc includes (eg stdarg.h).

milton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
