Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 4768DDDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Dec 2008 13:08:44 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L83Lk-0007KJ-JY
	for linuxppc-embedded@ozlabs.org; Thu, 04 Dec 2008 01:49:53 +0000
Received: from CPE-124-190-96-129.vic.bigpond.net.au ([124.190.96.129])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 04 Dec 2008 01:49:52 +0000
Received: from daniel_ng11 by CPE-124-190-96-129.vic.bigpond.net.au with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 04 Dec 2008 01:49:52 +0000
To: linuxppc-embedded@ozlabs.org
From: Daniel Ng <daniel_ng11@lycos.com>
Subject: i2c support for MPC 8247
Date: Thu, 4 Dec 2008 01:49:45 +0000 (UTC)
Message-ID: <loom.20081204T014044-850@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

We were successfully using drivers/i2c/busses/i2c-mpc8260.c for I2C support on 
a MPC8247 in Linux 2.6.14.

Now, we are wanting to upgrade our embedded system to Linux 2.6.24.

However, in 2.6.24, the file i2c-mpc8260.c doesn't exist. There is a i2c-mpc.c 
but this doesn't seem to handle the MPC8247. This is because I get the 
following message when I try to access the I2C device:

"/dev/i2c-0: No such device"

Perhaps the i2c-mpc.c driver uses a different device node? There is nothing in 
the i2c-mpc.c file which specifies a particular dev node.

Is I2C supported on the MPC8247 in Linux 2.6.24?

If so, what is the appropriate driver file?

Cheers,
Daniel
