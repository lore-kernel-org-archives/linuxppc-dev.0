Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id DBE5D68333
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 19:55:44 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id A595B29EC9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 11:52:33 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16948-01 for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 11:52:33 +0200 (CEST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 0374329EC6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 11:52:33 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 19 Sep 2005 11:55:36 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200509191155.36540.david.jander@protonic.nl>
Subject: Which way to store log in flash on mpc8xx?
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

I am looking for a reliable way to store logfiles in flash. The logfiles are 
written by syslogd.
The problem is that I am running on a MPC8xx processor, and kernel 2.6 is not 
quite there yet for that processor, so I have to stick with 2.4.
Kernel of choice seems to be denx linuxppc_2_4_devel, but I cannot trust the 
version of jffs2 used in that kernel anymore. Somtimes gc.c crashes with a 
BUG() in line 139, and sometimes processes are frozen for a looong time 
waiting for GC. I have debugged that problem a little bit, and definitely, 
the FLASH access works ok, and the chip is new. No CRC- or read-errors, but 
still gc.c crashes.
The version of mtd/jffs2 drivers in that kernel seem to be from march/2005 cvs 
code, but when I read the following, I get even more scared:
http://www.linux-mtd.infradead.org/source.html#kernelversions

So, I need something different. jffs (1) maybe ?
This must be a very common task (to store logfiles in flash), but I just can't 
seem to find the right way to do it.

Any advice is highly appreciated.

Sincerely,

-- 
David Jander
Protonic Holland.
