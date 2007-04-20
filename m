Return-Path: <bwarren@qstreams.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id EC98CDDE48
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Apr 2007 04:02:08 +1000 (EST)
Subject: POSIX semaphores on ppc_6xx
From: Ben Warren <bwarren@qstreams.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 20 Apr 2007 13:55:26 -0400
Message-Id: <1177091726.3904.21.camel@saruman.qstreams.net>
Mime-Version: 1.0
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

The cross-compiled glibc that is included in ELDK 4.0 doesn't seem to
have support for POSIX semaphores.  I get the following runtime errors:

   sem_open: Function not implemented

when trying to implement a named semaphore, and 

   sem_init: Function not implemented

when trying to implement an unnamed semaphore.

Does anybody know if POSIX semaphores have been ported to ppc_6xx, and
if so, where I could find a binary copy?

thanks,
Ben
