Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: how to link a posix function
Date: Thu, 12 Feb 2004 17:12:30 +0800
Message-ID: <000b01c3f148$585a2d30$b702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20040212060756.GG2200@adapter.n0skillz.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I wrote a program that used some POSIX function such as timer_create(),
timer_settime(), timer_delete(). But, it is report "undefined reference
to 'timer_create', etc.." when linking.

my question is: how to link with POSIX lib?

I know I must add "-lpthread" flag in Makefile when linking
pthread_create() function.

Best Regards,
John

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
