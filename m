Return-Path: <Murray.Jensen@csiro.au>
Received: from act-ironport-ext-out3.csiro.au (act-ironport-ext-out3.csiro.au
	[150.229.7.39]) by ozlabs.org (Postfix) with ESMTP id 8AC8067A7C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 21:53:55 +1100 (EST)
Message-Id: <6.2.0.14.0.20050318084944.01cd6018@localhost>
Date: Fri, 18 Mar 2005 08:53:53 +1100
To: Vlad L <vllv_lst@yahoo.com>, Embedded Linux <linuxppc-embedded@ozlabs.org>
From: Murray Jensen <Murray.Jensen@csiro.au>
In-Reply-To: <20050317082021.79119.qmail@web90204.mail.scd.yahoo.com>
References: <20050317082021.79119.qmail@web90204.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: Re: Posix message queue
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

At 07:20 PM 17/03/2005, Vlad L wrote:
>I have MPC5200 based board and looking for Posix
>Message Queue for kernel 2.4... Can you, please,
>direct me to resorce where I can load such patch or
>library.

I typed "linux posix message queues" into google and came up with these:

<http://lists.debian.org/debian-mentors/2004/07/msg00420.html>http://lists.debian.org/debian-mentors/2004/07/msg00420.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0211.3/1184.html
<http://www-users.mat.uni.torun.pl/~golbi/priv/index-en.html>http://www-users.mat.uni.torun.pl/~golbi/priv/index-en.html
http://www.geocities.com/wronski12/posix_ipc/index.html
<http://www.xenotime.net/linux/linux-posix.html>http://www.xenotime.net/linux/linux-posix.html
http://www.garret.ru/~knizhnik/sal.html
<http://lwn.net/Articles/52273/>http://lwn.net/Articles/52273/
http://lwn.net/Articles/52274/

The kernel code is for 2.6, but there are some user level implementations
that might be good enough. Cheers!
                                                                 Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

To the extent permitted by law, CSIRO does not represent, warrant and/or
guarantee that the integrity of this communication has been maintained or
that the communication is free of errors, virus, interception or interference.

The information contained in this e-mail may be confidential or privileged.
Any unauthorised use or disclosure is prohibited. If you have received this
e-mail in error, please delete it immediately and notify Murray Jensen on
+61 3 9662 7763. Thank you.
