Date: Mon, 3 Dec 2001 14:46:14 +0100
From: "marc. h." <heckmann@hbe.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.16-pre1 (stock) breaks java?
Message-ID: <20011203144613.B1231@hbe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I recently installed 2.4.16-pre1 from the stock tree on my powerbook G3 and it
seems that it broke the IBM JDK (1.3.0). An strace just shows an endless
stream of "sched_yield()" with the CPU pegged at almost 100% system time.

This does not happen with 2.4.15-pre1 (also stock). Another datapoint is that
it does not seem to break the blackdown JVM.

The IBM JDK is available from ftp://ftp.suse.com/pub/suse/ppc/update/7.1/pay2

I am using glibc-2.2.4 from Mandrake cooker (binary).

It seems that some scheduling changes went into 2.4.15-pre9 (SCHED_FIFO).

Anyone have any ideas? The blackdown JVM has no JIT and is little painful to
use.

-m

--
	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
	key: http://people.hbesoftware.com/~heckmann/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
