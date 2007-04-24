Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9649BDDEB8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 16:16:13 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HgEJu-00029y-3t
	for linuxppc-embedded@ozlabs.org; Mon, 23 Apr 2007 23:16:10 -0700
Message-ID: <10155023.post@talk.nabble.com>
Date: Mon, 23 Apr 2007 23:16:10 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: prob on 2 ethrnet working
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

In my board(MPC8248) i have u-boot-1.1.2 configured with FCC1 as configured
ethernet port.
i m able to download the kernel and ramdisk image from tftpboot.
and after that i usually configure the ethernet port by assiging ips
eth0:192.168.33.64 and 
eth1:192.168.174.231 ,subnet mask:255.255.255.0 and default gateway
:192.168.32.47 eth0 and 192.168.174.47 eth1.

an after that i enable lo (ifconfig lo 127.0.0.1) option in kernel.

Now My requiremnt is to have both the ethernet port to be working
physically.
so i ping to both board ips(192.168.33.64 & 192.168.33.66).
But what i found out is if FCC1 is configured as eth port at u-boot time
then pinging will work untill FCC1 eth cabel
is connected to RJ45 port.ie. cable connected at FCC2 port doesnot have any
effect.
and it seems to be both the port is dependent on the FCC1 port only.


Can anybody suggest what might be the issue?


-- 
View this message in context: http://www.nabble.com/prob-on-2-ethrnet-working-tf3636663.html#a10155023
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
