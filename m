Message-ID: <20030722010608.73899.qmail@web11007.mail.yahoo.com>
Date: Mon, 21 Jul 2003 18:06:08 -0700 (PDT)
From: Xupei Liang <tliang@yahoo.com>
Subject: "alloc_area_pte: page already exists"
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am working on a PPC440 board running 2.4.19 kernel.
I am seeing this message when I try to boot up the
system. "alloc_area_pte: page already exists". I
am able to get a stack trace to show where it
comes from. The stack trace is shown as follows.

======= Stack trace begins =============

>>NIP; c002e474 <__vmalloc+0x164/0x234 [kernel]>
<=====
Trace; c002e474 <__vmalloc+0x164/0x234 [kernel]>
Trace; c019422c <copy_entries_to_user+0x40/0x2f0
[kernel]>
Trace; c019453c <get_entries+0x60/0xac [kernel]>
Trace; c0195148 <do_ipt_get_ctl+0x2a4/0x2cc [kernel]>
Trace; c0158190 <nf_sockopt+0x150/0x210 [kernel]>
Trace; c0158290 <nf_getsockopt+0x14/0x24 [kernel]>
Trace; c0168380 <ip_getsockopt+0x6f4/0x9ec [kernel]>
Trace; c01829fc <raw_getsockopt+0x1c/0x160 [kernel]>
Trace; c0189a8c <inet_getsockopt+0x20/0x30 [kernel]>
Trace; c01496f0 <sys_getsockopt+0x78/0x9c [kernel]>
Trace; c0149d9c <sys_socketcall+0x1ac/0x1e0 [kernel]>
Trace; c000353c <ret_from_syscall_1+0x0/0xb4 [kernel]>
Trace; 7fffccb8 <Unknown (0x7fffccb8)>
Trace; 10006de4 <Unknown (0x10006de4)>
Trace; 100018f4 <Unknown (0x100018f4)>
Trace; 10001d1c <Unknown (0x10001d1c)>
Trace; 0fefe7f8 <Unknown (0xfefe7f8)>
Trace; 00000000 <Unknown (0x0)>

============ Stack trace ends ================

It seems to me it is from vmalloc(). Has anybody
seen this problem before?

Thank you in advanced for your reply.

Regards,

Terry L.

Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
