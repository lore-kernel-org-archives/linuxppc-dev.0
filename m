Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Memory Pre-allocation (mem=xxx)
Date: Fri, 22 Feb 2002 16:42:46 -0800
Message-ID: <8A098FDFC6EED94B872CA2033711F86F0ABD0C@orion.ariodata.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
From: "David C. Chiu" <dchiu@ariodata.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We're working on a project that requires a two megabytes block of
contiguous memory in kernel space. Although it is well documented that
memory can be reserved by using mem=xx arguments during boot time, it is
unclear (to me) as to how a driver can automatically detect the size of
the said reserved block.

At this moment I am 'cheating' by inserting a global variable to save a
copy of total_memory before it gets replaced by __max_memory in
arch/ppc/mm/init.c so that the saved total_memory (containing the real
physical memory size passed in from boot block) is available to my
driver. But I can't help but to feel there has to be a better way to
determine the reserved buffer size. Is there something else that will do
this without having to modify the kernel?

Any comment is appreciated.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
