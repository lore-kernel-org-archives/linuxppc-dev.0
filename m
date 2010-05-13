Return-Path: <pacman@kosh.dhis.org>
Received: from kosh.dhis.org (c-98-226-122-10.hsd1.in.comcast.net
	[98.226.122.10]) by ozlabs.org (Postfix) with SMTP id E594CB7DE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 May 2010 14:20:11 +1000 (EST)
Message-ID: <20100513041329.1972.qmail@kosh.dhis.org>
From: pacman@kosh.dhis.org
Subject: "event-scan failed" logflood
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 May 2010 23:13:29 -0500 (GMT+5)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I upgraded the kernel on my Pegasos from 2.6.32 to 2.6.33 and now it sends
the message "event-scan failed" to the kernel log about 60 times per second
as long as it's running.

The message comes from arch/powerpc/kernel/rtasd.c but I don't know what's
going on in there so I can't say much more about it.

How may I help find the cause of this problem?

(Or alternatively: what is the correct way to disable this "event-scan"? I
suspect it's not really necessary since it didn't exist in the previous
kernel version, and the system is running perfectly aside from the error
message flood.)

-- 
Alan Curry
