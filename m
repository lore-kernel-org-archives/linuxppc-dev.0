Return-Path: <arrigo@vision.caltech.edu>
Received: from kla-tencor.com (smtp.kla-tencor.com [192.146.1.134])
	by ozlabs.org (Postfix) with ESMTP id 6032A2BDEB
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Nov 2004 07:14:07 +1100 (EST)
Received: from [10.35.5.214] ([10.35.5.214])
	by kla-tencor.com (8.11.6+Sun/KLAC-1.0i) with ESMTP id iA3KDwj12157
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Nov 2004 12:13:58 -0800 (PST)
Message-ID: <41893BFB.1010903@vision.caltech.edu>
Date: Wed, 03 Nov 2004 12:13:47 -0800
From: Arrigo Benedetti <arrigo@vision.caltech.edu>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: printk problems
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For some reason I can't get printk() to work on a YDL 4.0 system. I have 
followed all the instructions, like
setting the correct log level in /proc/sys/kernel/printk, killing klogd 
and then

cat /proc/kmsg

but I do not see any message from printk. The printk is in a new kernel 
system call that I wrote.
Any ideas?

thanks much
-Arrigo
