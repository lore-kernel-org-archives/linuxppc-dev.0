Return-Path: <a.korud@vector.com.pl>
Received: from mail-ex.vector.com.pl (mail-ex.vector.com.pl [81.210.9.37])
	by ozlabs.org (Postfix) with ESMTP id C2430DDE05
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 22:48:14 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Anyone success with 440GR Rev.B (1.1)?
Date: Fri, 2 Feb 2007 12:35:46 +0100
Message-ID: <60E856FD577CC04BA3727AF4122D3F1601238644@3bit.vector.com.pl>
From: "Andriy Korud" <a.korud@vector.com.pl>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I have complete system (U-Boot, Linux, userspace) running on 440GR =
Rev.A.=20
However after mounting newer chip revision (Rev.B, 1.1) U-Boot and Linux =
boots fine, however when trying to execute first userland application =
(init), I get:

Freeing unused kernel memory: 112k init
init has generated signal 4 but has no handler for it
Kernel panic - not syncing: Attempted to kill init!

I've tried everything - different compilers (3.x, 4.1.x), deifferent =
kernels (2.6.18, 19) - problem is 100% reproducible. Even when replaced =
busybox with printf("hello world") - the same.=20
According to AMCC changelog and erratas there are no changes in CPU core =
between revisions.=20

Anybody has an idea what should I check/try?

Thanks in advance,
--
Andriy Korud
