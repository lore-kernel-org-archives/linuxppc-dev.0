Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 870FB67A33
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 11:17:58 +1000 (EST)
To: Edward Hong <edward.qin.hong@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 03 Jun 2005 17:10:51 MDT."
	<21fb73bc05060316102325f94d@mail.gmail.com>
Date: Sat, 04 Jun 2005 03:17:31 +0200
Sender: wd@denx.de
Message-Id: <20050604011736.B199EC1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel ported from ELDK 3.0 hangs (loops in idled()) on my
	custom MPC870 Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <21fb73bc05060316102325f94d@mail.gmail.com> you wrote:
> I am trying to bring up Linux on a custom MPC870 Board using ELDK 3.0. 

Why are you using old (not to say ancient) tools?

> The ported kernel from ELDK 3.0 hangs (loops in idled()) and the kernel_thread 
> init never gets started!???

How do you know that init didn't  run?  Runningthe  idle  loop  is  a
perfectly normal situation.

> Linux version 2.4.24-pre2 (ehong@chico) (gcc version 3.2.2 20030217 (Yellow
> Dog Linux 3.0 3.2.2-2a_1)) #8 Fri Jun 3 10:13:10 MDT 2005 On node 0 
> totalpages: 16384
> zone(0): 16384 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/nfs rw nfsroot=10.15.10.170:/opt/eldk/pp
> c_8xx 
> ip=10.15.2.101:10.15.10.170::::eth0:off panic=1
> Decrementer Frequency = 495000000/60
> Calibrating delay loop... 131.48 BogoMIPS
> Memory: 63132k available (1204k kernel code, 360k data, 60k init, 0k highme
> m)
> Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
> Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
> Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
> POSIX conformance testing by UNIFIX
> 
> 
> (kernel loops in idled() after kernel_thread(init, ...) in rest_init().) 

Are you sure that your kernel configuration is sensible? For example,
did you configure a console port that matches your hardware? Did  you
configure the serial ports (SMC / SCC) at all?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I read part of it all the way through.
