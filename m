Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 92A9A68897
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 19:55:40 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 9B97629EBC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 09:54:00 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 14137-05 for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 09:53:59 +0100 (CET)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id BEFB029EBB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 09:53:59 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Date: Thu, 8 Dec 2005 09:55:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200512080955.32504.david.jander@protonic.nl>
Subject: HR posix timers on mpc8xx??
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

With 2.6 now relatively stable running on mpc8xx, I was wondering if someone 
has tried to patch in support for High-resolution Posix-timers, as from here:
http://sourceforge.net/projects/high-res-timers

It sounds really attractive, and I wonder why this still isn't officially part 
of 2.6?

There is a patch for 2.6.10 for ppc, but I wonder if someone managed to port 
it to 2.6.14 (or later) and runs it on an mpc8xx.

Greetings,

-- 
David Jander
