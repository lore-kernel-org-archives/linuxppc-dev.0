Return-Path: <chiradeep@matissenetworks.com>
Received: from matisse01.matissenetworks.com
	(h-66-166-77-18.snvacaid.covad.net [66.166.77.18])
	by ozlabs.org (Postfix) with ESMTP id A1369679E3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Apr 2005 05:25:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Fri, 29 Apr 2005 12:25:03 -0700
Message-ID: <F237EFC9919B064C8BF5A44CDA5DA0C212F68E@matisse01.matissenetworks.com>
From: "Chiradeep Vittal" <chiradeep@matissenetworks.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: gdb with pthreads on MPC8540
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Has anybody got gdb 6.x working with the e500 (MPC85xx) to do
multithreaded debugging?
gdb gets a SIGTRAP upon a pthread_create, but doesn't seem to know what
to do with it. Seems like a simple configuration issue...

Configuration tested: Linux 2.4.26 on MPC8540 ADS derivative,
powerpc-8540-linux-gnu-gcc-3.4.3, libc-2.3.2 (libc.so.6), gdb (native)
6.2

Thanks
--
Chiradeep
