Return-Path: <blueskyjb@verizon.net>
Received: from vms044pub.verizon.net (vms044pub.verizon.net [206.46.252.44])
	by ozlabs.org (Postfix) with ESMTP id A329FDDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 13:54:23 +1100 (EST)
Received: from [192.168.0.3] ([71.106.180.164])
	by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JBZ00MVUP9SF1S0@vms044.mailsrvcs.net> for
	linuxppc-embedded@ozlabs.org; Tue, 16 Jan 2007 19:53:53 -0600 (CST)
Date: Tue, 16 Jan 2007 17:53:47 -0800
From: Jimmy Blair <blueskyjb@verizon.net>
Subject: Problem getting machine check reset on 8245
To: linuxppc-embedded@ozlabs.org
Message-id: <45AD81AB.4010709@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I implemented do_reset in Linux 2.6 using the
reset method of U-Boot -- turn off the MMU and write
to an invalid address.  Sometimes I the desired reboot.
If I change the code a bit (e.g. put a 'nop' just ahead
of turning off the MMU), I'll get an "Invalid floating
point instruction" exception.  How is that possible??
I didn't thing printk shouldn't would work if the MMU is turned off.
Has anybody seen anything like this?? Thanks!
